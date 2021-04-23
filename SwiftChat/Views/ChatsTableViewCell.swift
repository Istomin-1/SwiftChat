//
//  ChatsTableViewCell.swift
//  SwiftChat
//
//  Created by Mikhail on 22.04.2021.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleChat: UILabel! {
        didSet {
            titleChat.textColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        }
    }
    
    @IBOutlet weak var timeChat: UILabel! {
        didSet {
            timeChat.textColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    func configureCell(object: ChatModel) {
        self.titleChat.text = object.titleChat
        self.timeChat.text = object.timeChatString
    }
}
