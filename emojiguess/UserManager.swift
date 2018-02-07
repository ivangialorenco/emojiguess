//
//  UserManager.swift
//  emojiguess
//
//  Created by Ivan Gialorenco on 9/1/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class UserManager: NSObject {
    
    static let sharedInstance = UserManager()
    
    var user:User?
    
    func facebookInfo(completion: @escaping (User) -> Void) {
        let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name, last_name, email, picture.type(large)"])
        
        
            graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                
                if ((error) != nil) {
                    
                } else {
                    let data:[String:AnyObject] = result as! [String : AnyObject]
                    self.user = User(data: data);
                    completion(self.user!);
                }
            })
        

    }
}
