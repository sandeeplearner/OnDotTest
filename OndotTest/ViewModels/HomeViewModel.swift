//
//  HomeViewModel.swift
//  OndotTest
//
//  Created by Sandeep Bhandari on 8/12/18.
//  Copyright © 2018 ondot. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class HomeViewModel : BaseViewModel {
    var currentlyLoggedInUser : User! = nil
    var logoutTapActionHandler : CocoaAction! = nil

    required init() {
        super.init()
        logoutTapActionHandler = CocoaAction(workFactory: {[weak self] _ -> Observable<Void> in
            guard let _ = self else {
                return Observable.just(())
            }
            SharedPreferenceManager.sharedInstance.clearUserData()
            ScreenNavigator.sharedInstance.loadRootVCAction.execute(())
            return Observable.just(())
        })
    }
}
