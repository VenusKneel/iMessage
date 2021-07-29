//
//  NewMessageController.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 13.06.21.
//

import UIKit

private let reuseIdentifier = "user_cell"

protocol NewMessageControllerDelegate: AnyObject {
    
    func controller(_ controller: NewMessageController, initiateChatWith user: User)
    
}

class NewMessageController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: NewMessageControllerDelegate?
    private var users = [User]()
    private var filteredUsers = [User]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearched: Bool {
        
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
        
    }
    
    
    // MARK: - Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureSearchController()
        fetchUsers()
        
        
    }
    
    // MARK: - Functions
    
    func configureUI() {
        
        configureNavBar(withTitle: "Messages", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissHandler))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        
        
    }
    
    
    func fetchUsers() {
        
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
        
    }
    
    func configureSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search users"
        navigationItem.searchController?.searchBar.searchTextField.backgroundColor = UIColor.white
        navigationItem.searchController?.searchBar.searchTextField.tintColor = UIColor.black
        definesPresentationContext = false

        
        
    }
    
    
    // MARK: - Selectors
    
    @objc private func dismissHandler() {
        
        dismiss(animated: true, completion: nil)
        
    }
}

extension NewMessageController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearched ? filteredUsers.count : users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = isSearched ? filteredUsers[indexPath.row] : users[indexPath.row]
        return cell
    }
    
}

extension NewMessageController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = isSearched ? filteredUsers[indexPath.row] : users[indexPath.row]
        delegate?.controller(self, initiateChatWith: user)
        
        
    }
    
}

extension NewMessageController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        filteredUsers = users.filter({ user in
            return user.username.contains(searchText) || user.name.contains(searchText)
           
        })
        
        self.tableView.reloadData()
    }

}
