//
//  ViewController.swift
//  L5Starter
//
//  Created by Vivian Fan on 11/20/2021.
//
import UIKit

class FoundViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate{
    
    var foundTableView : UICollectionView;
    let reuseIdentifier_1 = "foundCellReuse"
    
    let searchController = UISearchController(searchResultsController: nil);
    var searchActive: Bool = false
    
    var filtered: [Item] = []
    var foundItems: [Item]=[]
    var PostLost_Button = UIButton()
//    var recButton = UILabel()
    var theHeight:Float = 15;
    var titleright = UIImageView()
    var tryimage = UIImageView()
    
    init(){
        let foundlayout = UICollectionViewFlowLayout();
        foundTableView = UICollectionView(frame: .zero, collectionViewLayout: foundlayout)//this is of no use.
        
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
        // title = "Found Items"
        
        let navBar = self.navigationController!.navigationBar;
//        navBar.isTranslucent = true;
//        navBar.titleTextAttributes = [.backgroundColor: UIColor(.clear)]//this is of no use!
        let titleview = UILabel();
        titleview.text = "Found Items";
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
        //https://developer.apple.com/documentation/uikit/uinavigationcontroller/customizing_your_app_s_navigation_bar
//        let height: CGFloat = 300 //whatever height you want to add to the existing height
//        let bounds = self.navigationController!.navigationBar.bounds
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
            
        
        tryimage.image = UIImage.init(named: "Image-1");
        tryimage.translatesAutoresizingMaskIntoConstraints=false;
        view.addSubview(tryimage);
        tryimage.topAnchor.constraint(equalTo: view.topAnchor).isActive=true;
        tryimage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true;
        tryimage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true;
        tryimage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true

        let searchwidth = view.frame.width * 3/4
        let frame = CGRect(x: 0, y: 0, width: 400, height: 44)
        //search bar
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Items..."
        //working!
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.layer.cornerRadius = 10;
        searchController.searchBar.searchTextField.widthAnchor.constraint(equalToConstant: searchwidth).isActive=true;
        searchController.searchBar.searchTextField.centerXAnchor.constraint(equalTo: searchController.searchBar.centerXAnchor,constant: view.frame.width/2).isActive=true
        searchController.searchBar.searchTextField.topAnchor.constraint(equalTo: searchController.searchBar.topAnchor,constant: 10).isActive=true
        searchController.searchBar.searchTextField.frame = frame;
        searchController.searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints=false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints=false
        searchController.searchBar.setValue("↩️", forKey: "cancelButtonText")
        self.navigationItem.searchController=searchController
        //I've tried out several methods but I just cannot make it STAY.
        
        
        let cellPadding : CGFloat = view.frame.height * 0.113 * 0.236
        let foundlayout = UICollectionViewFlowLayout();
        foundTableView = UICollectionView(frame: .zero, collectionViewLayout: foundlayout)
        foundTableView.backgroundColor = .clear

        foundTableView.translatesAutoresizingMaskIntoConstraints = false
        foundTableView.dataSource = self
        foundTableView.delegate = self
//        foundTableView.backgroundColor = view.backgroundColor;
        foundTableView.register(FoundTableViewCell.self, forCellWithReuseIdentifier: reuseIdentifier_1)
        foundlayout.minimumLineSpacing = cellPadding;
        foundlayout.scrollDirection = .vertical;
        view.addSubview(foundTableView)
        
        
        PostLost_Button.frame = CGRect(x: 0, y: 0, width: 130, height: 46)
        PostLost_Button.setTitle("Post Lost", for: .normal)
        PostLost_Button.layer.backgroundColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1).cgColor
        PostLost_Button.layer.cornerRadius = 23
        PostLost_Button.addTarget(self, action: #selector(PostLostTapped), for: .touchUpInside)
        PostLost_Button.setTitleColor(UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1), for: .normal);
        PostLost_Button.titleLabel?.font = UIFont(name:"RoundedMplus1c-Medium", size: 18);
        
        PostLost_Button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        PostLost_Button.layer.shadowOpacity = 0.5
        PostLost_Button.layer.shadowRadius = 0
        PostLost_Button.layer.shadowOffset = CGSize(width: 0, height: 3)
        PostLost_Button.layer.masksToBounds = false
        
