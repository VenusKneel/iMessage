//
//  ConversationViewModel.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 14.06.21.
//

import UIKit

struct ConversationViewModel {
    
    private let conversation: Conversation
    
    var profileImageUrl: URL? {
        
        return URL(string: conversation.user.profileImageUrl)
        
    }
    
    var timestamp: String {
        
        let date = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
        
    }
    
    init(conversation: Conversation) {
        
        self.conversation = conversation
        
    }
    
}
