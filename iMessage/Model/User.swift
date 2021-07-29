//
//  User.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 13.06.21.
//

import UIKit

struct User {
    
    let uid: String
    let profileImageUrl: String
    let username: String
    let name: String
    let email: String
    
    init(dictionary: [String: Any]) {
        
        self.username = dictionary["username"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        
    }
    
}
