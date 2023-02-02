//
//  User.swift
//  
//
//  Created by Haoxuan Zou on 11/30/21.
//

import Foundation

struct User1:Codable{
    var session_token:String
    var session_expiration:String
    var update_token:String
    var detail:UserInfo
    struct UserInfo:Codable{
        var id:Int;
        var email:String;
        var lost:[Item]?;
        var found:[Item]?;
        struct Item:Codable{
            var id:Int
            var name: String
            var location: String
            var time: String?
            var description: String
            var user: Int
            var contact:String?
            var image:String?
        }
    }
}
//    struct UserInfo:Codable{
//        var id:Int;
//        var email:String;
//        var lost:[Item1]?;
//        var found:[Item1]?;
//        struct Item1: Codable{
//            var id:Int
//            var name: String
//            var location: String
//            var time: String?
//            var description: String
//            var user: Int
//        }
//    }


//
//class User:Codable{
//    var session_token:String;
//    var session_expiration:String;
//    var update_token:String;
//    var detail:UserInfo;
//
//    init(session_token:String,session_expiration:String,update_token:String,detail:UserInfo){
//        print("Trying User1")
//        self.session_token=session_token;
//        self.session_expiration=session_expiration;
//        self.update_token=update_token;
//        self.detail=detail;
//    }
//}
