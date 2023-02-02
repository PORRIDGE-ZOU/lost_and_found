//
//  UserViewController.swift
//  Lost and Found
//
//  Created by Haoxuan Zou on 11/30/21.
//

import Foundation
import UIKit

class UserViewController:UIViewController{
    
    
    private var name = UILabel();
    private var email = UILabel();
    private var menuBarView = MenuTabView()
    private var tabs = ["Found Items","Lost Items"]
    var currentIndex: Int = 0
    var pageController: UIPageViewController!

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        //TODO: set all the fonts and formats
        view.layer.backgroundColor = UIColor(red: 0.859, green: 0.875, blue: 0.922, alpha: 1).cgColor
        
        //title
        title = "Profile";
        
        let titleview = UILabel();
        titleview.text = "Profile";
        titleview.textColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1)
        let titleheight = view.frame.height * 0.030;
        titleview.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: 22)
        self.navigationItem.titleView = titleview;
        titleview.textAlignment = .center;
        
        let rightbutton = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(righttapped))
        navigationItem.rightBarButtonItem = rightbutton;
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        
        let navBar = self.navigationController!.navigationBar
        let appearance = UINavigationBarAppearance();
        appearance.configureWithTransparentBackground();
        navBar.standardAppearance = appearance;
        navBar.scrollEdgeAppearance = appearance;
        navBar.compactAppearance = appearance;

        
        //set name
        if let userProf = try? decoder.decode(User1.self, from: userData.object(forKey: "UserProf") as! Data){
            print("userView, decode success")
            self.name.text = "NetId:" + userProf.detail.email
            self.email.text = userProf.detail.email + "@cornell.edu"
        }else{
            print("userview, if let fails")
        }
        
        
        let nametop:CGFloat = view.frame.height * 0.08
        let nameh : CGFloat = view.frame.height * 0.031
        name.translatesAutoresizingMaskIntoConstraints=false
        name.textColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1)
        name.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: nameh)
        view.addSubview(name)
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: nametop),
            name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.frame.width*0.072),
            name.heightAnchor.constraint(equalToConstant: nameh)
        ])
        
        
        email.translatesAutoresizingMaskIntoConstraints=false
        email.textColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1)
        email.font = UIFont(name: "RoundedMplus1c-Light", size: (nameh * 2/3))
        view.addSubview(email)
        NSLayoutConstraint.activate([
            email.topAnchor.constraint(equalTo: name.safeAreaLayoutGuide.bottomAnchor, constant: 5),
            email.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: view.frame.width*0.072)
            ])
        
        
        
        let menutop = view.frame.height * 0.23
        let menubot = view.frame.height * 0.06
        //set menubar
        menuBarView.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(menuBarView)
        menuBarView.dataArray = ["My Found","My Lost "]
        menuBarView.collView.backgroundColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1)
        
        // menuBarView.collView.tintColor = UIColor(red: 0.859, green: 0.875, blue: 0.922, alpha: 1)
        // UIFont(name: "RoundedMplus1c-ExtraBold", size: 18)
        NSLayoutConstraint.activate([
            menuBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            menuBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: menutop),
            menuBarView.heightAnchor.constraint(equalToConstant: menubot)
        ])
        menuBarView.isSizeToFitCellsNeeded = false
        menuBarView.menuDelegate = self
        menuBarView.collView.selectItem(at: IndexPath.init(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)

 
        //0.312
        //set pagecontroller
        pageController = PageControllerVC();
        pageController.delegate = self
        pageController.dataSource = self
        print(view.frame.height)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        pageController.setViewControllers([viewController(At: 0)!], direction: .forward, animated: true, completion: nil)
 

        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParent: self)
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: menuBarView.bottomAnchor),
            pageController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])


    }
    
    
    @objc func righttapped(){
        userData.set(Data(), forKey: "UserProf");
        let TMVC = TheMainViewController()
        self.navigationController?.pushViewController(TMVC, animated: true);
    }
}



extension UserViewController: MenuBarDelegate {

    
    func menuBarDidSelectItemAt(menu: MenuTabView, index: Int) {
        print(index)
        if index != currentIndex {
            if index > currentIndex {
                print("larger!")
                self.pageController.setViewControllers([viewController(At: index)!], direction: .forward, animated: true, completion: nil)
            }else {
                print("lower!")
                self.pageController.setViewControllers([viewController(At: index)!], direction: .reverse, animated: true, completion: nil)
            }
        }
        currentIndex = index
        print("now menubar didselceting.")
        menuBarView.collView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
        
    }
    
    
    func viewController(At index: Int) -> UIViewController? {
        if((self.menuBarView.dataArray.count == 0) || (index >= self.menuBarView.dataArray.count)) {
            return nil
        }
        let cc = ContentController()
        cc.pageIndex = index
        return cc;
    }

}



extension UserViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ContentController).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return self.viewController(At: index)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ContentController).pageIndex
        
        if (index == tabs.count) || (index == NSNotFound) {
            return nil
        }
        
        index += 1
        return self.viewController(At: index)
        
    }
   
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished {
            if completed {
                let cvc = pageViewController.viewControllers!.first as! ContentController
                let newIndex = cvc.pageIndex
                menuBarView.collView.selectItem(at: IndexPath.init(item: newIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
                menuBarView.collView.scrollToItem(at: IndexPath.init(item: newIndex, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
        
    }
    
}


