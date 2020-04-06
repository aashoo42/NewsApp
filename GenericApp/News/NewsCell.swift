//
//  NewsCell.swift
//  AllOne
//
//  Created by Absoluit on 16/02/2020.
//  Copyright © 2020 Absoluit. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var detailsLbl: UILabel!
    
    @IBOutlet weak var detailsView: UIView!
    
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
