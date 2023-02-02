//
//  Item.swift
//  LostandFound
//
//  Created by Vivian on 11/20/21.
//
import Foundation
import UIKit

class Item:Codable{
    var id:Int
    var name: String
    var location: String
    var time: String
    var description: String
    var user: Int
    var image: String?
    var contact: String
    
    init(id:Int, name: String, location: String, time: String, description: String,user: Int, image:String?, contact: String) {
        self.name = name
        self.location = location
        self.time = time
        self.description=description
        self.user=user
        self.image = image;
        self.id = id
        self.contact = contact
    }
    
}
