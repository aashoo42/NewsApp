//
//  ViewController.swift
//  GenericApp
//
//  Created by mac on 4/5/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let objNewsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsVC") as! NewsVC
        self.navigationController?.pushViewController(objNewsVC, animated: true)
    }
}

