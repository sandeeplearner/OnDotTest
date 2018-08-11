//
//  SharedPreferenceManager.swift
//  OndotTest
//
//  Created by Sandeep Bhandari on 8/12/18.
//  Copyright © 2018 ondot. All rights reserved.
//

import Foundation

class SharedPreferenceManager {
    private var user : User? = nil
    static let sharedInstance = SharedPreferenceManager()
    
    private init() {
        //empty implementation
    }
    
    func getCurrentlyLoggedInUser() -> User? {
        if self.user != nil {
            return self.user
        }
        if let userData = UserDefaults().data(forKey: "userInfo") {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: userData)
            do {
                if let user = try unarchiver.decodeTopLevelDecodable(User.self, forKey: NSKeyedArchiveRootObjectKey) {
                    self.user = user
                }
            } catch {
                print("unarchiving failure: \(error)")
            }
        }
        return self.user
    }
    
    func saveData(for user : User) {
        let userData = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: userData)
        try! archiver.encodeEncodable(user, forKey: NSKeyedArchiveRootObjectKey)
        archiver.finishEncoding()
        UserDefaults().setValue(userData, forKey: "userInfo")
    }
    
    func clearUserData() {
        UserDefaults().removeObject(forKey: "userInfo")
        self.user = nil
    }
}
