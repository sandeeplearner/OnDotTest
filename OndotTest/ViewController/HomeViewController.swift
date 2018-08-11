//
//  HomeViewController.swift
//  OndotTest
//
//  Created by Sandeep Bhandari on 8/12/18.
//  Copyright © 2018 ondot. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController<HomeViewModel> {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    //MARK : ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameLabel.text = "Currently Loggedin user is \n \(self.viewModel.currentlyLoggedInUser.emailId)"
        // Do any additional setup after loading the view.
    }

    //MARK : Memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : Create ViewModel
    override func createViewModel() {
        super.createViewModel()
        viewModel = HomeViewModel()
    }
    
    //MARK : Hook viewModel properties
    override func hookViewModelProperties() {
        super.hookViewModelProperties()
        self.logoutButton.rx.action = self.viewModel.logoutTapActionHandler
    }
}
