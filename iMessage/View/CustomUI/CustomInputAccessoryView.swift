//
//  CustomInputAccessoryView.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 13.06.21.
//

import UIKit

protocol CustomInputAccessoryViewDelegate: AnyObject {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String)

}

class CustomInputAccessoryView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CustomInputAccessoryViewDelegate?
    
    private lazy var messageInputTextView: UITextView = {
        
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        return tv
        
    }()
    
    lazy var sendButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor(named: "darkGreen"), for: .normal)
        button.addTarget(self, action: #selector(sendMessageHandler), for: .touchUpInside)
        return button
        
    }()
    
    private let placeholderLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Enter message"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
        
    }()
    
    // MARK: - Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 15
        layer.shadowOffset = .init(width: 0, height: -10)
        layer.shadowColor = UIColor.lightGray.cgColor
        
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: 8)
        sendButton.setDimensions(height: 50, width: 50)
        
        addSubview(messageInputTextView)
        messageInputTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: sendButton.leftAnchor, paddingTop: 12, paddingLeft: 4, paddingBottom: 10, paddingRight: 8)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(left: messageInputTextView.leftAnchor, paddingLeft: 4)
        placeholderLabel.centerY(inView: messageInputTextView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textInputChangeHandler), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    override var intrinsicContentSize: CGSize {
        
        return .zero
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func clearMessageText() {
        
        messageInputTextView.text = nil
        placeholderLabel.isHidden = false
        
    }
    
    
    // MARK: - Selectors
    
    @objc private func sendMessageHandler() {
        
        guard let text = messageInputTextView.text else { return }
        
        delegate?.inputView(self, wantsToSend: text)
        
    }
    
    @objc private func textInputChangeHandler() {
        
        placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
        
    }
    
    
}
