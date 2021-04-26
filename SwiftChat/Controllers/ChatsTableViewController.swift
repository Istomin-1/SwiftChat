//
//  ChatsTableViewController.swift
//  SwiftChat
//
//  Created by Mikhail on 21.04.2021.
//

import UIKit
import RealmSwift

class ChatsTableViewController: UITableViewController {
    
    //    MARK: - Properties
    private var chats: Results<ChatModel>!
    private var viewNoСhats = UIView()
    private let cellSpacingHeight: CGFloat = 20
    
    //    MARK: - Outlets
    @IBOutlet var chatsTableView: UITableView!
    
    //    MARK: - Life Cicle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chats = localRealm.objects(ChatModel.self)
        viewNoСhats = showViewNoChats()
        checkViewNoChats()
        updateNavigationBar()
        addButtonAdd()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if chats.count != 0 {
            return chats.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatsCell", for: indexPath) as! ChatsTableViewCell
        
        let chat = chats[indexPath.section]
        cell.configureCell(object: chat)
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return header
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let chat = chats[indexPath.section]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (UIContextualAction, view, boolValue) in
            StorageManager.deleteChat(chat)
            let indexSet = IndexSet(arrayLiteral: indexPath.section)
            tableView.deleteSections(indexSet, with: .left)
            self.checkViewNoChats()
        }
        deleteAction.image = UIImage(imageLiteralResourceName: "iconDelete").withTintColor(UIColor.white)
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
    
    //    MARK: - Private Functions
    private func addButtonAdd() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "iconAdd"), style: .done,
                                                                 target: self,
                                                                 action: #selector(addChat))
    }
    @objc func addChat() {
        let index = chats.count + 1
        let indexSet = IndexSet(arrayLiteral: index - 1)
        
        let newChat = ChatModel()
        newChat.titleChat = "Chat № \(index)"
        
        StorageManager.saveChat(newChat)
        tableView.insertSections(indexSet, with: .right)
        checkViewNoChats()
    }
    
    private func showViewNoChats() -> UIView {
        let newView = UIView(frame: self.view.bounds)
        newView.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center.x = view.center.x
        label.center.y = view.center.y - 100
        label.text = "No chats yet"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        newView.addSubview(label)
        self.tableView.addSubview(newView)
        
        return newView
    }
    
    private func checkViewNoChats() {
        if chats.count > 0 {
            viewNoСhats.isHidden = true
        } else {
            viewNoСhats.isHidden = false
        }
    }
    
    //    MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let chat = chats[indexPath.section]
            let messagesCVC = segue.destination as! MessagesViewController
            messagesCVC.currentChat = chat
        }
    }
}
