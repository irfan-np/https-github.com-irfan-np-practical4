//
//  Message.swift
//  Telegramme
//
//  Created by MAD2_P02 on 25/11/19.
//  Copyright © 2019 MAD2_P02. All rights reserved.
//

import Foundation

class Message {
    
    var Date:Date
    var isSender:Bool
    var Text:String
    
    init(date:Date, issender:Bool, text:String) {
        Date = date
        isSender = issender
        Text = text
    }
}
