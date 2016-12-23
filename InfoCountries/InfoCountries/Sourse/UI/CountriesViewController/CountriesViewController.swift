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
    typealias RootViewType = CountriesView

    var countries: Array<Country> = Array()
    
    var pagingModel : PagingModel<CountriesContext>?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pagingModel = PagingModel(context: CountriesContext(), perPage: basePerPage)
    }
    
    // MARK: - Handling
    
    @IBAction func onNextPage(_ sender: UIButton) {
        self.pagingModel?.getNextPage().then { countries -> Void in
            self.countries = countries
            self.rootView.tableView?.reloadData()
            }.catch {error in
                print(error)
        }
    }

    @IBAction func onReset(_ sender: UIButton) {
        self.pagingModel?.reset().then { _ -> Void in
            self.countries.removeAll()
            self.rootView.tableView?.reloadData()
            }.catch {error in
                print(error)
        }
    }

    
    //MARK: - TableViewDataSourse
    
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
        detailContext.country = self.countries[indexPath.row] as? Country
        detailsController.context = detailContext
        
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
    
}
