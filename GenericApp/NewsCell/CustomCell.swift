//
//  CustomCell.swift
//  GenericApp
//
//  Created by mac on 4/6/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var detailsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        parentView.layer.cornerRadius = 13.0
        parentView.layer.borderWidth = 0.5
        parentView.layer.masksToBounds = true
        parentView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
