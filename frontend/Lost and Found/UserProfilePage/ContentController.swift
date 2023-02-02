///
//  ContentController.swift
//
//  Created by Haoxuan Zou on 12.1.2021.
//
import UIKit


var foundid:[Int] = []
var lostid:[Int] = []
class ContentController: UIViewController{
    
    var foundTableView : UICollectionView;
    let reuseIdentifier_1 = "foundCellReuse"
    var pageIndex = 0;

    
    
    var filtered: [Item] = []
    var foundItems: [Item]=[]
    var cellPadding : CGFloat = 10
//    var recButton = UILabel()
    var theHeight:Float = 15;
    var delegate : userDelegate?
    
    init(){
        let foundlayout = UICollectionViewFlowLayout();
        foundTableView = UICollectionView(frame: .zero, collectionViewLayout: foundlayout)//this is of no use.
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // title = "Found Items"
    
        view.backgroundColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1)
        let sectionpadding : CGFloat = 5;
        let foundlayout = UICollectionViewFlowLayout();
        foundTableView = UICollectionView(frame: .zero, collectionViewLayout: foundlayout)
        foundTableView.translatesAutoresizingMaskIntoConstraints = false
        foundTableView.dataSource = self
        foundTableView.delegate = self
        foundTableView.backgroundColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1)
        foundTableView.register(UserItemCell.self, forCellWithReuseIdentifier: reuseIdentifier_1)
        foundlayout.minimumLineSpacing = cellPadding;
        foundlayout.scrollDirection = .vertical;
        view.addSubview(foundTableView)
        
        
        
        print("now the index is:\(self.pageIndex)")
        setupConstraints()
        getData(for:self.pageIndex);
        foundTableView.reloadData()
    }
    

//0.089
    func setupConstraints() {
        
        //the parameter used in this section. Modify the scaler, the whole thing is adjusted.
        let viewpadding : CGFloat = 10;
        
        
        NSLayoutConstraint.activate([
            foundTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            foundTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            foundTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: viewpadding),
            foundTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }

    
    func getData(for test: Int){
        foundItems = []
        print(test)
        if test == 0{
            NetworkManager.getUserFound { foundItems in
                foundid=[]
                for founditem in foundItems{
                    foundid.append(founditem.id)
                }
                print("Found decode succeed,here is ids:\(foundid)")
                self.foundItems = foundItems;
                self.foundTableView.reloadData()
                DispatchQueue.main.async {
                    self.foundTableView.reloadData();
                }//what is this for??
            }

        }
        else{
            NetworkManager.getUserLost { lostItems in
                lostid=[]
                for lostitem in lostItems{
                    lostid.append(lostitem.id)
                }
                print("Lost decode succeed, here is ids: \(lostid)")
                self.foundItems = lostItems;
                self.foundTableView.reloadData()
                DispatchQueue.main.async {
                    self.foundTableView.reloadData();
                }//what is this for??
            }

        }
    }
    

 
    
}


extension ContentController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return foundItems.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier_1, for: indexPath) as! UserItemCell;

        
        let item = foundItems[indexPath.item];
        if self.pageIndex == 0{
            print(foundid[indexPath.item])
            cell.configure(for: item, id: foundid[indexPath.item], pageindex: self.pageIndex);
        }
        else{
            cell.configure(for: item, id: lostid[indexPath.item], pageindex:self.pageIndex)
        }
        
        
        return cell;
    }
    
    
}


extension ContentController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let theWidth = collectionView.frame.width * 0.85 ;
        let theHeight = collectionView.frame.height * 0.12//note here.
        return CGSize(width: theWidth, height: theHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = foundItems[indexPath.item];
        //TODO: modify this.

        let display = FoundDescViewController();
        display.setParaForFont(Float(view.frame.height) * 0.030) //set the font size!
        display.configure(for: item);
        if let pC = display.presentationController as? UISheetPresentationController {
            pC.detents = [.large()] /// set here!
        }
        
        present(display, animated: true, completion: nil)
    }
    
}

extension ContentController:userDelegate{
    func resetItems(index: Int, completion: @escaping () -> Void) {
        completion()
        self.viewDidLoad();
    }
    

}
