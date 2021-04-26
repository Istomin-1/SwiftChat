//
//  KeyboardExtension.swift
//  SwiftChat
//
//  Created by Mikhail on 26.04.2021.
//

import UIKit

extension MessagesViewController {
    
    func manageInputEventsForTheSubViews() {
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
                    let lastItem = self.currentMessages.count - 1
                    let indexPath = IndexPath(item: lastItem, section: 0)
                    self.messegesCollView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            })
        }
    }
}
