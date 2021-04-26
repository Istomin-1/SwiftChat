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
        }
 }
    @IBOutlet weak var recipientTime: UILabel! {
        didSet {
            recipientTime.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
 }
}
