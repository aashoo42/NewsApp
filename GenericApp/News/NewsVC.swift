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
import GoogleMobileAds

class NewsVC: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var typesCollectionView: UICollectionView!
    
    
    private var newsArray = NSArray()
    
    private var newsTypeName = ["Headlines", "Business", "Sports", "Health", "Tecnology"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.estimatedRowHeight = 100
        newsTableView.rowHeight = UITableView.automaticDimension

//        callApi()
        (UIApplication.shared.delegate as! AppDelegate).setupInterstitialAd()

    }
    
    
    func callApi(){
        
//        let urlStr = "https://newscafapi.p.rapidapi.com/apirapid/news/?q=home"
        
//        http://newsapi.org/v2/everything?q=bitcoin&from=2020-03-06&sortBy=publishedAt&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a
//        let urlStr = "http://newsapi.org/v2/top-headlines?country=&category=&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a"
//        http://newsapi.org/v2/everything?q=apple&from=2020-04-05&to=2020-04-05&sortBy=popularity&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a
//        http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a
//        http://newsapi.org/v2/everything?domains=wsj.com&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a
        
        let urlStr = "http://newsapi.org/v2/top-headlines?country=\(getCountryFromDefaults().countryCode)&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a"
        //  business, sports, health, tecnology
        
        let params = ["country": getCountryFromDefaults().countryCode,
                      "apiKey": "ad8d9cbb3adb46cd900b80e2ff22625a"]
        
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
        (UIApplication.shared.delegate as! AppDelegate).showInterstitialAd(controller: self)
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
            
            cell.imgView.af_setImage(withURL: URL.init(string: imgUrl!)!,
                                     placeholderImage: UIImage(named: "placeholder"),
                                     filter: .none,
                                     progress: .none,
                                     progressQueue: .main,
                                     imageTransition: .crossDissolve(1.0),
                                     runImageTransitionIfCached: false,
                                     completion: nil)
        }
        
        
        cell.seeAllBtn.tag = indexPath.row
        cell.seeAllBtn.addTarget(self, action: #selector(seeAllDetailsAction(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerBannerView = GADBannerView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerBannerView.adUnitID = AdsIds.bannerID
        headerBannerView.rootViewController = self
        headerBannerView.load(GADRequest())
        return headerBannerView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK:- UICollectionView
extension NewsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsTypeName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = typesCollectionView.dequeueReusableCell(withReuseIdentifier: "TypeCell", for: indexPath) as! TypeCell
        cell.backgroundColor = .green
        cell.nameLbl.text = newsTypeName[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .white
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
