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

class CountriesViewController : UIViewController,
                                UITableViewDelegate,
                                UITableViewDataSource,
                                ViewControllerRootView
{
    //MARK: Accessor
    
    typealias RootViewType = CountriesView

    var countries: Array<AnyObject> = Array()
    
    var pandingModel : PagingModel? {
        didSet {
            self.pandingModel?.getNextPage()
        }
    }
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pandingModel = PagingModel(finished: self.update())
    }
    
     // MARK: - Interface Handling
    
    @IBAction func onNextPage(_ sender: UIButton) {
        self.pandingModel?.getNextPage()
    }
    
    @IBAction func onPreviousPage(_ sender: UIButton) {
        self.pandingModel?.getPreviousPage()
    }
    
    //MARK: TableViewDataSourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: CountriesCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CountriesCell
        
        cell.fillWith(model: self.countries[indexPath.row] as! Country)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = String(describing: DetailsCountryViewController.self)
        let detailsController = storyboard?.instantiateViewController(withIdentifier:identifier)
                                                                    as! DetailsCountryViewController
        
        let detailContext = CountryDetailContext()
        let country = self.countries[indexPath.row] as! Country
        let urlString = countryURLString + country.name!
        
        detailContext.URLString = urlString.addingPercentEncodingForUrlQuery()!
        detailContext.country = country
        detailsController.context = detailContext
        
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
    
         // MARK: - Private methods
    
  fileprivate  func update() -> ((_ arr: AnyObject) -> Void) {
        return { [weak self] (_ arr: AnyObject) -> Void in
            self?.countries = arr as! Array<AnyObject>
            self?.rootView.tableView?.reloadData()
        }
    }
    
}
