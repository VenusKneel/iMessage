//
//  LoginViewModel.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 12.06.21.
//

import Foundation

struct LoginViewModel {
    var email: String?
    var password: String?
    var username: String?
    var name: String?
    
    var signInFormIsValid: Bool {
        
        return email?.isEmpty == false &&
            password?.isEmpty == false
        
    }
    
    var signUpFormIsValid: Bool {
        
        return email?.isEmpty == false &&
            password?.isEmpty == false &&
            username?.isEmpty == false &&
            name?.isEmpty == false

    }
}
