//
//  DatabaseManager.swift
//  emojiguess
//
//  Created by Ivan Gialorenço on 6/28/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DatabaseManager {
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func getUsersRef() -> DatabaseReference{
        return ref.child("Users")
    }
    
    func getChallengesRef() -> DatabaseReference{
        return ref.child("challenges")
    }
    
    func getChallengeItemsRef() -> DatabaseReference{
        return ref.child("challengeItems")
    }
}
