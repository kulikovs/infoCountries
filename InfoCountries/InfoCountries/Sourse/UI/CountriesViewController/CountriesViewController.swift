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
            self.context?.load(finished: { [weak self] (_ arr: Array<AnyObject>) -> Void in
                self?.countries = arr
                self?.rootView.tableView?.reloadData()
            })
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
        
        let detailsController = storyboard?.instantiateViewController(withIdentifier:
                                String(describing: DetailsCountryViewController.self))
        
        self.navigationController?.pushViewController(detailsController!, animated: true)
    }
    
    // MARK: - Private Methods
    
    func contextDidFinish(countryModels: Array<Any>) {
        self.countries = countryModels as Array<AnyObject>
        self.rootView.tableView?.reloadData()
    }
}
