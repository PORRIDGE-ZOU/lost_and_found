//
//  LostViewController.swift
//  Lost and Found
//
//  Created by Haoxuan Zou on 11/29/21.
//
import Foundation
import UIKit
import Alamofire

protocol UpdateLostDelegate: class {
    func updateLost(newLost: Item)
    func getLost()->Item
}

class LostViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate{
    // @IBOutlet weak var collectionView: UICollectionView!
    var lostTableView : UICollectionView;
    let reuseIdentifier_1 = "lostCellReuse"
    var lostItems: [Item]=[]
    var filtered:[Item] = []
    
    let searchController = UISearchController(searchResultsController: nil);
    
    var searchActive: Bool = false
    
    var PostFound_Button = UIButton()
    var theHeight:Float = 15;
    var titleright = UIImageView()
    var tryimage = UIImageView()
    
    //refresh control
    let refreshControl = UIRefreshControl()
    
    
    weak var delegate: UpdateLostDelegate?
    //init(delegate:UpdateLostDelegate){
    
    init(delegate:UpdateLostDelegate?){
        self.delegate = delegate
        let foundlayout = UICollectionViewFlowLayout();
        lostTableView = UICollectionView(frame: .zero, collectionViewLayout: foundlayout)//this is of no use.
        
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewDidLoad()
        print("view will apper.")
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(red: 0.325, green: 0.38, blue: 0.424, alpha: 1)
        
        lostTableView.delegate=self
        
        
        let searchwidth = view.frame.width * 3/4
        //search bar
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Items"
        //working!
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.layer.cornerRadius = 10;
        searchController.searchBar.searchTextField.widthAnchor.constraint(equalToConstant: searchwidth).isActive=true;
        searchController.searchBar.searchTextField.centerXAnchor.constraint(equalTo: searchController.searchBar.centerXAnchor,constant: view.frame.width/2).isActive=true
        searchController.searchBar.searchTextField.topAnchor.constraint(equalTo: searchController.searchBar.topAnchor,constant: 10).isActive=true
        searchController.searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints=false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints=false
        searchController.searchBar.setValue("↩️", forKey: "cancelButtonText")
        self.navigationItem.searchController=searchController
        self.navigationItem.searchController?.automaticallyShowsScopeBar=true
        //I've tried out several methods but I just cannot make it STAY.
        

        
        let navBar = self.navigationController!.navigationBar;
//        navBar.isTranslucent = true;
//        navBar.titleTextAttributes = [.backgroundColor: UIColor(.clear)]//this is of no use!
        let titleview = UILabel();
        titleview.text = "Lost Items";
        titleview.textColor = UIColor(red: 0.938, green: 0.974, blue: 1, alpha: 1)
        let titleheight = view.frame.height * 0.026;
        titleview.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: titleheight);
        self.navigationItem.titleView = titleview; //in this way the title is properly set.
        titleview.translatesAutoresizingMaskIntoConstraints=false;
        view.addSubview(titleview)
        titleview.textAlignment = .center;
        let titletop = view.frame.height * 0.04
        titleview.topAnchor.constraint(equalTo: view.topAnchor, constant: titletop).isActive=true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        
        tryimage.image = UIImage.init(named: "Image-1");
        tryimage.translatesAutoresizingMaskIntoConstraints=false;
        view.addSubview(tryimage);
        tryimage.topAnchor.constraint(equalTo: view.topAnchor).isActive=true;
        tryimage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true;
        tryimage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true;
        tryimage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        

    
        let sectionpadding : CGFloat = view.frame.height * 0.113 * 0.236
        let lostlayout = UICollectionViewFlowLayout();
        lostTableView = UICollectionView(frame: .zero, collectionViewLayout: lostlayout)
        lostTableView.translatesAutoresizingMaskIntoConstraints = false
        lostTableView.dataSource = self
        lostTableView.delegate = self
        lostTableView.backgroundColor = view.backgroundColor;
        lostTableView.register(LostTableViewCell.self, forCellWithReuseIdentifier: reuseIdentifier_1)
        lostlayout.minimumLineSpacing = sectionpadding;
        lostlayout.scrollDirection = .vertical;
        view.addSubview(lostTableView)
        
        
        PostFound_Button.frame = CGRect(x: 0, y: 0, width: 130, height: 46)
        PostFound_Button.setTitle("Post Found", for: .normal)
        PostFound_Button.layer.backgroundColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1).cgColor
        PostFound_Button.layer.cornerRadius = 23
        PostFound_Button.addTarget(self, action: #selector(PostFoundTapped), for: .touchUpInside)
        PostFound_Button.translatesAutoresizingMaskIntoConstraints = false
        PostFound_Button.setTitleColor(UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1), for: .normal);
        PostFound_Button.titleLabel?.font = UIFont(name:"RoundedMplus1c-Medium", size: 18);
        view.addSubview(PostFound_Button)
        
        PostFound_Button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        PostFound_Button.layer.shadowOpacity = 0.5
        PostFound_Button.layer.shadowRadius = 0
        PostFound_Button.layer.shadowOffset = CGSize(width: 0, height: 3)
        PostFound_Button.layer.masksToBounds = false
        
        let rightbutton = UIBarButtonItem(image: UIImage.init(named: "usericon"), style: .plain, target: self, action: #selector(righttapped))
        navigationItem.rightBarButtonItem = rightbutton;
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.customView?.trailingAnchor.constraint(equalTo: navigationItem.titleView?.trailingAnchor ?? view.trailingAnchor, constant: 0).isActive=true
        
        
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        
        navigationItem.backBarButtonItem = backBarButtton
       
        setupConstraints()
        getData();
        
    }
    
    func sortData(){
        print("first the data is \(self.lostItems)")
        self.lostItems.sort { leftitem, rightitem in
            return leftitem.id < rightitem.id
        }
        print("now the data is \(self.lostItems)")
    }
    
    
    @objc func backTapped(){
        print("hello world.!!!!!")
    }

    @objc func righttapped(){
        if let decodeSuccess = try? decoder.decode(User1.self, from:userData.object(forKey: "UserProf") as! Data){
//            print(decodeSuccess)
            userData.set(decodeSuccess.session_token, forKey: "Authorization")
            print(decodeSuccess.session_token)
            print("decode user succeed! go to main page!")
            let PLVC = UserViewController()
            
            self.navigationController?.pushViewController(PLVC, animated: true)
        }else{
            print("decode user failure! go to login!")
            let MVC = MainViewController();
            self.navigationController?.pushViewController(MVC, animated: true)
            }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        filtered = lostItems.filter({ (item) -> Bool in
            let countryText: NSString = item.name as NSString

                    return (countryText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                })
        lostTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false
            self.dismiss(animated: true, completion: nil)
        }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchActive = true
        lostTableView.reloadData()
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false
            lostTableView.reloadData()
        }

        func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
            if !searchActive {
                searchActive = true
                lostTableView.reloadData()
            }

            searchController.searchBar.resignFirstResponder()
        }
    

    func setupConstraints() {
        
        //the parameter used in this section. Modify the scaler, the whole thing is adjusted.
        let viewpadding : CGFloat = 10;
        
        
        NSLayoutConstraint.activate([
            lostTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            lostTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            lostTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            lostTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            PostFound_Button.widthAnchor.constraint(equalToConstant: 130),
            PostFound_Button.heightAnchor.constraint(equalToConstant: 46),
            PostFound_Button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            PostFound_Button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    func getData(){
        lostItems = []
        NetworkManager.getAllLost { lostItems in
            print("decode succeed")
            self.lostItems = lostItems;
            self.lostTableView.reloadData()
            DispatchQueue.main.async {
                self.lostTableView.reloadData();
            }//what is this for??
        }
        self.sortData()
    }

    
    @objc func PostFoundTapped() {
        if let decodeSuccess = try? decoder.decode(User1.self, from:userData.object(forKey: "UserProf") as! Data){
//            print(decodeSuccess)
            userData.set(decodeSuccess.session_token, forKey: "Authorization")
            print(decodeSuccess.session_token)
            print("decode user succeed! go to main page!")
            let PFVC = PostFoundViewController();
            self.navigationController?.pushViewController(PFVC, animated: true)
        }else{
            print("decode user failure! go to login!")
            let MVC = MainViewController();
            self.navigationController?.pushViewController(MVC, animated: true)
            }
    }


    
}


extension LostViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive{return filtered.count}
        else{
            return lostItems.count;}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier_1, for: indexPath) as! LostTableViewCell;
        if searchActive {
            let item = filtered[indexPath.item]
            cell.configure(for: item);
        }
        else{
            let item = lostItems[indexPath.item];
            cell.configure(for: item);
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 0)
    }
    
    
}


extension LostViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let theWidth = self.view.frame.width * 0.825 ;
        let theHeight = self.view.frame.height * 0.113//note here.
        return CGSize(width: theWidth, height: theHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = lostItems[indexPath.item];
        if let decodeSuccess = try? decoder.decode(User1.self, from:userData.object(forKey: "UserProf") as! Data){
//            print(decodeSuccess)
            userData.set(decodeSuccess.session_token, forKey: "Authorization")
            print(decodeSuccess.session_token)
            print("decode user succeed! go to main page!")
            let display = LostDescViewController();
            display.setParaForFont(Float(view.frame.height) * 0.022) //set the font size!
            display.configure(for: item);
            if let pC = display.presentationController as? UISheetPresentationController {
                
                pC.detents = [.large()] /// set here!
            }//look here. This is the way to show half-screen.
            //https://stackoverflow.com/questions/42106980/how-to-present-a-viewcontroller-on-half-screen
            
            present(display, animated: true, completion: nil)
        }else{
            print("decode user failure! go to login!")
            let MVC = MainViewController();
            self.navigationController?.pushViewController(MVC, animated: true)
            }
    }
    
}
