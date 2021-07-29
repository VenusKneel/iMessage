//
//  UserCell.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 13.06.21.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    
    // MARK: - Properties
    
    var user: User? {
        
        didSet { configure() }
        
    }
    
    private let smallProfileImage: UIImageView = {
        
        let iv = UIImageView()
        iv.backgroundColor = .systemRed
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        
        return iv
        
    }()
    
    private let usernameLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "VenusKneel"
        return label
        
    }()
    
    private let nameLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "Beqa Tabunidze"
        return label
        
    }()
    
    // MARK: - Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(smallProfileImage)
        smallProfileImage.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        smallProfileImage.setDimensions(height: 50, width: 50)
        smallProfileImage.layer.cornerRadius = 50 / 2
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, nameLabel])
        stack.axis = .vertical
        stack.spacing = 5
        addSubview(stack)
        stack.centerY(inView: smallProfileImage, leftAnchor: smallProfileImage.rightAnchor, paddingLeft: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    
    func configure() {
        
        guard let user = user else{ return }
        nameLabel.text = user.name
        usernameLabel.text = user.username
        
        guard let url = URL(string: user.profileImageUrl) else { return }
        smallProfileImage.sd_setImage(with: url)
        
    }
}
