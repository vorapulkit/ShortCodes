//
//  UserClass.swift
//  Structure
//
//  Created by Pulkit on 6/17/17.
//  Copyright © 2017 Pulkit. All rights reserved.
//

import UIKit

class UserClass: NSObject {

    var firstName = ""
    var lastName = ""
    var age = 0;
    
    
    
    init(_firstName : String?,_lastName : String?,_age : Int) {
        
        firstName = _firstName!
        lastName = _lastName!
        age = _age
    }
    
}

extension UserClass{
    
    func fullName()->String{
        return firstName + "" + lastName
    }
    
    func ageType()->String{
        
        switch age {
        case 0...2:
            return "Baby"
        case 2...12:
            return "Child"
        case 12...29:
            return "Teenage"
        case let x where x > 65:
            return "Elder"
        default:
            return "Normal"
        }
    }
    
}
