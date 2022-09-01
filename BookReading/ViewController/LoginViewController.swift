//
//  LoginViewController.swift
//  BookReading
//
//  Created by Buket girenay on 15.08.2022.
//

import UIKit
import Firebase
import FirebaseCoreInternal
import FirebaseStorage

class LoginViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
                  
                  Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                      if error != nil {
                          self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")

                      } else {
                          self.performSegue(withIdentifier: "toDetailVC", sender: nil)

                      }
                  }
                  
                  
              } else {
                  makeAlert(titleInput: "Error!", messageInput: "Username/Password?")

              }
              
              
              
          }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
                    Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                        
                        if error != nil {
                            self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                        } else {
                            self.performSegue(withIdentifier: "toDetailVC", sender: nil)
                            
                        }
                    }
                
                } else {
                    makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
                }
    }
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
        
    
    
}
