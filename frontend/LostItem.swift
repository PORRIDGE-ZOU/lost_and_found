//
//  LostItem.swift
//  Lost and Found
//
//  Created by Haoxuan Zou on 11/29/21.
//

import Foundation
import UIKit

class Item{
    var objectName: String
    var location: String
    var time: String
    var note: String
    var contact: String
    var pics: UIImage
    
    init(objectName: String, location: String, time: String, note: String,contact: String, pics: UIImage) {
        self.objectName = objectName
        self.location = location
        self.time = time
        self.note=note
        self.contact=contact
        self.pics=pics
    }
    
}
