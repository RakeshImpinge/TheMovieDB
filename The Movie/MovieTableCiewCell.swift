//
//  MovieTableCiewCell.swift
//  The Movie
//
//  Created by Ankur Nautiyal on 31/08/17.
//  Copyright © 2017 Impinge. All rights reserved.
//

import UIKit

class MovieTableCiewCell: UITableViewCell {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var movieLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
