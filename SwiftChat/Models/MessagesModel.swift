//
//  MessagesModel.swift
//  SwiftChat
//
//  Created by Mikhail on 23.04.2021.
//

import Foundation
import RealmSwift

class MessagesModel: Object {
    
    @objc dynamic var titleMessage: String = ""
    
    @objc dynamic var timeMessage = Date()
    
    @objc dynamic var sender: Bool = true
    
//    var timeMessageString: String {
//    let dateNow = DateFormatter()
//        dateNow.dateFormat = "HH:mm"
//        let timeString = dateNow.string(from: timeMessage)
//        
//        return timeString
//    }
}

