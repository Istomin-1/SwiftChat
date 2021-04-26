//
//  RecipientMessageCell.swift
//  SwiftChat
//
//  Created by Mikhail on 25.04.2021.
//

import UIKit

class RecipientMessageCell: UICollectionViewCell {
    
    @IBOutlet weak var recipientMessageText: UILabel! {
        didSet {
            recipientMessageText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            recipientMessageText.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            recipientMessageText.layer.cornerRadius = 4
            recipientMessageText.layer.masksToBounds = true
            recipientMessageText.font = UIFont.systemFont(ofSize: 15)
        }
    }
    
    @IBOutlet weak var recipientTime: UILabel! {
        didSet {
            recipientTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            recipientTime.font = UIFont.systemFont(ofSize: 11)
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
        self.recipientMessageText.text = object.titleMessage
        let dateNow = DateFormatter()
        dateNow.dateFormat = "HH:mm"
        let timeString = dateNow.string(from: object.timeMessage)
        self.recipientTime.text = timeString
    }
}
