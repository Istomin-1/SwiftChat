//
//  Models.swift
//  SwiftChat
//
//  Created by Mikhail on 23.04.2021.
//

import Foundation

struct ChatModel {
    
    let titleChat: String
    
    let timeChat: Date
    var timeChatString: String {
    let time = timeChat
    let dateNow = DateFormatter()
        dateNow.dateFormat = "HH:mm"
        
        let timeString = dateNow.string(from: time)
        
        return timeString
    }
//    init(chatModel: ChatModel) {
//        titleChat = chatModel.titleChat
//        timeChat = Date()
//    }
    
}
