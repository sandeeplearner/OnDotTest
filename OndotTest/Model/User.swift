//
//  User.swift
//  OndotTest
//
//  Created by Sandeep Bhandari on 8/11/18.
//  Copyright © 2018 ondot. All rights reserved.
//

import Foundation

struct User : Codable {
    var emailId : String
    
    init(email : String) {
        self.emailId = email
    }
}
