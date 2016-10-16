//
//  ChatMessage.swift
//  Prototype1
//
//  Created by LiangZhanou on 2016-10-16.
//  Copyright © 2016 LiangZhanou. All rights reserved.
//

import Foundation

class ChatMessage {
    let sender : String
    let content : String
    
    init(sender:String, content:String){
        self.sender = sender
        self.content = content
    }
}
