//
//  FoundTableViewCell.swift
//  LostandFound
//
//  Created by Vivian on 11/20/21.
//
import SwiftUI

class FoundTableViewCell: UICollectionViewCell {
    
    var name = UILabel()
    var location = UILabel()
    var time = UILabel()
    var rec = UILabel()
    var imageview = UIImageView();
    var cellimage = UIImage();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for item: Item)   {
        
        name.text = item.name
        location.text = item.location
        time.text = "\(item.time)"
//        des_image.image = item.pics
        contentView.backgroundColor = UIColor(red: 0.938, green: 0.974, blue: 0.98, alpha: 1)
        contentView.layer.cornerRadius = 25;
        
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 0
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.masksToBounds = false
        
        rec.layer.backgroundColor = UIColor(red: 0.941, green: 0.961, blue: 0.976, alpha: 1).cgColor
        rec.layer.cornerRadius = 25
        rec.shadowColor = .gray
        contentView.addSubview(rec)
        
        
        let namefont = contentView.frame.height * 0.2
        name.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: namefont)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .black;
        contentView.addSubview(name)
        
        
        let locafont = namefont * (5/6)
        location.font = UIFont(name:"RoundedMplus1c-Regular", size: locafont)
        location.textColor=UIColor(red: 0.557, green: 0.557, blue: 0.557, alpha: 1)
        location.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(location)

        
        let dataDecoded:NSData? = NSData(base64Encoded: item.image ?? "", options: NSData.Base64DecodingOptions(rawValue: 0))
        var decodedimage = UIImage()
        if dataDecoded == nil{
            print("datadecoded is nil1")
        }else{
            decodedimage = UIImage(data: dataDecoded as! Data) ?? UIImage()
        }
        
        self.cellimage = decodedimage;
        self.imageview.image = cellimage;
//        imageview.image = UIImage.init(named: "try1")
        imageview.clipsToBounds = true;
        imageview.backgroundColor = .clear
        imageview.translatesAutoresizingMaskIntoConstraints=false;
        contentView.addSubview(imageview)
        imageview.layer.cornerRadius = 6
        

        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
        //the parameter used in this section. Modify the scaler, the whole thing is adjusted.
        let toppad2 = contentView.frame.height * 0.16
        let nameheight = contentView.frame.height * 0.25
        let namelead = contentView.frame.width * 0.06
        let namewidth = contentView.frame.width * (4/7)
        let toppad1 = nameheight * (4/50)
        
        
        NSLayoutConstraint.activate([
            name.widthAnchor.constraint(equalToConstant: namewidth),
            name.heightAnchor.constraint(equalToConstant: nameheight),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: namelead),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: toppad2),
        ])
        
        
        
        NSLayoutConstraint.activate([
            location.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            location.topAnchor.constraint(equalTo: name.bottomAnchor,constant: toppad1),
            location.widthAnchor.constraint(equalTo: name.widthAnchor)
        ])
        
        
        
        let imagelead = contentView.frame.width * 0.701
        let imagetrail = contentView.frame.width * 0.07
        let imagetop = contentView.frame.height * 0.11
        NSLayoutConstraint.activate([
            imageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: imagelead),
            imageview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -imagetrail),
            imageview.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.8),
            imageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: imagetop)
        ])
        
        
        

    }

}
