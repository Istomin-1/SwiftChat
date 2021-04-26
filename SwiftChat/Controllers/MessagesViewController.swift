//
//  MessagesViewController.swift
//  SwiftChat
//
//  Created by Mikhail on 24.04.2021.
//

import UIKit
import RealmSwift

class MessagesViewController: UIViewController {
    
    //    MARK: - Properties
    var currentChat: ChatModel!
    var currentMessages: Results<MessagesModel>!
    
    //    MARK: - Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var messegesCollView: UICollectionView!
    @IBOutlet weak var inputViewContainer: NSLayoutConstraint!
    
    @IBOutlet weak var messageTextField: UITextField!{
        didSet {
            messageTextField.placeholder = "Enter your message..."
            messageTextField.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
            messageTextField.layer.cornerRadius = 5
            messageTextField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            messageTextField.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    @IBOutlet weak var toolBarView: UIView! {
        didSet {
//            toolBarView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            toolBarView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            toolBarView.layer.shadowOpacity = 0.5
            toolBarView.layer.shadowOffset = CGSize(width: 0, height: 2)
            toolBarView.layer.cornerRadius = 4
            toolBarView.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var sendMessageButton: UIButton! {
        didSet {
            let sendButton = UIImage(imageLiteralResourceName: "iconSend").withTintColor(#colorLiteral(red: 0.9152800441, green: 0.2042200863, blue: 0.2038599253, alpha: 1))
            sendMessageButton.setImage(sendButton, for: .normal)
        }
    }
    
    //    MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Chat"
        
        self.messegesCollView.dataSource = self
        self.messegesCollView.delegate = self
        
        filteredMessages()
        manageInputEventsForTheSubViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let lastMessage = currentMessages.last {
            StorageManager.editChat(currentChat, newChatTitle: lastMessage)
        }
    }
    
    //    MARK: - Functions
    private func filteredMessages() {
        currentMessages = currentChat.messages.sorted(byKeyPath: "timeMessage", ascending: true)
    }
    
    @IBAction func sendMessage(_ sender: UIButton?) {
        
        guard let newMessage = messageTextField.text, !newMessage.isEmpty else { return }
        
        let message = MessagesModel()
        message.titleMessage = newMessage
        message.sender = Bool.random()
        
        StorageManager.saveMessage(self.currentChat, message: message)
        messegesCollView.reloadData()
        
        let lastItem = self.currentMessages.count - 1
        let indexPath = IndexPath(item: lastItem, section: 0)
        self.messegesCollView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        
        messageTextField.text = nil
    }
}

// MARK: - Collection view data source + delegate
extension MessagesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentMessages.count != 0 {
            return currentMessages.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = currentMessages[indexPath.item]
        if message.sender {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCellSender",
                                                          for: indexPath) as! SenderMessageCell
            cell.configureCell(object: message)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCellRecipient",
                                                          for: indexPath) as! RecipientMessageCell
            cell.configureCell(object: message)
            
            return cell
        }
    }
    
    //    MARK: - Collection view delegate flow layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 234, height: 58)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

