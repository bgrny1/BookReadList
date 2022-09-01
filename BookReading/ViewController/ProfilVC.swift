//
//  ProfilVC.swift
//  BookReading
//
//  Created by Buket girenay on 22.08.2022.
//

import UIKit
import Firebase
import SDWebImage
import Firebase
import FirebaseCoreInternal
import FirebaseStorage

class ProfilVC: UIViewController ,UITableViewDelegate,UITableViewDataSource


{

    var titleArray = [String]()
    var authorArray = [String]()
    var pagesArray = [String]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var readBookTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readBookTableView.delegate = self
        readBookTableView.dataSource = self
        showUserInfo()
        getBook()
       
    }
    @IBAction func logOutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
            
        } catch {
            print("error")
        }
    }
    func getBook() {
          
          let fireStoreDatabase = Firestore.firestore()
          

          fireStoreDatabase.collection("readBook").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
              if error != nil {
                  print(error?.localizedDescription)
              } else {
                  if snapshot?.isEmpty != true && snapshot != nil {
                      
                      self.userImageArray.removeAll(keepingCapacity: false)
                      self.titleArray.removeAll(keepingCapacity: false)
                      self.authorArray.removeAll(keepingCapacity: false)
                      self.pagesArray.removeAll(keepingCapacity: false)
                      self.documentIdArray.removeAll(keepingCapacity: false)
                      
                      
                      for document in snapshot!.documents {
                          let documentID = document.documentID
                          self.documentIdArray.append(documentID)
    
                          
                          if let bookTitle = document.get("postBook") as? String {
                              self.titleArray.append(bookTitle)
                          }
                          if let pages = document.get("pages") as? String {
                              self.pagesArray.append(pages)
                          }
                          if let author = document.get("Author") as? String {
                              self.authorArray.append(author)
                          }
                          
                         
                          if let imageUrl = document.get("imageUrl") as? String {
                              self.userImageArray.append(imageUrl)
                          }
                          
                          
                      }
                      
                      self.readBookTableView.reloadData()
                      
                  }
                  
                  
              }
          }
          
          
          
          
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = readBookTableView.dequeueReusableCell(withIdentifier: "readBookCell", for: indexPath) as! ProfilCell
        cell.pagesLabel.text = pagesArray[indexPath.row]
        cell.bookLabel.text = titleArray[indexPath.row]
        cell.authorLabel.text = authorArray[indexPath.row]
        cell.readBookImage.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
       return cell
    }
    
    func showUserInfo() {
       
        self.emailLabel.text = Auth.auth().currentUser?.email!
            
        }
}
        

    
    
