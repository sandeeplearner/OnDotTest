//
//  BaseViewController.swift
//  OndotTest
//
//  Created by Sandeep Bhandari on 8/12/18.
//  Copyright © 2018 ondot. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController <T : BaseViewModel> : UIViewController,ViewModelCreatorProtocol {
    var viewModel: T!
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //create viewModel
        self.createViewModel()
    }
    
    //MARK : ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //hook viewModel control properties and control events
        hookViewModelProperties()
        // Do any additional setup after loading the view.
    }

    //MARK : Memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK : Create ViewModel
    func createViewModel() {
        self.viewModel = T()
    }
    
    //MARK : Hook viewModel properties
    func hookViewModelProperties() {
        
    }
}
