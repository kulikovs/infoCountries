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

    var countries: Array<AnyObject> = Array()
    
    //MARK: - Accessor
    
    var pagingModel : PagingModel? {
        didSet {
            self.pagingModel?.getNextPage()
        }
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pagingModel = PagingModel(finishedBlock: self.update())
    }
    
    // MARK: - Handling
    
    @IBAction func onNextPage(_ sender: UIButton) {
        self.pagingModel?.pagingFinished = self.update()
        self.pagingModel?.getNextPage()
    }
    
    @IBAction func onPreviousPage(_ sender: UIButton) {
        self.pagingModel?.pagingFinished = self.update()
        self.pagingModel?.getPreviousPage()
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
        self.pagingModel?.country = self.countries[indexPath.row] as? Country
        detailsController.pandingModel = self.pagingModel
        
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
    
    // MARK: - Private methods
    
    fileprivate func update() -> (pagingFinishedBlock) {
        
        return { [weak self] (_ arr: AnyObject) -> Void in
            self?.countries = arr as! Array<AnyObject>
            self?.rootView.tableView?.reloadData()
        }
    }
    
}
