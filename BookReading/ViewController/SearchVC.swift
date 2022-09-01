//
//  SearchVC.swift
//  BookReading
//
//  Created by Buket girenay on 17.08.2022.
//

import UIKit
import Firebase
import SDWebImage
import SwiftUI

class SearchVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating {
  
    

    var userEmailArray = [String]()
    var titleArray = [String]()
    var authorArray = [String]()
    var pagesArray = [String]()
    var likeArray = [Int]()
    var readArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    var filteredBook = [String]()
    var filteredAuthor = [String]()
    
    var isBook: Bool = true
    let search = UISearchController(searchResultsController: nil)
        
    @IBOutlet weak var searchTableView: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
      
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        searchTableView.delegate = self
        searchTableView.dataSource = self
        getDataFromFirestore()
       
       

        
    }
    
    
    func getDataFromFirestore() {
    let fireStoreDatabase = Firestore.firestore()
    fireStoreDatabase.collection("BookList").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {

                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.titleArray.removeAll(keepingCapacity: false)
                    self.authorArray.removeAll(keepingCapacity: false)
                    self.pagesArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.readArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)



                    for document in snapshot!.documents {


                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)

                        if let postedBy = document.get("postedBy") as? String{                            self.userEmailArray.append(postedBy)}

                        if let bookTitle = document.get("postBook") as? String
                        {
                            self.titleArray.append(bookTitle)
                        }
                        if let pages = document.get("pages") as? String {
                            self.pagesArray.append(pages)
                        }
                        if let author = document.get("Author") as? String
                        {
                            self.authorArray.append(author)
                        }

                        if let likes = document.get("likes") as? Int
                        {
                            self.likeArray.append(likes)
                        }

                        if let reads = document.get("reads") as? Int
                        {
                            self.readArray.append(reads)
                        }
                        if let imageUrl = document.get("imageUrl") as? String
                        {
                            self.userImageArray.append(imageUrl)
                        }
//                        self.datas.append(dataType(id: documentID, title: bookTitle, image: imageUrl, author: author, likes: likes, read: reads, username: postedBy))



                      }

                      self.searchTableView.reloadData()

                  }


              }
          }




 }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return userEmailArray.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
      cell.userNameLabel.text = userEmailArray[indexPath.row]
      cell.pagesLabel.text = pagesArray[indexPath.row]
      cell.likeLabel.text = String(likeArray[indexPath.row])
      cell.readLabel.text = String(readArray[indexPath.row])
      cell.bookLabel.text = titleArray[indexPath.row]
      cell.authorLabel.text = authorArray[indexPath.row]
      cell.bookImage.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
           return cell
  }


    func updateSearchResults(for searchController: UISearchController) {
//        let fireStoreDatabase = Firestore.firestore()
//        let text = searchController.searchBar.text
//        fireStoreDatabase.collection("BookList").whereField("postBook", isGreaterThanOrEqualTo: text).order(by: text!).addSnapshotListener { [self] (snapshot, error) in
//            if error != nil {
//                print(error?.localizedDescription)
//            } else {
//                if snapshot?.isEmpty != true && snapshot != nil {
//                    for document in snapshot!.documents {
//                        for document in snapshot!.documents {
//                           let documentID = document.documentID
//                            self.documentIdArray.append(documentID)
//
//                            if let postedBy = document.get("postedBy") as? String{                            self.userEmailArray.append(postedBy)}
//
//                            if let bookTitle = document.get("postBook") as? String
//                            {
//                                self.titleArray.append(bookTitle)
//                            }
//                            if let pages = document.get("pages") as? String {
//                                self.pagesArray.append(pages)
//                            }
//                            if let author = document.get("Author") as? String
//                            {
//                                self.authorArray.append(author)
//                            }
//
//                            if let likes = document.get("likes") as? Int
//                            {
//                                self.likeArray.append(likes)
//                            }
//
//                            if let reads = document.get("reads") as? Int
//                            {
//                                self.readArray.append(reads)
//                            }
//                            if let imageUrl = document.get("imageUrl") as? String
//                            {
//                                self.userImageArray.append(imageUrl)
//                            }
//                        }
//
//                        self.searchTableView.reloadData()
//
//                    }
//
//
//                }
//            }
//
//
//
//
//   }
//
////    struct FirebaseBook : Identifiable {
////        var id: String
////        var author: String
////        var bookImageURL : String
////        var likes : Int
////        var pages : String
////        var title: String
////        var postedBy : String
////        var reads : Int
////    }
////    func fetchBook(){
////        let db = Firestore.firestore()
////        db.collection("BookList").getDocuments { [self] querySnapshot, error in
////            if let error = error {
////                print("Error getting documents\(error)")
////            }else{
////                if let querySnapshot = querySnapshot {
////                    for document in querySnapshot.documents {
////                        let id = document.documentID as! String
////                        let author = document.get("Author") as! String
////                        let bookImageUrl = document.get("imageUrl") as! String
////                        let likes = document.get("likes") as! Int
////                        let pages = document.get("pages") as! String
////                        let title = document.get("postBook") as! String
////                        let postedBy = document.get("postedBy") as! String
////                        let reads = document.get("reads") as! Int
////
////                        self.FBBookList.append(FirebaseBook(id: id, author: author, bookImageURL: bookImageUrl, likes: likes, pages: pages, title: title, postedBy: postedBy, reads: reads))
////
////
////                    }
////                }
////                self.searchTableView.reloadData()
////            }
////        }
////    }
}
}



