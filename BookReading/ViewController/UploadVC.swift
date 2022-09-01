//
//  UploadVC.swift
//  BookReading
//
//  Created by Buket girenay on 17.08.2022.
//

import UIKit
import Firebase
import FirebaseCoreInternal
import FirebaseStorage

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var bookText: UITextField!
    @IBOutlet weak var authorLabel: UITextField!
    @IBOutlet weak var pagesLabel: UITextField!
    @IBOutlet weak var bookImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        bookImage.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        bookImage.contentMode = .scaleAspectFit
        present(pickerController, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        bookImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("BookList")
        
        
        if let data = bookImage.image?.jpegData(compressionQuality: 0.4) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    
                    imageReference.downloadURL { (url, error) in
                        
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!,
                                                 "postedBy" : Auth.auth().currentUser!.email!,
                                                 "postBook" : self.bookText.text!,
                                                 "Author":self.authorLabel.text!,
                                                 "pages" : self.pagesLabel.text!,
                                                 "date" : FieldValue.serverTimestamp(),
                                                 "likes" : 0 ,
                                                 "reads" : 0] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("BookList").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                                    
                                } else {
                                    
                                    self.bookImage.image = UIImage(named: "book.png")
                                    self.bookText.text = ""
                                    self.authorLabel.text = ""
                                    self.pagesLabel.text = ""
                                    self.tabBarController?.selectedIndex = 3
                                }
                                })
                                
                                
                                
                            }
                            
                            
                        }
                        
                    }
                }
                
                
            }
            
        }
        
    }
