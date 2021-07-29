//
//  CustomTextField.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 11.06.21.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String, security: Bool) {
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.textColor = .white
        self.isSecureTextEntry = security
        self.font = UIFont.systemFont(ofSize: 18)
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
