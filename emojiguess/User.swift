//
//  User.swift
//  emojiguess
//
//  Created by Ivan Gialorenco on 9/1/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit
import FirebaseDatabase

class User: NSObject {

    var id:String?
    var firstName:String?
    var lastName:String?
    var fullName:String?
    var profileURL:String?
    var ref:DatabaseReference?
    
    var challenges:[Challenge]?

    init(data:[String:AnyObject]) {
        print(data)
        
        self.id = data["id"] as? String
        self.firstName = data["first_name"] as? String
        self.lastName = data["last_name"] as? String
        self.fullName = self.firstName! + " " + self.lastName!
        
        let pictureValue = (data["picture"] as! [String: AnyObject])["data"] as! [String: AnyObject]

        self.profileURL = pictureValue["url"] as? String
        
        let databaseManager = DatabaseManager()
    }
    
    func isMyChallenge(challenge:Challenge) -> Bool {
        if (challenge.creatorName == (self.firstName! + " " + self.lastName!)) {
            return true
        }
        
        return false
    }
}
