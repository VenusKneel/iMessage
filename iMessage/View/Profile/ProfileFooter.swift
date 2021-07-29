//
//  ProfileFooter.swift
//  iMessage
//
//  Created by Beqa Tabunidze on 25.07.21.
//

import UIKit

protocol ProfileFooterDelegate: AnyObject {
    func logoutHandler()
}

class ProfileFooter: UIView {
    
    weak var delegate: ProfileFooterDelegate?
    
    private lazy var logoutButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(named: "darkGreen")
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(logoutHandler), for: .touchUpInside)
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoutButton)
        logoutButton.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 32, paddingRight: 32, height: 50)
        logoutButton.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Selectors
    
    @objc func logoutHandler() {
        
        delegate?.logoutHandler()
        
    }
    
}
