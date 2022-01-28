import SwiftUI


protocol userDelegate:class{
    func resetItems(index:Int, completion: @escaping ()->Void) -> Void
}
class UserItemCell: UICollectionViewCell {
    
    var name = UILabel()
    var location = UILabel()
    var time = UILabel()
    var rec = UILabel()
    var delete = UIButton(type: UIButton.ButtonType.custom) as UIButton;
    var id = 0;
    var pageindex = -1;
    var delegate:userDelegate?
    var isTapped:Bool = false;
    var imageview = UIImageView();
    var cellimage = UIImage();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for item: Item, id id: Int, pageindex index: Int) {
        self.id=id;
        self.pageindex = index;
        name.text = item.name
        location.text = item.location
        time.text = "\(item.time)"
        contentView.layer.cornerRadius = 25;
        
        let recwidth = Float(contentView.frame.width) * (2.3/3)
        rec.frame = CGRect.init(x: contentView.frame.minX, y: contentView.frame.minY, width: CGFloat(recwidth), height: contentView.frame.height)
        rec.layer.backgroundColor = UIColor(red: 0.941, green: 0.961, blue: 0.976, alpha: 1).cgColor
        rec.layer.cornerRadius = 25
        
        contentView.addSubview(rec)
        
        let namefont = contentView.frame.height * 0.28
        name.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: namefont)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .black;
        contentView.addSubview(name)
        
        let locafont = namefont * (2/3)
        location.font = UIFont(name:"RoundedMplus1c-Regular", size: locafont)
        location.textColor=UIColor(red: 0.557, green: 0.557, blue: 0.557, alpha: 1)
        location.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(location)
        
        //do we really need this?
        let timefont = locafont * (5/6)
        time.font = UIFont(name: "RoundedMplus1c-Light", size: timefont)
        time.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.557, alpha: 1)
        time.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(time)
        
        
        let image = UIImage(named: "trash_full") as UIImage?
//      button.frame = CGRectMake(100, 100, 100, 100)
        delete.setImage(image,for:.normal)
        delete.imageView?.contentMode = .scaleAspectFill
        delete.imageView?.clipsToBounds = true
        delete.translatesAutoresizingMaskIntoConstraints=false;
//        delete.setTitleColor(.red, for: .normal)
        contentView.addSubview(delete)
        delete.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
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
    
    @objc func deleteTapped(){

        if (true){
            if self.pageindex == 0{
                NetworkManager.deleteFound(id: self.id) { item in
                    print("delete success!")
                }
            }
            else if self.pageindex == 1{
                NetworkManager.deleteLost(id: self.id) { item in
                    print("delete success!")
                }
            }
            self.removeFromSuperview()
            self.delegate?.resetItems(index: pageindex, completion: {
            
            self.removeFromSuperview()
            self.superview?.reloadInputViews()
            })//I REALLY DONT KNOW HOW TO RELOAD THE DATA SUCCESSFULLY.
            //TODO: just how????
            self.isTapped.toggle()
        }


        
    }
 
    
    func setupConstraints() {
        
        //the parameter used in this section. Modify the scaler, the whole thing is adjusted.
        let toppad2 = contentView.frame.height * 0.108
        let nameheight = contentView.frame.height * 0.35
        let namelead = contentView.frame.width * 0.08
        let namewidth = contentView.frame.width * (3/7)
        
        
        NSLayoutConstraint.activate([
            name.widthAnchor.constraint(equalToConstant: namewidth),
            name.heightAnchor.constraint(equalToConstant: nameheight),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: namelead),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: toppad2),
        ])
        
        
        let toppad1 = nameheight * (1/50)
        NSLayoutConstraint.activate([
            location.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            location.topAnchor.constraint(equalTo: name.bottomAnchor),
            location.widthAnchor.constraint(equalTo: name.widthAnchor)
        ])
        
        

        NSLayoutConstraint.activate([
            time.topAnchor.constraint(equalTo: location.bottomAnchor, constant: toppad1),
            time.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            time.widthAnchor.constraint(equalTo: name.widthAnchor)
        ])
        

        NSLayoutConstraint.activate([
            delete.leadingAnchor.constraint(equalTo: rec.trailingAnchor, constant: 25),
            delete.heightAnchor.constraint(equalToConstant: 35),
            delete.widthAnchor.constraint(equalToConstant: 30),
            delete.centerYAnchor.constraint(equalTo: rec.centerYAnchor)
        ])
        
        
        let imagelead = contentView.frame.width * 0.541
        let imagetrail = contentView.frame.width * 0.28
        let imagetop = contentView.frame.height * 0.11
        NSLayoutConstraint.activate([
            imageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: imagelead),
            imageview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -imagetrail),
            imageview.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.8),
            imageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: imagetop)
        ])
        
        

        
    }

}
