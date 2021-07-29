//
//  ChatController.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 13.06.21.
//

import UIKit

private let reuseIdentifier = "message_cell"

class ChatController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let user: User
    
    private var messages = [Message]()
    
    var fromCurrentUser = false
    
    private lazy var customInputView: CustomInputAccessoryView = {
        
        let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        iv.delegate = self
        
        return iv
        
    }()
    
    // MARK: - Cycles
    
    init(user: User) {
        
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var inputAccessoryView: UIView? {
        
        get { return customInputView }
        
    }
    
    override var canBecomeFirstResponder: Bool {
        
        return true
        
    }
    
    // MARK: - Functions
    
    func configureUI() {
        
        collectionView.backgroundColor = .white
        configureNavBar(withTitle: user.username, prefersLargeTitles: false)
        
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        
    }
    
    func fetchMessages() {
        
        Service.fetchMessages(forUser: user) { messages in
            self.messages = messages
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: [0, self.messages.count - 1], at: .bottom, animated: true)
        }
        
    }
    
    // MARK: - Selectors
    
    
}

extension ChatController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        cell.message?.user = user
        return cell
    }
    
}


extension ChatController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let estimatedCellSize = MessageCell(frame: frame)
        estimatedCellSize.message = messages[indexPath.row]
        estimatedCellSize.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedCellSize.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
}

extension ChatController: CustomInputAccessoryViewDelegate {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
        
        Service.uploadMessage(message, toUser: user) { error in
            
            if let error = error {
                
                print("error failed to upload message with error: \(error.localizedDescription)")
                return
            }
            
            inputView.clearMessageText()
            
        }

    }
    
}
