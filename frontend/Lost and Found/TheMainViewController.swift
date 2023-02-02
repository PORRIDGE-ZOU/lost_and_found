//
//  TheMainViewController.swift
//  Lost and Found
//
//  Created by Haoxuan Zou on 11/30/21.
//

import Foundation
import UIKit

class TheMainViewController:UIViewController{
    
    
    //used to login automatically
    override func viewDidLoad() {
//        if let decodeSuccess = try? decoder.decode(User1.self, from: userData.object(forKey: "UserProf") as! Data){
//            print(decodeSuccess)
//            userData.set(decodeSuccess.session_token, forKey: "Authorization")
//            print(decodeSuccess.session_token)
//            print("decode user succeed! go to main page!")
//            let QVC = QuestionViewController()
//            self.navigationController?.pushViewController(QVC, animated: true)
//        }else{
//            print("decode user failure! go to login!")
//            let MVC = MainViewController();
//            self.navigationController?.pushViewController(MVC, animated: true)
//        }
        let QVC = QuestionViewController();
        self.navigationController?.pushViewController(QVC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.hidesBackButton=true
    }
}
