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
}
