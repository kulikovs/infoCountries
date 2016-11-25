//
//  CountriesViewController.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/22/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import UIKit

class CountriesViewController : UIViewController, ViewControllerRootView, UITableViewDelegate,
UITableViewDataSource {
    
    typealias RootViewType = CountriesView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CountriesContext().prepareToLoad()
    }
    
    //MARK: LifeCycle
    
    //MARK: TableViewDataSourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: CountriesCell.className) as! CountriesCell
        
        return cell1
    }
    
     // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsController: UIViewController = self.storyboard?.instantiateViewController(withIdentifier: DetailsCountryViewController.className) as! DetailsCountryViewController
        
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}
