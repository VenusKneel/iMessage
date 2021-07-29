//
//  InputContainerView.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 11.06.21.
//

import UIKit

class InputContainerView: UIView {
    
    init(image: UIImage?, textField: UITextField) {
        super.init(frame: .zero)
        
        setHeight(height: 54)
        
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .white
        iv.alpha = 0.8 
        
        addSubview(iv)
        iv.centerY(inView: self)
        iv.anchor(left: self.leftAnchor, paddingLeft: 10)
        iv.setDimensions(height: 25, width: 30)
        
        addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(left: iv.rightAnchor,
                         bottom: self.bottomAnchor,
                         right: self.rightAnchor,
                         paddingLeft: 8
        )
        
        let divider = UIView()
        divider.backgroundColor = .white
        addSubview(divider)
        divider.anchor(left: leftAnchor,
                       bottom: bottomAnchor,
                       right: rightAnchor,
                       paddingLeft: 8,
                       height: 1
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
