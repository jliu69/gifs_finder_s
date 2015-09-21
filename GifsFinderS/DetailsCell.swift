//
//  DetailsCell.swift
//  GifsFinderS
//
//  Created by Johnson Liu on 9/21/15.
//  Copyright (c) 2015 HomeOffice. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    @IBOutlet weak var gifsDesc: UILabel!
    @IBOutlet weak var gifsImageView: UIImageView!
    @IBOutlet weak var gifsWidth: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
