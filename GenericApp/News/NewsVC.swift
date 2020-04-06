//
//  NewsVC.swift
//  AllOne
//
//  Created by Absoluit on 16/02/2020.
//  Copyright © 2020 Absoluit. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewsVC: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
   
    private var newsArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.estimatedRowHeight = 100
        newsTableView.rowHeight = UITableView.automaticDimension
//        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.0/255.0, green: 157.0/255.0, blue: 215.0/255.0, alpha: 0.5)
//        navigationController?.navigationBar.tintColor = UIColor.white
        
        callApi()
//        (UIApplication.shared.delegate as! AppDelegate).showInterstitialAd(controller: self)
    }
    
    
    
    func callApi(){
        
//        let urlStr = "https://newscafapi.p.rapidapi.com/apirapid/news/?q=home"
        
//        http://newsapi.org/v2/everything?q=bitcoin&from=2020-03-06&sortBy=publishedAt&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a
        let urlStr = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a"
//        http://newsapi.org/v2/everything?q=apple&from=2020-04-05&to=2020-04-05&sortBy=popularity&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a
//        http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a
//        http://newsapi.org/v2/everything?domains=wsj.com&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a
        
        let headers = [
            "x-rapidapi-host": "newscafapi.p.rapidapi.com",
            "x-rapidapi-key": "c4b7f6c03amshb614de998b9c9dap1a91e3jsncbcc3a6c56b3"
        ]
        
        Alamofire.request(urlStr, method: .get).responseJSON { (response) in
            if response.result.value != nil{
                let reponseJson = response.result.value as! NSDictionary
                self.newsArray = reponseJson["articles"] as! NSArray
                self.newsTableView.reloadData()
            }
        }
    }
    
    @objc func seeAllDetailsAction(sender: UIButton){
        let objNewsDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailVC") as! NewsDetailVC
        let tempDict = self.newsArray[sender.tag] as! NSDictionary
        objNewsDetailVC.detailsDict = tempDict
        self.navigationController?.pushViewController(objNewsDetailVC, animated: true)
//        (UIApplication.shared.delegate as! AppDelegate).showInterstitialAd(controller: self)
    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        let tempDict = self.newsArray[indexPath.row] as! NSDictionary
        
        cell.titleLbl.text = tempDict["title"] as? String ?? ""
        cell.detailsLbl.text = tempDict["description"] as? String ?? ""
        
        let imgUrl = tempDict["urlToImage"] as? String
        if imgUrl != nil{
            cell.imgView.af_setImage(withURL: URL.init(string: imgUrl!)!)
        }
        
        
        cell.seeAllBtn.tag = indexPath.row
        cell.seeAllBtn.addTarget(self, action: #selector(seeAllDetailsAction(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let headerBannerView = GADBannerView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//        headerBannerView.adUnitID = AdsIds.bannerID
//        headerBannerView.rootViewController = self
//        headerBannerView.load(GADRequest())
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}
