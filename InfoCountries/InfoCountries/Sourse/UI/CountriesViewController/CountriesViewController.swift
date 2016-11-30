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
    
    var context : CountriesContext? {
        willSet {
            self.context?.cancel()
        }
        didSet {
            self.context?.load()
        }
    }
    
    var countryes: Array<Any> {
        get {
            return Country.mr_findAllSorted(by: "name", ascending: true)!
        }
    }
    
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView.tableView?.register(CountriesCell.self, forCellReuseIdentifier: CountriesCell.className)

        self.context = CountriesContext()
    }

    //MARK: TableViewDataSourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.countryes.count)
        return self.countryes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountriesCell.className) as! CountriesCell
        
        return cell
    }
    
     // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsController: UIViewController = self.storyboard?.instantiateViewController(withIdentifier: DetailsCountryViewController.className) as! DetailsCountryViewController
        
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}
