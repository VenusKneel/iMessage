//
//  SignInAndUpButton.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 11.06.21.
//

import UIKit

class SignInAndUpButton: UIButton {
    
    init(baseText: String, supportingText: String) {
        super.init(frame: .zero)
        
        let attributedTitle = NSMutableAttributedString(string: baseText,
                                                        attributes: [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: supportingText,
                                                  attributes: [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.white]))
        self.setAttributedTitle(attributedTitle, for: .normal)
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    
    
}
