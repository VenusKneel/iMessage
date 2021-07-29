//
//  ProfileViewModel.swift
//  iMessage
//
//  Created by Beqa Tabunidze on 25.07.21.
//

import UIKit

enum ProfileViewModel: Int, CaseIterable {
    
    case accountInfo
    case privacy
    case language
    case preferences
    case about
    
    var description: String {
        
        switch self {
        
        case .accountInfo: return "Personal Information"
        case .preferences: return "Preferences"
        case .about: return "About"
        case .privacy: return "Privacy"
        case .language: return "Language"
        
        }
    }
        
    var iconImageName: String {
            
        switch self {
            
        case .accountInfo: return "person.circle"
        case .preferences: return "gear"
        case .about: return "info.circle"
        case .privacy: return "lock"
        case .language: return "globe"
            
        }
            
    }
    
}
