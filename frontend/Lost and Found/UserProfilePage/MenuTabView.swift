//
//  MenuTabsView.swift
//  MyPagerCollView
//
//  Created by Leela Prasad on 09/03/18.
//  Revised and Modified by Haoxuan Zou on 12.1.2021.
//  Copyright © 2018 Leela Prasad. All rights reserved.
//

import UIKit
import SwiftUI

protocol MenuBarDelegate {
    func menuBarDidSelectItemAt(menu: MenuTabView,index: Int)
}


class MenuTabView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
   lazy var collView: UICollectionView = {
    
        let layOut = UICollectionViewFlowLayout()
        let cv = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layOut)
        cv.showsHorizontalScrollIndicator = false
        layOut.scrollDirection = .horizontal
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    var isSizeToFitCellsNeeded: Bool = false {
        didSet{
            self.collView.reloadData()
        }
    }

    var dataArray: [String] = [] {
        didSet{
            self.collView.reloadData()
        }
    }
    
    
    var menuDidSelected: ((_ collectionView: UICollectionView, _ indexPath: IndexPath)->())?

    var menuDelegate: MenuBarDelegate?
    var cellId = "BasicCell"

    
    override init(frame: CGRect) {

        super.init(frame: frame)
        
        customIntializer()
    }
    
    required init?(coder Decoder: NSCoder) {
        super.init(coder: Decoder)
       
        customIntializer()
    }
    
    
    private func customIntializer () {
        
        collView.register(MenuTabCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collView)
//        collView.topAnchor.constraint(equalTo: , constant: 50)
        //https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html ->tutorial for visual format!
        addConstraintsWithFormatString(formate: "V:|[v0]|", views: collView)
        addConstraintsWithFormatString(formate: "H:|[v0]|", views: collView)
        
    }
    
    
    //MARK: CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MenuTabCell{
            cell.titleLabel.text = dataArray[indexPath.item]
            if indexPath.item == 0{
                cell.configure(isSelect: true)
            }else{
                cell.configure(isSelect: false)
            }//TODO: how to make it?
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isSizeToFitCellsNeeded {
            
            let sizeee = CGSize.init(width: 500, height: self.frame.height)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let str = dataArray[indexPath.item]
            
            let estimatedRect = NSString.init(string: str).boundingRect(with: sizeee, options: options, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 23)], context: nil)
        
            return CGSize.init(width: estimatedRect.size.width, height: self.frame.height)

        }
        
        return CGSize.init(width: (self.frame.width - 10)/CGFloat(dataArray.count), height: self.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("menubar. didselectitem.")
        let index = Int(indexPath.item)
        menuDelegate?.menuBarDidSelectItemAt(menu: self, index: index)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }

}


extension UIView {
    
    func addConstraintsWithFormatString(formate: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: formate, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}
