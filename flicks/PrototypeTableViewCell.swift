//
//  PrototypeTableViewCell.swift
//  flicks
//
//  Created by Usman Ajmal on 10/14/16.
//  Copyright © 2016 worotos. All rights reserved.
//

import UIKit

class PrototypeTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieSummaryTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}