//
//  ImageCell.swift
//  GifsFinderS
//
//  Created by Johnson Liu on 9/17/15.
//  Copyright (c) 2015 HomeOffice. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var gifDescLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
