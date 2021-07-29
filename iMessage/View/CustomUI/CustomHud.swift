//
//  CustomHud.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 13.06.21.
//

import UIKit
import JGProgressHUD

class CustomHud: JGProgressHUD {
    
    init(hudText: String) {
        super.init(frame: .zero)
    
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = hudText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
