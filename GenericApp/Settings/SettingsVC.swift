//
//  SettingsVC.swift
//  GenericApp
//
//  Created by mac on 4/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CountriesViewController
import GoogleMobileAds

class SettingsVC: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

// MARK:- UITableView
extension SettingsVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.detailTextLabel?.text = getCountryFromDefaults().name
        
        cell.textLabel?.text = "Country"
        cell.accessoryType = .disclosureIndicator
    
        cell.backgroundColor = .white
        if #available(iOS 13.0, *) {
            cell.imageView?.image = UIImage(systemName: "flag")
        } else {
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let countriesViewController = CountriesViewController()
        countriesViewController.allowMultipleSelection = false
        countriesViewController.delegate = self
        CountriesViewController.Show(countriesViewController: countriesViewController, to: self)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerBannerView = GADBannerView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerBannerView.adUnitID = AdsIds.bannerID
        headerBannerView.rootViewController = self
        headerBannerView.load(GADRequest())
        return headerBannerView
    }
    
}

// MARK:- CountriesViewControllerDelegate
extension SettingsVC : CountriesViewControllerDelegate{
  /// MARK: CountriesViewControllerDelegate
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountries countries: [Country]){
        
        countries.forEach { (co) in
            print(co.name);
        }
    }

    func countriesViewControllerDidCancel(_ countriesViewController: CountriesViewController) {
        
        print("user did tap cancel")
        
    }
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountry country: Country) {
        let localCountry = LocalCountry(name: country.name, countryCode: country.countryCode)
        saveCountryToDefaults(country: localCountry)
        
        print(country.name+" selected")
        print(country.countryCode)
        
        settingsTableView.reloadData()
        
    }
    
    func countriesViewController(_ countriesViewController: CountriesViewController, didUnselectCountry country: Country) {
        
        print(country.name+" unselected")
        
    }
}
