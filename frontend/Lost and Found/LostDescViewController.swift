//
//  LostDescViewController.swift
//  Lost and Found
//
//  Created by Haoxuan Zou on 11/29/21.
//

import SwiftUI

class LostDescViewController: UIViewController{
    
    var foundtitle = UILabel()
    var name_title = UILabel()
    var name = UILabel()
    var loc_title = UILabel()
    var location = UILabel()
    var time_title = UILabel()
    var time = UILabel()
    var note_title = UILabel()
    var note = UILabel()
    var contact_title = UILabel()
    var contact = UILabel()
    
    var imageLabel = UILabel()
    var pic = UIImageView()
    var isThereImage = false
    
    var fontSizeBase : Float = 15;

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lost Description"
        view.backgroundColor = .white

        setupViews()
        setupConstraints()
    }
    
    func configure(for item: Item) {
        name.text = item.name
        location.text = item.location
        if item.time == ""{
            time.text = "The owner didn't enter lost time."
        }else{
            time.text = item.time
        }
        contact.text = item.contact
        if item.description == ""{
            note.text = "The owner didn't write any notes."
        }else{
            note.text = item.description
        }
        let dataDecoded:NSData? = NSData(base64Encoded: item.image ?? "", options: NSData.Base64DecodingOptions(rawValue: 0))
        var decodedimage = UIImage()
        if dataDecoded == nil{
            print("found descrip, datadecoded is nil1")
            
        }else{
            decodedimage = UIImage(data: dataDecoded as! Data) ?? UIImage()
            if decodedimage == UIImage(){
                self.isThereImage=false
            }else{
                self.isThereImage = true
            }
        }
        self.pic.image = decodedimage;
    }
    
    func setParaForFont(_ size: Float){
        self.fontSizeBase = size;
    }
    
    func setupViews(){
        
        //the parameter used in this section. Modify the scaler, the whole thing is adjusted.
        let theFont = CGFloat(self.fontSizeBase * 1.08);//here the fontSizeBase is set by the setter function above (setParaForFont), which is called in the very last part of FoundViewController.
        let color: UIColor = UIColor(red: 0.071, green: 0.298, blue: 0.455, alpha: 1)
        
        
        foundtitle.text = "Lost Description"
        foundtitle.textColor=color;
        foundtitle.translatesAutoresizingMaskIntoConstraints=false;
        foundtitle.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: theFont*1.25)
        view.addSubview(foundtitle)
        
        
        //name_title
        name_title.text="Item's Name:"
        name_title.textColor = color
        name_title.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: theFont)
        name_title.adjustsFontForContentSizeCategory = true;
        name_title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name_title)
        
        name.font = UIFont(name: "RoundedMplus1c-Light", size: theFont*(4/5))
        name.translatesAutoresizingMaskIntoConstraints = false
        name.adjustsFontForContentSizeCategory = true;
        view.addSubview(name)
        
        loc_title.text="Location:"
        loc_title.textColor = color
        loc_title.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: theFont)
        loc_title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loc_title)
        
 
        location.font = UIFont(name: "RoundedMplus1c-Light", size: theFont*(4/5))
        location.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(location)
        
        time_title.text="Lost Time:"
        time_title.textColor = color
        time_title.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: theFont)
        time_title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(time_title)
        

        time.font = UIFont(name: "RoundedMplus1c-Light", size: theFont*(4/5))
        time.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(time)
        
        note_title.text="Description"
        note_title.textColor = color
        note_title.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: theFont)
        note_title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(note_title)
        
        note.textColor = .black
        note.font = UIFont(name: "RoundedMplus1c-Light", size: theFont*(4/5))
        note.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(note)

        if self.isThereImage{
            imageLabel.text = "Image:"
            imageLabel.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: theFont)
            imageLabel.textColor=color
        }

        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageLabel)
        
        pic.clipsToBounds = true;
        pic.backgroundColor = .white
        pic.translatesAutoresizingMaskIntoConstraints=false;
        view.addSubview(pic)
        pic.layer.cornerRadius = 6
        
        
        contact_title.text="Contact:"
        contact_title.textColor = color
        contact_title.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: theFont)
        contact_title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contact_title)
        

        contact.font = UIFont(name: "RoundedMplus1c-Light", size: theFont*(4/5))
        contact.textAlignment = .natural
        contact.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contact)
        
    }
    
    func setupConstraints(){
        
        //the parameter used in this section. Modify the scaler, the whole thing is adjusted.
        let s_padding: CGFloat = 5
        let l_padding: CGFloat = 12
        let leading: CGFloat = 30
        let thewidth = view.frame.width - leading*2
        
        NSLayoutConstraint.activate([
            foundtitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: l_padding),
            foundtitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            name_title.widthAnchor.constraint(equalToConstant: thewidth),
            name_title.heightAnchor.constraint(equalToConstant: 28),
            name_title.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            name_title.topAnchor.constraint(equalTo: foundtitle.safeAreaLayoutGuide.topAnchor, constant: 45),
        ])
        
        NSLayoutConstraint.activate([
            name.widthAnchor.constraint(equalToConstant: 300),
            name.heightAnchor.constraint(equalToConstant: 24),
            name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            name.topAnchor.constraint(equalTo: name_title.bottomAnchor, constant: s_padding),
        ])
        
        NSLayoutConstraint.activate([
            loc_title.widthAnchor.constraint(equalToConstant: 305),
            loc_title.heightAnchor.constraint(equalToConstant: 32),
            loc_title.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            loc_title.topAnchor.constraint(equalTo: name.bottomAnchor, constant: l_padding),
        ])
        
        NSLayoutConstraint.activate([
            location.widthAnchor.constraint(equalToConstant: 305),
            location.heightAnchor.constraint(equalToConstant: 24),
            location.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            location.topAnchor.constraint(equalTo: loc_title.bottomAnchor, constant: s_padding),
        ])
        
        NSLayoutConstraint.activate([
            time_title.widthAnchor.constraint(equalToConstant: 167),
            time_title.heightAnchor.constraint(equalToConstant: 28),
            time_title.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            time_title.topAnchor.constraint(equalTo: location.bottomAnchor, constant: l_padding),
        ])
        
        NSLayoutConstraint.activate([
            time.widthAnchor.constraint(equalToConstant: thewidth),
            time.heightAnchor.constraint(equalToConstant: 20),
            time.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            time.topAnchor.constraint(equalTo: time_title.bottomAnchor, constant: s_padding),
        ])
        
        NSLayoutConstraint.activate([
            note_title.widthAnchor.constraint(equalToConstant: 329),
            note_title.heightAnchor.constraint(equalToConstant: 28),
            note_title.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            note_title.topAnchor.constraint(equalTo: time.bottomAnchor, constant: l_padding),
        ])
        
        NSLayoutConstraint.activate([
            note.widthAnchor.constraint(equalToConstant: thewidth),
            note.heightAnchor.constraint(equalToConstant: 25),
            note.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            note.topAnchor.constraint(equalTo: note_title.bottomAnchor, constant: s_padding),
        ])
        
  
        
        NSLayoutConstraint.activate([
            contact_title.widthAnchor.constraint(equalToConstant: 287),
            contact_title.heightAnchor.constraint(equalToConstant: 28),
            contact_title.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            contact_title.topAnchor.constraint(equalTo: note.bottomAnchor, constant: l_padding),
        ])
        
        NSLayoutConstraint.activate([
            contact.widthAnchor.constraint(equalToConstant: thewidth),
            contact.heightAnchor.constraint(equalToConstant: 30),
            contact.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            contact.topAnchor.constraint(equalTo: contact_title.bottomAnchor, constant: s_padding),
        ])
        
        NSLayoutConstraint.activate([
            imageLabel.widthAnchor.constraint(equalToConstant: 329),
            imageLabel.heightAnchor.constraint(equalToConstant: 30),
            imageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            imageLabel.topAnchor.constraint(equalTo: contact.bottomAnchor, constant: l_padding),
        ])
        
        NSLayoutConstraint.activate([
            pic.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            pic.heightAnchor.constraint(equalToConstant: view.frame.width/2),
            pic.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
            pic.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: s_padding),
        ])
        

    }
}
