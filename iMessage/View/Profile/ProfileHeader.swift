//
//  ProfileHeader.swift
//  iMessage
//
//  Created by Beqa Tabunidze on 23.07.21.
//

import UIKit

protocol ProfileHeaderDelegate: AnyObject {
    
    func dismissController()
}

class ProfileHeader: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ProfileHeaderDelegate?
    var user: User? {
        
        didSet { populateUserData() }
        
    }
    
    private let dismissButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(dismissHandler), for: .touchUpInside)
        button.tintColor = .white
        button.imageView?.setDimensions(height: 22, width: 22)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4.0
        return iv
        
    }()
    
    private let fullNameLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Bequna"
        return label
        
    }()
    
    private let usernameLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Beqa"
        return label
        
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func configureUI() {
        
        backgroundColor = UIColor(named: "lightGreen")
        
        profileImageView.setDimensions(height: 200, width: 200)
        profileImageView.layer.cornerRadius = 200 / 2
        
        addSubview(profileImageView)
        profileImageView.centerX(inView: self)
        profileImageView.anchor(top: topAnchor, paddingTop: 100)
        
        let stack = UIStackView(arrangedSubviews: [fullNameLabel, usernameLabel])
        stack.axis = .vertical
        stack.spacing = 5
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: profileImageView.bottomAnchor, paddingTop: 16)
        
        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft: 12)
        dismissButton.setDimensions(height: 50, width: 50)
        
    }
    
    func populateUserData() {
        
        guard let user = user else { return }
        guard let url = URL(string: user.profileImageUrl) else { return }
        profileImageView.sd_setImage(with: url)
        fullNameLabel.text = user.name
        usernameLabel.text = "@\(user.username)"
        
    }
    
    // MARK: - Selectors
    
    @objc func dismissHandler() {
        
        delegate?.dismissController()
        
    }
    
}
