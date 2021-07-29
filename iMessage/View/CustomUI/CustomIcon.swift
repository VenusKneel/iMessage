//
//  CustomIcon.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 11.06.21.
//

import UIKit

class CustomIcon: UIImageView {
    init(imageName: String, interaction: Bool) {
        super.init(frame: .zero)
        
        self.image = UIImage(systemName: imageName)
        self.clipsToBounds = true
        self.layer.cornerRadius = 50
        self.tintColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
