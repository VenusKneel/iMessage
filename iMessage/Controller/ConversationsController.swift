//
//  ConversationsController.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 11.06.21.
//

import UIKit
import Firebase

private let identifier = "conversation_cell"

class ConversationsController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private var conversations = [Conversation]()
    private var conversationsDictionary = [String: Conversation]()
    
    private let createNewConversation: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.backgroundColor = UIColor(named: "lightGreen")
        button.tintColor = .white
        button.imageView?.setDimensions(height: 25, width: 25)
        button.addTarget(self, action: #selector(showMessage), for: .touchUpInside)
        
        return button
    }()
    // MARK: - Cycles
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        authenticateUser()
        fetchConversations()
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavBar(withTitle: "Messages", prefersLargeTitles: true)
        self.tableView.reloadData()
    }
    
    // MARK: - Functions
    
    func configureUI() {
        
        view.backgroundColor = .white

        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showProfile))
        
        view.addSubview(createNewConversation)
        createNewConversation.setDimensions(height: 56, width: 56)
        createNewConversation.layer.cornerRadius = 56 / 2
        createNewConversation.anchor(bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 50, paddingRight: 30)
        
    }
    
            // MARK: - API Call
    
    func fetchConversations() {
        
        Service.fetchConversations { conversations in
            
            conversations.forEach { conversation in

                let message = conversation.message
                self.conversationsDictionary[message.chatPartnerId] = conversation

            }
            
            self.conversations = Array(self.conversationsDictionary.values)
            self.tableView.reloadData()
        }
        
    }
    
    func authenticateUser() {
        
        if Auth.auth().currentUser?.uid == nil {
            
            presentLoginScreen()
            
        }
        
    }
    
    func configureTableView() {
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 100
        tableView.register(ConversationCell.self, forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
    }
    
    func logOut() {
        
        do {
            
            try Auth.auth().signOut()
            presentLoginScreen()
            
        } catch {
            
            print("error signing out")
            
        }
        
    }
    
    func presentLoginScreen() {
        
        DispatchQueue.main.async {
            
            let controller = SignInController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
            
        }
        
    }
    
    func showChatController(forUser user: User) {
        
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    // MARK: - Selectors
    
    @objc func showProfile() {
        
        let controller = ProfileController(style: .insetGrouped)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    @objc func showMessage() {
        
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen 
        present(nav, animated: true, completion: nil)
        
    }
    
}

// MARK: - Extensions

extension ConversationsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = conversations[indexPath.row].user
        showChatController(forUser: user)
        
    }
    
    
}

extension ConversationsController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.row]
        return cell
    }
    
    
}

extension ConversationsController: NewMessageControllerDelegate {
    
    func controller(_ controller: NewMessageController, initiateChatWith user: User) {
        
        dismiss(animated: true, completion: nil)
        showChatController(forUser: user)
    }
    
}



extension ConversationsController: ProfileControllerDelegate {
    
    func logoutHandler() {
        logOut()
    }
    
}

extension ConversationsController: AuthenticationDelegateProtocol {
    
    func AuthenticationComplete() {
        dismiss(animated: true, completion: nil)
        configureUI()
        fetchConversations()
    }
    
}
