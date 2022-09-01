//
//  BookModel.swift
//  BookReading
//
//  Created by Buket girenay on 11.08.2022.
//

import Foundation
import UIKit
import SwiftUI

struct Book {
    var title: String
    var author: String
    var pages : Int
    var bookImage : UIImage?
    
}

extension Book {
    static var BookList = [
        Book(title: "Suç Ve Ceza", author: "Fyodor Dostoevsky", pages: 751,bookImage: UIImage(named: "suçveceza.png")),
        Book(title: "Cosmos", author: "Carl Sagan", pages: 422,bookImage: UIImage(named: "cosmos.png")),
        Book(title: "Karamozov Kardeşler", author: "Fyodor Dostoevsky", pages: 722,bookImage: UIImage(named: "karamazovkardesler.png")),
        Book(title: "Küçük Vampir Çiftlikte", author: "Angela Sommer", pages: 144,bookImage: UIImage(named: "kucukvampirciftlikte.png"))]
//        Book(title: "Sineklerin Tanrısı", author: "William Golding", pages: 261,reader: ["Banu","Pınar"],likes: ["Banu","Pınar"]),
//        Book(title: "İki Şehrin Hikayesi", author: "Charles Dickens ", pages: 464,reader: ["Büşra","Beste"],likes:  ["Büşra","Beste"]),
//        Book(title: "Ay'a Yolculuk", author: "Jules Verne", pages:224,reader: ["Samet","Tuğçe","İlkkan","Ecem","Umut"],likes: ["Samet","Tuğçe","İlkkan","Ecem","Umut"])
  
    
}


