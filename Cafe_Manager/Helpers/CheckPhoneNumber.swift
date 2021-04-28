//
//  CheckPhoneNumber.swift
//  Cafe_Manager
//
//  Created by Lahiru on 4/17/21.
//  Copyright © 2021 Lahiru. All rights reserved.
//

import Foundation
class CheckPhoneNumber{
    static func isValidPhoneNumber(number:String)->Bool{
        let num = Int(number)
        if num != nil {
         return true
        }
        else {
         return false
        }
        
    }
}
