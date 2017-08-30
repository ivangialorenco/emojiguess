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
    let title: String
    var items:[ChallengeItem] = []
    let ref:DatabaseReference?
//
//    let peoplePlaying = 0
//    var peopleFinished = 0
    
    init(title: String, items:[ChallengeItem], key: String = "") {
        self.key = key
        self.title = title
        self.items = items
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
//        items = snapshotValue["items"] as! [ChallengeItem]
//        answer = snapshotValue["answer"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> (title: Any, challengeItems: Any) {
        var challengeItems:[Any] = []
        
        for item in items {
            challengeItems.append(item.toAnyObject().challengeItem)
        }
        
        return (
            title: ["title": title],
            challengeItems: challengeItems
        )
    }
}
