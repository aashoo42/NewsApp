//
//  NewsDetailVC.swift
//  AllOne
//
//  Created by Absoluit on 16/02/2020.
//  Copyright © 2020 Absoluit. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var newsWebView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    private var observation: NSKeyValueObservation?

    var detailsDict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = (detailsDict["source"] as! NSDictionary)["name"] as! String
        
        setupWebView()
    }
    
    func setupWebView(){
        
        newsWebView.translatesAutoresizingMaskIntoConstraints = false
        newsWebView.navigationDelegate = self
        
        let urlStr = detailsDict["url"] as! String
        guard let url = URL(string: urlStr)else{return}
        let urlRequest = URLRequest(url: url)
        
        newsWebView.load(urlRequest)
        
        observation = newsWebView.observe(\WKWebView.estimatedProgress, options: .new) { _, change in
            self.progressView.progress = Float(change.newValue!)
            if self.progressView.progress > 0.80{
                self.progressView.isHidden = true
            }
        }
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
    }
    
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
