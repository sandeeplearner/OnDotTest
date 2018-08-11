//
//  ScreenNavigator.swift
//  OndotTest
//
//  Created by Sandeep Bhandari on 8/12/18.
//  Copyright © 2018 ondot. All rights reserved.
//

import Foundation
import UIKit
import Action
import RxCocoa
import RxSwift

class ScreenNavigator {
    static let sharedInstance = ScreenNavigator()
    var loadRootVCAction : Action <Void,Void>! = nil
    var navigateToVC : Action <(ViewControllerType,[AnyObject]),Void>! = nil
    
    private init() {
        
        loadRootVCAction = Action<Void, Void>(workFactory: {[weak self] _ -> Observable<Void> in
            guard let _ = self else {
                return Observable.just(())
            }
            var viewControllerToLoad : UIViewController
            if let user = SharedPreferenceManager.sharedInstance.getCurrentlyLoggedInUser() {
                let navController = mainStoryBoard.instantiateInitialViewController() as! UINavigationController
                let homeViewController = navController.viewControllers[0] as! HomeViewController
                homeViewController.viewModel.currentlyLoggedInUser = user
                viewControllerToLoad = navController
            }
            else {
                let navController = loginStoryBoard.instantiateInitialViewController() as! UINavigationController
                viewControllerToLoad = navController
            }
            if let window = UIApplication.shared.keyWindow {
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    window.rootViewController = viewControllerToLoad
                }, completion: { completed in
                    // maybe do something here
                })
            }
            return Observable.just(())
        })
        
        //This is a unnecessary action,
        //Samething can be achieved by blindly calling loadRootVCAction
        //But implementing here just to show case how to pass value from one view controller to another in MVVM using Rx
        navigateToVC = Action(workFactory: {[weak self] (targetObject) -> Observable<Void> in
            guard let _ = self else {
                return Observable.just(())
            }
            let target = targetObject.0
            switch target {
            case .Home:
                let navController = mainStoryBoard.instantiateInitialViewController() as! UINavigationController
                let homeViewController = navController.viewControllers[0] as! HomeViewController
                homeViewController.viewModel.currentlyLoggedInUser = targetObject.1[0] as! User
                if let window = UIApplication.shared.keyWindow {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        window.rootViewController = navController
                    }, completion: { completed in
                        // maybe do something here
                    })
                }
            }
            return Observable.just(())
        })
    }
}
