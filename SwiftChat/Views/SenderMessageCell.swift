//
//  ChatCollectionViewCell.swift
//  SwiftChat
//
//  Created by Mikhail on 22.04.2021.
//

import UIKit

class SenderMessageCell: UICollectionViewCell {
    
    @IBOutlet weak var senderMessageTextLabel: UILabel!  {
        didSet {
            senderMessageTextLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            senderMessageTextLabel.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
            senderMessageTextLabel.layer.cornerRadius = 4
            senderMessageTextLabel.layer.masksToBounds = false
            senderMessageTextLabel.font = UIFont.italicSystemFont(ofSize: 15)
        }
    }
    
    @IBOutlet weak var senderMessageTimeLabel: UILabel! {
        didSet {
            senderMessageTimeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            senderMessageTimeLabel.font = UIFont.systemFont(ofSize: 11)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 4
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
    
    func configureCell(object: MessagesModel) {
        self.senderMessageTextLabel.text = object.titleMessage
        let dateNow = DateFormatter()
        dateNow.dateFormat = "HH:mm"
        let timeString = dateNow.string(from: object.timeMessage)
        self.senderMessageTimeLabel.text = timeString
    }
}
