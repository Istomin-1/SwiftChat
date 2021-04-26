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
            titleChat.font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
    
    @IBOutlet weak var timeChat: UILabel! {
        didSet {
            timeChat.textColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
            timeChat.font = UIFont.systemFont(ofSize: 13)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentView.layer.cornerRadius = 8.0
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    func configureCell(object: ChatModel) {
        self.titleChat.text = object.titleChat
        let dateNow = DateFormatter()
        dateNow.dateFormat = "HH:mm"
        let timeString = dateNow.string(from: object.timeChat)
        self.timeChat.text = timeString
    }
}
