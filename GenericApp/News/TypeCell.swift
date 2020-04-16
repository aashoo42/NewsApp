//
//  TypeCell.swift
//  GenericApp
//
//  Created by mac on 4/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class TypeCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    
    override func awakeFromNib() {
        DispatchQueue.main.async {
            self.bottomLine.layer.cornerRadius = 2
            self.bottomLine.layer.masksToBounds = true
        }
        
    }
}
