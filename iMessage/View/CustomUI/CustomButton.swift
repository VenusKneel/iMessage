//
//  CustomButton.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 11.06.21.
//

import UIKit

class CustomButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor(named: "mediumGreen")
        self.setHeight(height: 54)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
