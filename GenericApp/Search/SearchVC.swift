//
//  SearchVC.swift
//  GenericApp
//
//  Created by mac on 4/6/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMobileAds
import UITableViewCellAnimation

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var searchedStr = "SearchedValues"
    
    var searchedArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (UIApplication.shared.delegate as! AppDelegate).setupInterstitialAd()
    }
    
    func getSearchedNews(str: String){
        
        //        http://newsapi.org/v2/everything?q=bitcoin&from=2020-03-06&sortBy=publishedAt&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a
        let urlStr = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a"
        //        let urlStr =        "http://newsapi.org/v2/everything?"
        //        http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a
        //        http://newsapi.org/v2/everything?domains=wsj.com&apiKey=ad8d9cbb3adb46cd900b80e2ff22625a
        
        let params = ["q": str,
                      "apiKey":"ad8d9cbb3adb46cd900b80e2ff22625a"]
        
        Alamofire.request(urlStr, method: .get, parameters: params).responseJSON { (response) in
            if response.result.value != nil{
                let reponseJson = response.result.value as! NSDictionary
                self.searchedArray = reponseJson["articles"] as! NSArray
                self.searchTableView.reloadData()
            }
        }
    }
    
    @objc func seeAllDetailsAction(sender: UIButton){
        let objNewsDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailVC") as! NewsDetailVC
        let tempDict = self.searchedArray[sender.tag] as! NSDictionary
        objNewsDetailVC.detailsDict = tempDict
        self.navigationController?.pushViewController(objNewsDetailVC, animated: true)
        (UIApplication.shared.delegate as! AppDelegate).showInterstitialAd(controller: self)
    }
}


extension SearchVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked", searchBar.text!)
        
        getSearchedNews(str: searchBar.text!)
        self.view.endEditing(true)
        
        if UserDefaults.standard.value(forKey: searchedStr) != nil{
            let tempArray = UserDefaults.standard.value(forKey: searchedStr) as! NSArray
            let tempMutableArray = NSMutableArray(array: tempArray)
            if !(tempMutableArray.contains(searchBar.text!)){
                tempMutableArray.add(searchBar.text!)
            }
            
            print(tempMutableArray)
            UserDefaults.standard.set(tempMutableArray, forKey: searchedStr)
            UserDefaults.standard.synchronize()
        }else{
            let tempArray = [searchBar.text!]
            UserDefaults.standard.set(tempArray, forKey: searchedStr)
            UserDefaults.standard.synchronize()
        }
        
        
    }
}

// MARK:- TableView
extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "CustomCell"
        var cell: CustomCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomCell
        
        if cell == nil {
            tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomCell
        }
        
        let tempDict = self.searchedArray[indexPath.row] as! NSDictionary
        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.rightInAnimation(forIndex: indexPath.row)
    }
    
}
