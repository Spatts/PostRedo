//
//  Post.swift
//  PostRedo
//
//  Created by Steven Patterson on 7/27/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import Foundation

struct Post {
    private let kUsername = "username"
    private let kText = "text"
    private let kTimestamp = "timestamp"
    private let kUUID = "uuid"
    
    let username: String
    let text: String
    let timestamp: NSTimeInterval
    let identifier: NSUUID
    

    init(username: String, text: String, identifier: NSUUID = NSUUID()) {
        
        self.username = username
        self.text = text
        self.timestamp = NSDate().timeIntervalSince1970
        self.identifier = identifier
    }
    
    init?(dictionary: [String: AnyObject], identifier: String) {
        
        guard let username = dictionary[kUsername] as? String,
            let text = dictionary[kText] as? String,
            let timestamp = dictionary[kTimestamp] as? Double,
            let identifier = NSUUID(UUIDString: identifier) else { return nil }
        
        self.username = username
        self.text = text
        self.timestamp = NSTimeInterval(floatLiteral: timestamp)
        self.identifier = identifier
    }

    var dictionaryRepresentation: [String: AnyObject] {
        return [kUsername : username, kText : text, kTimestamp : timestamp]
    }
    
    var jsonData: NSData? {
        return try? NSJSONSerialization.dataWithJSONObject(dictionaryRepresentation, options: .PrettyPrinted)
    }
}