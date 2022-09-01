//
//  ProfilCell.swift
//  BookReading
//
//  Created by Buket girenay on 22.08.2022.
//

import UIKit

class ProfilCell: UITableViewCell {

    @IBOutlet weak var readBookImage: UIImageView!
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

}
