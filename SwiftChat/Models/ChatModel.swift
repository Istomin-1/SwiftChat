//
//  Models.swift
//  SwiftChat
//
//  Created by Mikhail on 23.04.2021.
//

import RealmSwift

class ChatModel: Object {
    
    @objc dynamic var titleChat: String = ""
    @objc dynamic var timeChat = Date()
    let messages = List<MessagesModel>()
}
