//
//  EGChallenge.swift
//  emojiguess
//
//  Created by Ivan Gialorenço on 6/6/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Challenge {
    
    let key: String
    var title: String
    var items:[ChallengeItem] = []
    var creatorName:String
    let ref:DatabaseReference?
//
//    let peoplePlaying = 0
//    var peopleFinished = 0
    
    init(title: String, creatorName: String, items:[ChallengeItem], key: String = "") {
        self.key = key
        self.title = title
        self.creatorName = creatorName
        self.items = items
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        key = snapshot.key
        title = snapshotValue["title"] as! String
        creatorName = snapshotValue["creator"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> [String:Any] {
        return ["title": title, "creator": creatorName]
    }
    
    func challengeItemsToAnyObject() -> [Any] {
        var challengeItems:[Any] = []
        
        for item in items {
            challengeItems.append(item.toAnyObject().challengeItem)
        }
        
        return challengeItems
    }
}
