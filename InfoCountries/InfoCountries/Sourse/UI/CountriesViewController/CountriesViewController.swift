//
//  CountriesViewController.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/22/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import UIKit
import MagicalRecord

class CountriesViewController : UIViewController, ViewControllerRootView, UITableViewDelegate,
UITableViewDataSource {
    
    //MARK: Accessor
    
    typealias RootViewType = CountriesView
    
    var countries: Array<AnyObject> = Array()
    
    var context : CountriesContext? {
        willSet {
            self.context?.cancel()
        }
        didSet {
            self.context?.load(finished: { [weak self] (_ arr: AnyObject) -> Void in
                self?.countries = arr as! Array<AnyObject>
                self?.rootView.tableView?.reloadData()
            } )
        }
    }
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.context = CountriesContext()
    }
    
    //MARK: TableViewDataSourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountriesCell.self)) as! CountriesCell
        cell.fillWithModel(model: self.countries[indexPath.row] as! Country)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsController: DetailsCountryViewController = storyboard?.instantiateViewController(withIdentifier:
                                String(describing: DetailsCountryViewController.self)) as! DetailsCountryViewController
        let detailContext = CountryDetailContext()
        let country = self.countries[indexPath.row] as! Country
        
        detailContext.URLString = countryURLString + country.name!  //"https://restcountries.eu/rest/v1/name/United%20Arab%20Emirates"
        detailContext.country = country
        detailsController.context = detailContext
 
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
    
}
