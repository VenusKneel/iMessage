//
//  MessageViewModel.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 14.06.21.
//

import UIKit

struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        
        return message.isFromCurrentUser ? #colorLiteral(red: 0.3803921569, green: 0.8666666667, blue: 0.5647058824, alpha: 1) : #colorLiteral(red: 0.2509803922, green: 0.5294117647, blue: 0.5450980392, alpha: 1)
        
    }
    
    var messageTextColor: UIColor {
        
        return message.isFromCurrentUser ? .white : .white
        
    }
    
    var rightAnchorActive: Bool {
        
        return message.isFromCurrentUser
        
    }
    
    var leftAnchorActive: Bool {
        
        return !message.isFromCurrentUser
        
    }
    
    var hideProfileImage: Bool {
        
        return message.isFromCurrentUser
        
    }
    
    var profileImageUrl: URL? {
        
        guard let user = message.user else { return nil }
        return URL(string: user.profileImageUrl)
        
    }
    
    init(message: Message) {
        
        self.message = message
    }
    
    
    
}
