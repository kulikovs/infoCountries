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
    
    let loadingView = LoadingView.loadingView()
    
    var countries: Array<Country> = Array()
    
    var pagingModel : PagingModel<CountriesContext>?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pagingModel = PagingModel(context: CountriesContext(), perPage: Paging.basePerPage)
    }
    
    // MARK: - Handling
    
    @IBAction func cancel(_ sender: Any) {
        pagingModel?.cancel()
    }
    
    @IBAction func onNextPage(_ sender: UIButton) {
        let rootView = self.rootView
        self.loadingView?.showLoadingViewOn(view: self.rootView, animated: false)
        
        self.pagingModel?.getNextPage().then { countries -> Void in
            self.countries = countries
            rootView.tableView?.reloadData()
            }
            .always {
                self.loadingView?.hideLoadingView()
            }
            .catch {error in
                print(error)
            }
    }

    @IBAction func onReset(_ sender: UIButton) {
        self.pagingModel?.reset()
        self.countries.removeAll()
        self.rootView.tableView?.reloadData()
    }
    
    //MARK: - TableViewDataSourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWith(cellClass: CountriesCell.self)
        cell.fillWith(model: self.countries[indexPath.row])

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailsController = self.storyboard?.instantiateViewController(controllerType: DetailsCountryViewController.self) {
            if let countryName = countries[indexPath.row].name {
                let detailContext = CountryDetailContext(countryName: countryName)
                detailsController.context = detailContext
            }
            
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
    
}
