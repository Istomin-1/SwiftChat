//
//  ChatsTableViewController.swift
//  SwiftChat
//
//  Created by Mikhail on 21.04.2021.
//

import UIKit
import RealmSwift

class ChatsTableViewController: UITableViewController {
    
    var chats: Results<ChatModel>!
    
    var one = UIView()

    @IBOutlet var chatsTableView: UITableView!
 
    let cellSpacingHeight: CGFloat = 16
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chats = localRealm.objects(ChatModel.self)
        
                
        one = startApp()
        startScreen()
        updateTabBar()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "iconAdd"), style: .done, target: self, action: #selector(addChat))
    }
    
    @objc func addChat() {
        
        let index = chats.count + 1
        let indexSet = IndexSet(arrayLiteral: index - 1)
        
        let newChat = ChatModel()
        newChat.titleChat = "Hello"
        
        StorageManager.saveChats(newChat)
//        chats.append(newChat)
        tableView.insertSections(indexSet, with: .right)
        startScreen()
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                
        return cellSpacingHeight
//            chats.count > 0 ? cellSpacingHeight : 250
    }
    
//        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            let label = UILabel()
//            label.text = "No chats yet"
//            label.textAlignment = .center
//            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//            return label
//            }
    
    func startScreen() {
        if chats.count > 0 {
            one.isHidden = true
        } else {
            one.isHidden = false
        }
    }
    
    func startApp() -> UIView {
        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        newView.backgroundColor = UIColor.white
        self.tableView.addSubview(newView)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center.x = view.center.x
        label.center.y = view.center.y - 100
        label.text = "No chats yet"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        newView.addSubview(label)
        
        return newView
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let chat = chats[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (UIContextualAction, view, boolValue) in
            StorageManager.deleteChat(chat)
            let indexSet = IndexSet(arrayLiteral: indexPath.section)
            tableView.deleteSections(indexSet, with: .left)
            self.startScreen()
        }
        deleteAction.image = UIImage(imageLiteralResourceName: "iconDelete").withTintColor(UIColor.white)
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatsCell", for: indexPath) as! ChatsTableViewCell
        
        cell.contentView.backgroundColor = .black
        cell.contentView.layer.cornerRadius = 8.0

        let chat = chats[indexPath.section]
        
        cell.configureCell(object: chat)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let chat = chats[indexPath.section]
            let messagesCVC = segue.destination as! MessagesViewController
            messagesCVC.currentMessages = chat
        }
    }
}
