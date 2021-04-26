//
//  Models.swift
//  SwiftChat
//
//  Created by Mikhail on 23.04.2021.
//

import Foundation
import RealmSwift

class ChatModel: Object {
    
    @objc dynamic var titleChat: String = ""
    
    @objc dynamic var timeChat = Date()
    
    let messages = List<MessagesModel>()
//    var timeChatString: String {
//    let dateNow = DateFormatter()
//        dateNow.dateFormat = "HH:mm"
//        let timeString = dateNow.string(from: timeChat)
//
//        return timeString
//    }
    
}
