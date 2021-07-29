//
//  AuthService.swift
//  Messenger
//
//  Created by Beqa Tabunidze on 12.06.21.
//

import UIKit
import Firebase

struct RegistrationCredentials {
    
    let email: String
    let password: String
    let username: String
    let name: String
    let profilePicture: UIImage
    
}

struct AuthService {
    
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        
        guard let imageData = credentials.profilePicture.jpegData(compressionQuality: 0.3) else { return }

        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")

        ref.putData(imageData, metadata: nil) { (meta, error) in

            if let error = error {

                print("failed to upload image with error message: \(error.localizedDescription)")
                return
            }

            ref.downloadURL { (url, error) in

                guard let profileImageUrl = url?.absoluteString else { return }

                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in

                    if let error = error {

                        print("failed to create user with error message: \(error.localizedDescription)")
                        return
                    }

                    guard let uid = result?.user.uid else { return }

                    let data = ["email": credentials.email,
                                "name": credentials.name,
                                "profileImageUrl": profileImageUrl,
                                "uid": uid,
                                "username": credentials.username
                    ] as [String : Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                    

                }

            }
        }
        
    }
    
}
