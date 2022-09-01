//
//  HomeVC.swift
//  BookReading
//
//  Created by Buket girenay on 16.08.2022.
//

import UIKit
import Firebase
import FirebaseCoreInternal
import FirebaseStorage


class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
   
    
    
    var bookList : [Book] = Book.BookList
    
    @IBOutlet weak var bookTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookTableView.delegate = self
        bookTableView.dataSource = self
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeCell
        cell.getData(model: bookList[indexPath.row])
        return cell
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
            print(text)
    }
    
    
}
