//
//  File.swift
//  Cafe_Manager
//
//  Created by Lahiru on 4/30/21.
//  Copyright © 2021 Lahiru. All rights reserved.
//
import Foundation
class Category {
    var category : String
    var id : String
    var isDelete : String
    
   
    
    init(category : String,id : String,isDelete : String) {
        
        self.category = category
        self.id = id
        self.isDelete = isDelete
        
    }
}
