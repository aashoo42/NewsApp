//
//  AppDelegate.swift
//  GenericApp
//
//  Created by mac on 4/5/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var interstitial: GADInterstitial!
    
    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK:- Ads
    func setupInterstitialAd(){
        interstitial = GADInterstitial(adUnitID: AdsIds.interstitialID)
        let request = GADRequest()
        interstitial.load(request)
    }
    
    func showInterstitialAd(controller: UIViewController){
        if interstitial.isReady{
            interstitial.present(fromRootViewController: controller)
        }
    }
}

let nameStr = "countryStr"
let codeStr = "codeStr"

func saveCountryToDefaults(country: LocalCountry){
    UserDefaults.standard.setValue(country.name, forKey: nameStr)
    UserDefaults.standard.setValue(country.countryCode, forKey: codeStr)
    UserDefaults.standard.synchronize()
}

func getCountryFromDefaults() -> LocalCountry{
    if (UserDefaults.standard.value(forKey: nameStr) != nil) && (UserDefaults.standard.value(forKey: codeStr) != nil){
        let name = UserDefaults.standard.value(forKey: nameStr) as! String
        let code = UserDefaults.standard.value(forKey: codeStr) as! String
        return LocalCountry(name: name, countryCode: code)
    }
    
    return LocalCountry(name: "USA", countryCode: "us")
}

class LocalCountry: NSObject {
    var name = ""
    var countryCode = ""
    
    init(name: String, countryCode: String) {
        self.name = name
        self.countryCode = countryCode
    }
}

struct AdsIds {
    static let bannerID = "ca-app-pub-3940256099942544/2934735716" // test
    static let interstitialID = "ca-app-pub-3940256099942544/4411468910" // test
}
