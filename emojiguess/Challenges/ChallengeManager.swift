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
    var databaseManager:DatabaseManager = DatabaseManager()
    
    func refreshChallenges(completion: @escaping () -> Void) {
        self.databaseManager.ref?.child("challenges").observeSingleEvent(of: .value, with: { (snapshot) in
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
        self.databaseManager.getChallengeItemsRef().child(challenge.key).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var newItems: [ChallengeItem] = []
            for item in snapshot.children {
                let challengeItem = ChallengeItem(snapshot: item as! DataSnapshot)
                newItems.append(challengeItem)
            }
            
            completion(newItems)
        })
    }
    
    func createChallenge(challenge: Challenge, completion: @escaping () -> Void) {
        var timeStamp = String(Int64(Date.timeIntervalSinceReferenceDate * 1000))
        
        if (challenge.key != "") {
            timeStamp = challenge.key
        }
        
        self.databaseManager.getChallengesRef().child(timeStamp).setValue(challenge.toAnyObject(), withCompletionBlock: { (error, ref) in
            self.databaseManager.getChallengeItemsRef().child(timeStamp).setValue(challenge.challengeItemsToAnyObject(), withCompletionBlock: { (error, ref) in
                self.databaseManager.getUsersRef().child((UserManager.sharedInstance.user?.id)!).child("challenges").child(timeStamp).setValue("true", withCompletionBlock: { (error, ref) in
                    completion()
                })
            })
        })
    }
    
    func deleteChallenge(challenge: Challenge, completion: @escaping () -> Void) {
        challenge.ref?.removeValue(completionBlock: { (error, ref) in
            self.databaseManager.getChallengeItemsRef().child(challenge.key).removeValue(completionBlock: { (erroer, ref) in
                self.refreshChallenges {
                    completion()
                }
            })
        })
    }
}
