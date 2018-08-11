//
//  LoginViewModel.swift
//  OndotTest
//
//  Created by Sandeep Bhandari on 8/11/18.
//  Copyright © 2018 ondot. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action

class LoginViewModel : BaseViewModel {
    var emailAddressVerifier : BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var loginButtonEnabler : BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var loginButtonTapHandlerAction : CocoaAction! = nil
    
    required init() {
        super.init()
        
        emailAddressVerifier
            .skip(1)
            .subscribe(onNext: {[weak self] (string) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.loginButtonEnabler.accept(strongSelf.isEmailValid(emailId: string))
            })
            .disposed(by: self.disposeBag)
        
        loginButtonTapHandlerAction = CocoaAction(workFactory: {[weak self] _ -> Observable<Void> in
            guard let strongSelf = self else {
                return Observable.just(())
            }
            let user = User(email: strongSelf.emailAddressVerifier.value)
            SharedPreferenceManager.sharedInstance.saveData(for: user)
            ScreenNavigator.sharedInstance.navigateToVC.execute((.Home, [user as AnyObject]))
            return Observable.just(())
        })
    }
    
    private func isEmailValid(emailId : String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: emailId, options: [], range: NSRange(location: 0, length: emailId.count)) != nil
    }
}
