//
//  SearchCell.swift
//  BookReading
//
//  Created by Buket girenay on 17.08.2022.
//

import UIKit
import Firebase
import FirebaseCoreInternal
import FirebaseStorage


class SearchCell: UITableViewCell{
   
    
    

    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var documentIDlabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var readLabel: UILabel!
    
//    public var FBBookList : [FirebaseBook] = []
//    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func readButtonTapped(_ sender: Any) {
        let fireStoreDatabase = Firestore.firestore()
        
        if let readCount = Int(readLabel.text!) {
            
            let readStore = ["reads" : readCount + 1] as [String : Any]

            fireStoreDatabase.collection("BookList").document(documentIDlabel.text!).setData(readStore, merge: true)
            
        }
        addBook()
        
    }
    
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        let fireStoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            
            fireStoreDatabase.collection("BookList").document(documentIDlabel.text!).setData(likeStore, merge: true)
            
        }
    }
    
    func addBook(){
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
//    func getDataOutput(BookData: FirebaseBook) {
//
//        userNameLabel.text = BookData.postedBy
//        pagesLabel.text = BookData.pages
//        bookLabel.text = BookData.title
//        authorLabel.text = BookData.author
//        likeLabel.text = String(BookData.likes)
//        readLabel.text = String(BookData.reads)
//        bookImage.sd_setImage(with: URL(string: BookData.bookImageURL))
//        documentIDlabel.text = BookData.id
//    }
    
}

