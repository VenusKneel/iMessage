//
//  SignInController.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 11.06.21.
//

import UIKit
import Firebase
import JGProgressHUD

protocol AuthenticationDelegateProtocol: AnyObject {
    func AuthenticationComplete()
}

class SignInController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    weak var delegate: AuthenticationDelegateProtocol?
    
    private let iconImage = CustomIcon(imageName: "bubble.left", interaction: false)

    private let emailTextField = CustomTextField(placeholder: "Email", security: false)
    private let passwordTextField = CustomTextField(placeholder: "Password", security: true)
    
    private lazy var emailContainerView = InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
    private lazy var passwordContainerView = InputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
    
    private let signInButton: UIButton = {
        
        let button = CustomButton(title: "Sign In")
        button.isEnabled = false
        button.addTarget(self, action: #selector(signInHandler), for: .touchUpInside)
        return button
        
    }()
    
    private let noAccountButton: UIButton = {
        
        let button = SignInAndUpButton(baseText: "Don't have an account? ", supportingText: "Sign Up")
        button.addTarget(self, action: #selector(signUpHandler), for: .touchUpInside)
        return button
        
    }()
    
    // MARK: - Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    
    // MARK: - Functions
    
    func checkFormStatus() {
        
        if viewModel.signInFormIsValid {
            
            signInButton.isEnabled = true
            signInButton.backgroundColor = UIColor(named: "mediumGreen")
            
        } else {
            
            signInButton.isEnabled = false
            signInButton.backgroundColor = .systemGray
            
        }
        
        
    }
    
    func configureUI() {
        
        configureGradient()
     
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        iconImage.setDimensions(height: self.view.frame.width / 3, width: self.view.frame.width / 2.8)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   signInButton])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 100,
                     paddingLeft: 30,
                     paddingRight: 30
         )
        
        view.addSubview(noAccountButton)
        noAccountButton.anchor(left: view.leftAnchor,
                               bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               right: view.rightAnchor,
                               paddingLeft: 30,
                               paddingBottom: 10,
                               paddingRight: 30
        )
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    // MARK: - Selectors
    
    @objc private func signUpHandler() {
        
        let vc = RegistrationController()
        vc.delegate = delegate
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func textDidChange(sender: UITextField) {
        
        if sender == emailTextField {
            
            viewModel.email = sender.text
            
        } else {
            
            viewModel.password = sender.text
            
        }
        
        checkFormStatus()
        
    }
    
    @objc private func signInHandler(sender: UIButton) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        showLoader(true, withText: "Signing in")
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
            
            if let error = error {
                self.showLoader(false)
                self.showErrorMessages(error.localizedDescription)

                return
            }
            
            self.showLoader(false)
            self.delegate?.AuthenticationComplete()
        }
        
        self.buttonAnimation(sender)
    }

}
