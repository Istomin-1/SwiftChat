//
//  MessagesViewController.swift
//  SwiftChat
//
//  Created by Mikhail on 24.04.2021.
//

import UIKit
import RealmSwift

class MessagesViewController: UIViewController {
    
    private var activityIndicator = UIActivityIndicatorView()
    
    var currentMessages: ChatModel!
    
    var messagesReceived: Results<MessagesModel>!
    var messagesSent: Results<MessagesModel>!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var messegesCollView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var inputViewContainer: NSLayoutConstraint!
    @IBOutlet weak var sendMessageButton: UIButton! {
        didSet {
            let sendButton = UIImage(imageLiteralResourceName: "iconSend").withTintColor(#colorLiteral(red: 0.9152800441, green: 0.2042200863, blue: 0.2038599253, alpha: 1))
            sendMessageButton.setImage(sendButton, for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegate()
        filteringTasks()
        manageInputEventsForTheSubViews()
        self.navigationItem.title = currentMessages.titleChat
        sendMessageButton.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .selected)
        
}
    
    private func filteringTasks() {
//        messagesSent = currentMessages.messages.sorted(byKeyPath: "date", ascending: false)
        messagesReceived = currentMessages.messages.sorted(byKeyPath: "timeMessage", ascending: true)
//        messagesSent = currentMessages.messages.filter("sender = false")
    }
    
    private func assignDelegate() {
        
        self.messegesCollView.dataSource = self
        self.messegesCollView.delegate = self
        
//        self.messageTextField.delegate = self
    }
    
    @IBAction func sendMessage(_ sender: UIButton?) {
        
        guard let newMessage = messageTextField.text, !newMessage.isEmpty else { return }
//        messageTextField.text = ""
        let message = MessagesModel()
        message.titleMessage = newMessage
        message.sender = Bool.random()
        
        StorageManager.saveMessage(self.currentMessages, message: message)
        messegesCollView.reloadData()
        
        
        let lastItem = self.messagesReceived.count - 1
        let indexPath = IndexPath(item: lastItem, section: 0)
        //        self.chatCollView.insertItems(at: [indexPath])
        self.messegesCollView.scrollToItem(at: indexPath, at: .bottom, animated: true)
//       if let mess = messageTextField.text, !mess.isEmpty {
//
//        }
//        filteringTasks()
//        chats.append(newChat)
//        tableView.insertSections(indexSet, with: .right)
        
    }
    
    private func manageInputEventsForTheSubViews() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotfHandler(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotfHandler(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardFrameChangeNotfHandler(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            inputViewContainer.constant = isKeyboardShowing ? keyboardFrame.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                
                if isKeyboardShowing {
                    let lastItem = self.messagesReceived.count - 1
                    let indexPath = IndexPath(item: lastItem, section: 0)
                    self.messegesCollView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            })
        }
    }
}

extension MessagesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if messagesReceived.count != 0 {
        return messagesReceived.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let message = messagesReceived[indexPath.item]
        if message.sender {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCellSender", for: indexPath) as! SenderMessageCell
            
            cell.layer.cornerRadius = 4
            cell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 4
            cell.layer.masksToBounds = false
            
            
            
            cell.senderMessageTextLabel.text = message.titleMessage
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCellRecipient", for: indexPath) as! RecipientMessageCell
            
            cell.layer.cornerRadius = 4
            cell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 4
            cell.layer.masksToBounds = false
            
            
            
            cell.recipientMessageText.text = message.titleMessage
            
            return cell
        }
    }
    
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
    
//    func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//            let attributes = layoutAttributesForElements(in: rect)
//
//            var leftMargin = sectionInset.left
//            var maxY: CGFloat = -1.0
//            attributes?.forEach { layoutAttribute in
//                guard layoutAttribute.representedElementCategory == .cell else {
//                    return
//                }
//                if layoutAttribute.frame.origin.y >= maxY {
//                    leftMargin = sectionInset.left
//                }
//
//                layoutAttribute.frame.origin.x = leftMargin
//
//                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
//                maxY = max(layoutAttribute.frame.maxY , maxY)
//            }
//            return attributes
//        }
    }
    

    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let message = messages[indexPath.item]
//
//        let messageCell = cell as! MessagesCell
//        messageCell.titleMessage.text = message.titleMessage
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.view.endEditing(true)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let message = messages[indexPath.item]
//        let size = CGSize(width: 250, height: 1000)
//        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//        var customFrame = NSString(string: message.titleMessage).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], context: nil)
//        customFrame.size.height += 15
//
//
//        return CGSize(width: messegesCollView.frame.width, height: customFrame.height + 20)
//    }
//}
//
//        let size = CGSize(width: 250, height: 1000)
//        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//        var customFrame = NSString(string: message.titleMessage).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], context:  nil)
//        customFrame.size.height += 15
//
////        let maxValue = max(customFrame.width, customFrame.height)
//
//        if message.sender {
//            cell.titleMessage.textAlignment = .left
//            cell.messageTextView.frame = CGRect(x: 48 + 8, y: 12, width: customFrame.width + 16, height: customFrame.height + 20)
//            cell.textBubbleView.frame = CGRect(x: 48 - 10, y: -4, width: customFrame.width + 12, height: customFrame.height + 20)
//            cell.textBubbleView.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//            cell.messageTextView.textColor = #colorLiteral(red: 0.9152800441, green: 0.2042200863, blue: 0.2038599253, alpha: 1)
//        } else {
//            cell.titleMessage.textAlignment = .right
//            cell.messageTextView.frame = CGRect(x: collectionView.bounds.width - customFrame.width - 16, y: 0, width: customFrame.width + 16, height: customFrame.height + 20)
//            cell.textBubbleView.frame = CGRect(x:collectionView.frame.width - customFrame.width - 16, y: -4, width: customFrame.width + 16, height: customFrame.height + 20)
//            cell.textBubbleView.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//            cell.messageTextView.textColor = #colorLiteral(red: 0.9152800441, green: 0.2042200863, blue: 0.2038599253, alpha: 1)
//        }


extension MessagesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let txt = textField.text, txt.count >= 1 {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.resignFirstResponder()
        sendMessage(nil)
    }
}
