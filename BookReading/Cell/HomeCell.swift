//
//  HomeCell.swift
//  BookReading
//
//  Created by Buket girenay on 16.08.2022.
//

import UIKit
import Firebase
import FirebaseCoreInternal
import FirebaseStorage

class HomeCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getData(model:Book) {
        bookLabel.text = model.title
        authorLabel.text = model.author
        pagesLabel.text = String(model.pages)
        bookImage.image = model.bookImage
    }
    
    @IBAction func readBookTapped(_ sender: Any) {
        
        addBook()
        
    }
    
    func addBook() {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let bookFolder = storageReference.child("readBook")
        
        
        if let data = bookImage.image?.jpegData(compressionQuality: 0.4) {
            
            let uuid = UUID().uuidString
            
            let imageReference = bookFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    
                    imageReference.downloadURL { (url, error) in
                        
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!,
                                                 "postBook" : self.bookLabel.text!,
                                                 "Author":self.authorLabel.text!,
                                                 "pages" : self.pagesLabel.text!,
                                                 "postedBy" : Auth.auth().currentUser!.email!,
                                                 "date" : FieldValue.serverTimestamp()] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("readBook").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    
                                    print(error?.localizedDescription)
                                    
                                }
                                })
                            
                        }
                        
                        
                    }
                    
                }
            }
            
            
        }
        
    }
}
