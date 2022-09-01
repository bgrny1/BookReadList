//
//  ViewController.swift
//  BookReading
//
//  Created by Buket girenay on 11.08.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var bookTableView: UITableView!
    var bookList: [Book] =  Book.BookList
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeCell
        return cell
    }
        

}


