//
//  LoginViewController.swift
//  OndotTest
//
//  Created by Sandeep Bhandari on 8/12/18.
//  Copyright © 2018 ondot. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController<LoginViewModel> {
    var textField : UITextField! = nil
    var submitButton : UIButton! = nil
    
    //MARK : ViewController life cycle
    override func viewDidLoad() {
        self.updateUI()
        super.viewDidLoad()
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
        self.viewModel = LoginViewModel()
    }
    
    private func updateUI() {
        submitButton = UIButton(frame: CGRect.zero)
        submitButton.setTitle("Login", for: .normal)
        submitButton.setTitleColor(UIColor.red, for: .normal)
        submitButton.setTitleColor(UIColor.gray, for: .disabled)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(submitButton)
        submitButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        textField = UITextField(frame: CGRect.zero)
        textField.placeholder = "Email ID"
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        textField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true
        textField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
        textField.topAnchor.constraint(equalTo: self.submitButton.topAnchor, constant: -40).isActive = true
        self.view.layoutIfNeeded()
    }
    
    //MARK : Hook viewModel properties
    override func hookViewModelProperties() {
        super.hookViewModelProperties()
        
        textField.rx.text
            .orEmpty
            .bind(to: viewModel.emailAddressVerifier)
            .disposed(by: disposeBag)
        
        viewModel.loginButtonEnabler
            .startWith(false)
            .asDriver(onErrorJustReturn: false)
            .drive(self.submitButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        self.submitButton.rx.action = self.viewModel.loginButtonTapHandlerAction
    }
}
