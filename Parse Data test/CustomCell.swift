//
//  CustomCell.swift
//  Parse Data test
//
//  Created by media-pt on 11.10.16.
//  Copyright © 2016 media-pt. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var imageCell: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
