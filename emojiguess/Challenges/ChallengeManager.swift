//
//  EGChallengeManager.swift
//  emojiguess
//
//  Created by Ivan Gialorenço on 6/6/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChallengeManager: NSObject {
    var challenges:[Challenge] = []
    var databaseManager:DatabaseManager?
    
    func loadChallenges(completion: @escaping () -> Void) {
        databaseManager = DatabaseManager()
        
        databaseManager?.ref?.child("challenges").observe(.value, with: { (snapshot) in
            self.challenges.removeAll()
            var count:UInt = 0
            
            for item in snapshot.children {
                var challenge = Challenge(snapshot: item as! DataSnapshot)
                
                self.loadChallengeItems(challenge: challenge, completion: { (challengeItems) in
                    challenge.items = challengeItems
                    count = count + 1;
                    
                    self.challenges.append(challenge);
                    if (snapshot.childrenCount == count) {
                        completion()
                    }
                })
            }
        })
    }
    
    func loadChallengeItems(challenge: Challenge, completion: @escaping (_ challenge: [ChallengeItem]) -> Void) {
        databaseManager = DatabaseManager()
        
        databaseManager?.ref?.child("challengeItems/\(challenge.key)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var newItems: [ChallengeItem] = []
            for item in snapshot.children {
                let challengeItem = ChallengeItem(snapshot: item as! DataSnapshot)
                newItems.append(challengeItem)
            }
            
            completion(newItems)
        })
    }
    
    func createChallenge(challenge: Challenge, completion: @escaping () -> Void) {
        databaseManager = DatabaseManager()
        
        let timeStamp = String(Int64(Date.timeIntervalSinceReferenceDate * 1000))
        let challengeTuple = challenge.toAnyObject()
        
        databaseManager?.ref?.child("challenges").child(timeStamp).setValue(challengeTuple.title, withCompletionBlock: { (error, ref) in
            self.databaseManager?.ref?.child("challengeItems").child(timeStamp).setValue(challengeTuple.challengeItems, withCompletionBlock: { (error, ref) in
                completion()
            })
        })
    }
}
