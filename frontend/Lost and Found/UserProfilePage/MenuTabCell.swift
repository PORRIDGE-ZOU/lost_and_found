//
//  BasicCell.swift
//  MyPagerCollView
//
//  Created by Leela Prasad on 08/03/18.
//  Revised and Modified by Haoxuan Zou on 12.1.2021.
//

import UIKit

class MenuTabCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    
    var indicatorView: UIView!

    override var isSelected: Bool {
        
        didSet{
            UIView.animate(withDuration: 0.30) {
                self.indicatorView.backgroundColor = self.isSelected ? UIColor(red: 0.859, green: 0.875, blue: 0.922, alpha: 1) : UIColor.clear
                self.layoutIfNeeded()
                //UIColor(red: 0.505, green: 0.524, blue: 0.637, alpha: 1)
//
//                // underline when selected
//                var attributedString = NSMutableAttributedString.init(string: self.titleLabel.text!)
//
//                // Add Underline Style Attribute.
//                if (self.isSelected){
//                    attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
//                    NSRange.init(location: 0, length: attributedString.length));
//                    self.titleLabel.attributedText = attributedString
//                }
                
            }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(red: 0.859, green: 0.875, blue: 0.922, alpha: 1)
        titleLabel.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: 18)
        addSubview(titleLabel)
        addConstraintsWithFormatString(formate: "H:|[v0]|", views: titleLabel)
        addConstraintsWithFormatString(formate: "V:|[v0]|", views: titleLabel)
        
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        setupIndicatorView()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
   
    
    func configure(isSelect: Bool){
        self.isSelected = isSelect
    }
    
    
    func setupIndicatorView() {
        indicatorView = UIView()
        addSubview(indicatorView)
        
        addConstraintsWithFormatString(formate: "H:|[v0]|", views: indicatorView)
        addConstraintsWithFormatString(formate: "V:[v0(5)]|", views: indicatorView)
    }
    
}