        PostLost_Button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(PostLost_Button)
  
//        let rightimage = UIImage.init(named: "usericon");
//        titleright.image = rightimage;
//        navigationItem.setRightBarButton(UIBarButtonItem(customView: titleright), animated: true)
        navigationItem.rightBarButtonItem?.customView?.translatesAutoresizingMaskIntoConstraints=false
//        view.addSubview(navigationItem.rightBarButtonItem?.customView ?? UIView())
//        navigationItem.rightBarButtonItem?.customView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive=true
//        navigationItem.rightBarButtonItem?.customView?.heightAnchor.constraint(equalToConstant: 20).isActive=true
        let rightbutton = UIBarButtonItem(image: UIImage.init(named: "usericon"), style: .plain, target: self, action: #selector(righttapped))
        navigationItem.rightBarButtonItem = rightbutton;
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.customView?.trailingAnchor.constraint(equalTo: navigationItem.titleView?.trailingAnchor ?? view.trailingAnchor, constant: 0).isActive=true
        
        
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        
        navigationItem.backBarButtonItem = backBarButtton
//        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "backbutton"), style: .plain, target: self, action: nil)

        setupConstraints()
        getData();
    }
    
    @objc func backTapped(){
        print("hello world.!!!!!")
    }
    
    
    @objc func PostLostTapped() {
            if let decodeSuccess = try? decoder.decode(User1.self, from:userData.object(forKey: "UserProf") as! Data){
//                print(decodeSuccess)
                userData.set(decodeSuccess.session_token, forKey: "Authorization")
//                print(decodeSuccess.session_token)
                print("decode user succeed! go to main page!")
                let PLVC = PostLostViewController();
                self.navigationController?.pushViewController(PLVC, animated: true)
            }else{
                print("decode user failure! go to login!")
                let MVC = MainViewController();
                self.navigationController?.pushViewController(MVC, animated: true)
                }
        
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
    
    
    func getData(){
        foundItems = []
        NetworkManager.getAllFound { foundItems in
            print("Found decode succeed")
            self.foundItems = foundItems;
            self.foundTableView.reloadData()
            DispatchQueue.main.async {
                self.foundTableView.reloadData();
            }//what is this for??
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        filtered = foundItems.filter({ (item) -> Bool in
            let countryText: NSString = item.name as NSString

                    return (countryText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                })
        foundTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false
            self.dismiss(animated: true, completion: nil)
        }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchActive = true
        foundTableView.reloadData()
        }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false
            foundTableView.reloadData()
        }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
            if !searchActive {
                searchActive = true
                foundTableView.reloadData()
            }

            searchController.searchBar.resignFirstResponder()
        }

    
    func setupConstraints() {
        
        //the parameter used in this section. Modify the scaler, the whole thing is adjusted.
        let viewpadding : CGFloat = 10;
        
        
        NSLayoutConstraint.activate([
            foundTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            foundTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            foundTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            foundTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            PostLost_Button.widthAnchor.constraint(equalToConstant: 130),
            PostLost_Button.heightAnchor.constraint(equalToConstant: 46),
            PostLost_Button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            PostLost_Button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
}


extension FoundViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive{return filtered.count}
        else{
            return foundItems.count;}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier_1, for: indexPath) as! FoundTableViewCell;
        
        if searchActive {
            let item = filtered[indexPath.item]
            cell.configure(for: item);
        }
        else{
            let item = foundItems[indexPath.item];
            cell.configure(for: item);
        }
        return cell;
    }
    
    
}


extension FoundViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let theWidth = collectionView.frame.width * 0.825 ;
        let theHeight = self.view.frame.height * 0.113//note here.
        return CGSize(width: theWidth, height: theHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = foundItems[indexPath.item];
        if let decodeSuccess = try? decoder.decode(User1.self, from:userData.object(forKey: "UserProf") as! Data){
//            print(decodeSuccess)
            userData.set(decodeSuccess.session_token, forKey: "Authorization")
            print(decodeSuccess.session_token)
            print("decode user succeed! go to main page!")
            let display = FoundDescViewController();
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

