//
//  ProfileController.swift
//  iMessage
//
//  Created by Beqa Tabunidze on 23.07.21.
//

import UIKit
import Firebase

private let reuseIdentifier = "profile_cell"
protocol ProfileControllerDelegate: AnyObject {
    
    func logoutHandler()
    
}

class ProfileController: UITableViewController {
    
    // MARK: - Properties
    
    private lazy var  headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    private var user: User? {
        
        didSet {
            headerView.user = user
        }
        
    }
    
    weak var delegate: ProfileControllerDelegate?
    
    private let footerView = ProfileFooter()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    // MARK: - Functions
    
    func configureUI() {

        tableView.backgroundColor = .white
        tableView.tableHeaderView = headerView
        headerView.delegate = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        
        footerView.delegate = self
        footerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        tableView.tableFooterView = footerView
        
    }
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { user in
            self.user = user
        }
        
    }
    
    func comingSoonAlert() {
        
        let alert = UIAlertController(title: "Coming soon!", message: "This feature hasn't been implemented yet", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cool", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

// MARK: - TableView Data

extension ProfileController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ProfileViewModel.allCases.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = ProfileViewModel(rawValue: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        cell.viewModel = viewModel
        cell.accessoryType = .disclosureIndicator
        return cell
    }

}

// MARK: - TableView Delegate

extension ProfileController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = ProfileViewModel(rawValue: indexPath.row) else { return }
        
        switch viewModel {
        
        case .accountInfo:
            
            comingSoonAlert()
        
        case .privacy:
            
            comingSoonAlert()
            
        case .language:
            
            comingSoonAlert()
            
        case .preferences:
            
            comingSoonAlert()
            
        case .about:
            
            let alert = UIAlertController(title: "iMessage v1.0.3", message: "Latest stable version with lots of bug fixes", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cool", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
}

extension ProfileController: ProfileHeaderDelegate {
    
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileController: ProfileFooterDelegate {
    
    func logoutHandler() {
        
        let alert = UIAlertController(title: nil, message: "You will be able to access your content once you sign back in", preferredStyle: .actionSheet)
        alert.setTitle(font: UIFont.boldSystemFont(ofSize: 20), color: UIColor.black)
        alert.setMessage(font: UIFont.systemFont(ofSize: 16), color: UIColor.darkGray)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            self.dismiss(animated: true) {
                self.delegate?.logoutHandler()
            }

        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
}
