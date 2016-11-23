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
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
   //     self.rootView.tableView?.register(CountriesCell.self, forCellReuseIdentifier: "CountriesCell")
    }
    
    //MARK: TableViewDataSourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesCell",
                                                 for: indexPath) as! CountriesCell
        return cell
    }
    
     // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
