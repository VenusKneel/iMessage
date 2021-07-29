//
//  RegistrationController.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 11.06.21.
//

import UIKit
import Firebase
import FirebaseAuth
import JGProgressHUD

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    private var profilePicture: UIImage?
    
    weak var delegate: AuthenticationDelegateProtocol?
    
    private let addPictureButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "add_photo"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(selectImageHendler(_:)), for: .touchUpInside)
        return button
        
    }()

    private let emailTextField = CustomTextField(placeholder: "Email", security: false)
    private let nameTextField = CustomTextField(placeholder: "Full Name", security: false)
    private let usernameTextField = CustomTextField(placeholder: "Username", security: false)
    private let passwordTextField = CustomTextField(placeholder: "Password", security: true)
    
    private lazy var emailContainerView = InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
    private lazy var nameContainerView = InputContainerView(image: UIImage(systemName: "person"), textField: nameTextField)
    private lazy var usernameContainerView = InputContainerView(image: UIImage(systemName: "person"), textField: usernameTextField)
    private lazy var passwordContainerView = InputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)

    private let signUpButton: UIButton = {
        
        let button = CustomButton(title: "Sign Up")
        button.isEnabled = false
        button.addTarget(self, action: #selector(registrationHandler), for: .touchUpInside)
        return button
        
    }()

    private let backToSignInButton: UIButton = {
        
        let button = SignInAndUpButton(baseText: "Already a member? ", supportingText: "Sign In")
        button.addTarget(self, action: #selector(loginHandler), for: .touchUpInside)
        return button
        
    }()
    

    // MARK: - Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    // MARK: - Functions
    
    func configureUI() {
        
        configureGradient()
        
        view.addSubview(addPictureButton)
        addPictureButton.centerX(inView: view)
        addPictureButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        addPictureButton.setDimensions(height: self.view.frame.width / 3, width: self.view.frame.width / 2.9)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   nameContainerView,
                                                   usernameContainerView,
                                                   passwordContainerView,
                                                   signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: addPictureButton.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 100,
                     paddingLeft: 30, paddingRight: 30)
        
        view.addSubview(backToSignInButton)
        backToSignInButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                  right: view.rightAnchor, paddingLeft: 30,
                                  paddingBottom: 10, paddingRight: 30)
        
        notificationObservers()
        

        
        

    }
    
    func notificationObservers() {
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func checkFormStatus() {
        
        if viewModel.signUpFormIsValid {
            
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor(named: "mediumGreen")
            
        } else {
            
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .systemGray
            
        }
        
        
    }
    
    
    // MARK: - Selectors
    
    @objc private func selectImageHendler(_ gesture: UITapGestureRecognizer) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        print("image")
    }
    
    @objc private func loginHandler() {
        
        let vc = SignInController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func registrationHandler(sender: UIButton) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        guard let name = nameTextField.text  else { return }
        guard let profilePicture = profilePicture else { return }
        
        let credentials = RegistrationCredentials(email: email, password: password, username: username, name: name, profilePicture: profilePicture)
        
        showLoader(true, withText: "Signing up")
        
        AuthService.shared.createUser(credentials: credentials) { error in
            
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
    
    @objc private func textDidChange(sender: UITextField) {
        
        if sender == emailTextField {
            
            viewModel.email = sender.text
            
        } else if sender == passwordTextField {
            
            viewModel.password = sender.text
            
        } else if sender == usernameTextField {
            
            viewModel.username = sender.text
            
        } else if sender == nameTextField {
            
            viewModel.name = sender.text
            
        }
        
        checkFormStatus()
        
    }
    
    @objc func keyboardWillShow() {
        
        if view.frame.origin.y == 0 {
            
            view.frame.origin.y -= 88
            
        }
        
    }
    
    @objc func keyboardWillDisappear() {
        
        if view.frame.origin.y != 0 {
            
            view.frame.origin.y = 0
            
        }
        
    }
    
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profilePicture = image
        addPictureButton.setImage(image, for: .normal)
        addPictureButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        addPictureButton.layer.borderWidth = 3
        addPictureButton.layer.cornerRadius = 35
        dismiss(animated: true, completion: nil)
        
    }
    
}
