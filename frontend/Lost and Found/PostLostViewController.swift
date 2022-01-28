import SwiftUI


class PostLostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //    init(delegate: UpdateTitleDelegate?, placeholderText: String) {
    //        self.delegate = delegate
    //        self.placeholderText = placeholderText
    //        super.init(nibName: nil, bundle: nil)
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
        
        var name = UILabel()
        var nameInput = UITextField()
        
        var descrip = UILabel()
        var descripInput = UITextField()
        
        var location = UILabel()
        var locInput = UITextField()
        
        var time = UILabel()
        var timeInput = UITextField()
        
        var contact = UILabel()
        var contact_name = UILabel()
        var contact_phone = UILabel()
        var contact_time = UILabel()
        var contact_name_input = UITextField()
    //    var contact_phone_input = UITextField()
    //    var contact_time_input = UITextField()
        var contactSign = UILabel()
        
        var imagelabel = UILabel()
        var lost_image = UIButton()

        var imageUserProfile = UIImageView()
        
        var isPost:Bool = false

        var PostFound_Button = UIButton()
        
    //    var rec1 = UILabel()
    //    var rec2 = UILabel()
        override func viewDidLoad() {
            super.viewDidLoad()
            //title = "Post Found"
            let navBar = self.navigationController!.navigationBar;
    //        navBar.isTranslucent = true;
    //        navBar.titleTextAttributes = [.backgroundColor: UIColor(.clear)]//this is of no use!
            let titleview = UILabel();
            titleview.text = "Post Lost";
            titleview.textColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1)
            
            let titleheight = view.frame.height * 0.026;
            titleview.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: titleheight);
            self.navigationItem.titleView = titleview; //in this way the title is properly set.
            titleview.translatesAutoresizingMaskIntoConstraints=false;
            view.addSubview(titleview)
            
            titleview.textAlignment = .center;
            let titletop = view.frame.height * 0.04
            
            titleview.topAnchor.constraint(equalTo: view.topAnchor, constant: titletop).isActive=true
            view.backgroundColor = UIColor(red: 0.325, green: 0.38, blue: 0.424, alpha: 1)
            
            let appearance = UINavigationBarAppearance();
            appearance.configureWithTransparentBackground();
            navBar.standardAppearance = appearance;
            navBar.scrollEdgeAppearance = appearance;
            navBar.compactAppearance = appearance;
            
    //        let color: UIColor=UIColor(red: 0.788, green: 0.839, blue: 0.875, alpha: 1)
    //        let textAttributes = [NSAttributedString.Key.foregroundColor: color]
    //        navigationController?.navigationBar.titleTextAttributes = textAttributes
    //
            view.backgroundColor = UIColor(red: 0.921, green: 0.961, blue: 0.996, alpha: 0.96)

            setupViews()
            setupConstraints()
        }
        
        //alert
        private func promptUserForName()  {
            let alert = UIAlertController(title: "Please enter your name", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        private func promptUserForPhone() {
            let alert = UIAlertController(title: "Please enter lost location", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        //delegate methods for selecting images from gallery
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

               // The info dictionary may contain multiple representations of the image. You want to use the original.
               guard let selectedImage = info[.originalImage] as? UIImage else {
                   fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
               }

               // Set photoImageView to display the selected image.
               imageUserProfile.image = selectedImage
            print("imageuserprofile image set.")
               // Dismiss the picker.
            dismiss(animated: true, completion: nil)
            self.setupViews();
            self.setupConstraints()
           }
        
        @objc func showActionSheet(){
                isPost = true
            
                //Create the AlertController and add Its action like button in Actionsheet
                let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
                actionSheetController.view.tintColor = UIColor.black
                let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
                    print("Cancel")
                }
                actionSheetController.addAction(cancelActionButton)

                let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
                { action -> Void in
                    self.gallery()
                }
            
                actionSheetController.addAction(deleteActionButton)
                self.present(actionSheetController, animated: true, completion: nil)
            }
        

        
        func gallery(){
            let myPickerControllerGallery = UIImagePickerController()
            myPickerControllerGallery.delegate = self
            myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
            myPickerControllerGallery.allowsEditing = true
            self.present(myPickerControllerGallery, animated: true, completion: nil)
        }
        
        
        @objc func afterposted(){
            let deletealert = UIAlertController(title: "", message: "Delete Image?", preferredStyle: .alert);
            deletealert.addAction(UIAlertAction(title: "Nop", style: .cancel, handler: nil));
            deletealert.addAction(UIAlertAction(title: "Yep!", style: .default, handler: { alertaction in
                print("surprise.")
                self.isPost=false;
                self.imageUserProfile.image = nil
                self.setupViews()
                self.setupConstraints()
            }))
            present(deletealert, animated: true, completion: nil)
        }
        
        func setupViews(){
            let color: UIColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1)
            let border_width : CGFloat = 0.5
            
            
            imagelabel.text = "Image:"
            imagelabel.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: 18)
            imagelabel.translatesAutoresizingMaskIntoConstraints=false;
            imagelabel.textColor = color;
            view.addSubview(imagelabel)
            
            //lost_image
            lost_image.setTitle("Tap here to choose image (optional)", for: .normal)
            lost_image.layer.backgroundColor = .none
            lost_image.setTitleColor(color, for: .normal)
            lost_image.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
            lost_image.layer.borderWidth = 4;
            lost_image.layer.cornerRadius = 5
            lost_image.layer.borderColor = UIColor(red: 0.957, green: 0.863, blue: 0.816, alpha: 1).cgColor
            lost_image.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(lost_image)
            
            // imageViewPic
            if (isPost){
                lost_image.layer.borderWidth = 0;
                lost_image.setTitle("", for: .normal)
                lost_image.removeTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
                lost_image.addTarget(self, action: #selector(afterposted), for: .touchUpInside)
                imageUserProfile.clipsToBounds = true
                imageUserProfile.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(imageUserProfile);
            }else{
                lost_image.removeTarget(self, action: #selector(afterposted), for: .touchUpInside);
                lost_image.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
            }

            //PostFound_Button
            PostFound_Button.frame = CGRect(x: 0, y: 0, width: 130, height: 46)
            PostFound_Button.setTitle("Post", for: .normal)
            PostFound_Button.layer.backgroundColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1).cgColor
            PostFound_Button.setTitleColor(.white, for: .normal)
            PostFound_Button.layer.cornerRadius = 23
            PostFound_Button.addTarget(self, action: #selector(PostLTapped), for: .touchUpInside)
            PostFound_Button.translatesAutoresizingMaskIntoConstraints = false
            PostFound_Button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            PostFound_Button.layer.shadowOpacity = 0.5
            PostFound_Button.layer.shadowRadius = 0
            PostFound_Button.layer.shadowOffset = CGSize(width: 0, height: 3)
            view.addSubview(PostFound_Button)
            
            //name
            name.text="Item's Name:"
            name.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: 18)
            name.textColor = color
            name.textAlignment = .left
            name.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(name)
            
            //nameInput
            nameInput.font = UIFont.systemFont(ofSize: 18)
    //        nameInput.borderStyle =
            nameInput.textColor = color
            nameInput.layer.borderColor = color.cgColor
            nameInput.layer.borderWidth = border_width
            nameInput.textAlignment = .left
            nameInput.layer.cornerRadius = 5;
            nameInput.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(nameInput)
            
            //descrip
            descrip.text = "Note:"
            descrip.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: 18)
            descrip.textColor = color
            descrip.textAlignment = .left
            descrip.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(descrip)
            
            //descripInput
            descripInput.font = UIFont.systemFont(ofSize: 18)
    //        nameInput.borderStyle =
            descripInput.textColor = color
            descripInput.layer.borderColor = color.cgColor
            descripInput.layer.borderWidth = border_width
            descripInput.textAlignment = .left
            descripInput.layer.cornerRadius = 5;
            descripInput.placeholder = " Optional";
            descripInput.tintColor = .gray;
            descripInput.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(descripInput)
            
            //location
            location.text="Lost Location:"
            location.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: 18)
            location.textColor = color
            location.textAlignment = .left
            location.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(location)
            
            //locInput
            locInput.font = UIFont.systemFont(ofSize: 18)
    //        nameInput.borderStyle =
            locInput.textColor = color
            locInput.layer.borderColor = color.cgColor
            locInput.layer.borderWidth = border_width
            locInput.textAlignment = .left
            locInput.layer.cornerRadius = 5;
            locInput.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(locInput)
            
            //time
            time.text="Lost Time:"
            time.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: 18)
            time.textColor = color
            time.textAlignment = .left
            time.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(time)
            
            //timeInput
            timeInput.font = UIFont.systemFont(ofSize: 18)
    //        nameInput.borderStyle =
            timeInput.textColor = color
            timeInput.layer.borderColor = color.cgColor
            timeInput.layer.borderWidth = border_width
            timeInput.textAlignment = .left
            timeInput.layer.cornerRadius = 5;
            timeInput.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(timeInput)
            
            //founder contact
            contact.text="Contact:"
            contact.font = UIFont(name: "RoundedMplus1c-ExtraBold", size: 18)
            contact.textColor = color
            contact.textAlignment = .left
            contact.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(contact)
            
            //contact_name_input
            contact_name_input.font = UIFont.systemFont(ofSize: 18)
            contact_name_input.placeholder = " Optional. Default: Your Cornell Email"
            contact_name_input.tintColor = .gray
            contact_name_input.textColor = color
            contact_name_input.layer.borderColor = color.cgColor
            contact_name_input.layer.borderWidth = border_width
            contact_name_input.textAlignment = .left
            contact_name_input.layer.cornerRadius=5
            contact_name_input.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(contact_name_input)
            
            
            let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backBarButtton
        
        }
        
        @objc func PostLTapped() {
            if(nameInput.text == ""){
                promptUserForName()
                return
            }
            if (locInput.text==""){
                promptUserForPhone()
                return
            }
            print("post lost tapped, now trying to post.")
            let name = nameInput.text ?? ""
            let description = descripInput.text ?? ""
            let time = timeInput.text ?? ""
            let location = locInput.text ?? ""
            var imageTrans:String? = nil;
            var finalContact = ""
            var username = ""
            let image:UIImage? = imageUserProfile.image
            print(contact_name_input.text)
            let contact:String? = contact_name_input.text
            if let userProf = try? decoder.decode(User1.self, from: userData.object(forKey: "UserProf") as! Data){
                print("postlsot, decode success")
                username = userProf.detail.email
            }else{
                print("postlost decode, if let fails")
            }
            if contact == ""{
                finalContact = "\(username)@cornell.edu"
            }else{
                finalContact = contact!
            }
            imageTrans=image?.jpegData(compressionQuality: 0.1)?.base64EncodedString() ?? ""
//            print(imageTrans)
            let createAlert = UIAlertController(title: "Post this item?", message: "Please make sure that the information is correct and sufficient.", preferredStyle: .alert)
            createAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            createAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alert in

                NetworkManager.postLost(name: name, time: time, description: description, location: location, contact: finalContact, image:imageTrans) { item in
                    print("postFoundComplete!")
                    let LVC = QuestionViewController();
                    
                    self.navigationController?.pushViewController(LVC, animated: true)
                    
                }
            }))
            present(createAlert,animated: true)

        }

        func setupConstraints() {
            
            //the parameter used in this section. Modify the scaler, the whole thing is adjusted.
            let leading: CGFloat = 24
            let width: CGFloat = view.frame.width-2*leading
            let s_padding: CGFloat = 2
            let l_padding: CGFloat = 10
            let theheight :CGFloat = view.frame.height * 0.033
            let theheight2 : CGFloat = view.frame.height * 0.043
            
    //        //name
            NSLayoutConstraint.activate([
                name.widthAnchor.constraint(equalToConstant: 132),
                name.heightAnchor.constraint(equalToConstant: theheight),
                name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
                name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            ])

            NSLayoutConstraint.activate([
                nameInput.widthAnchor.constraint(equalToConstant: width),
                nameInput.heightAnchor.constraint(equalToConstant: theheight2),
                nameInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: leading),
                nameInput.topAnchor.constraint(equalTo: name.bottomAnchor, constant: s_padding),
            ])
            
            //location locInput
            NSLayoutConstraint.activate([
                location.widthAnchor.constraint(equalToConstant: 250),
                location.heightAnchor.constraint(equalToConstant: theheight),
                location.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leading),
                location.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: l_padding),
            ])
            NSLayoutConstraint.activate([
                locInput.widthAnchor.constraint(equalToConstant: width),
                locInput.heightAnchor.constraint(equalToConstant: theheight2),
                locInput.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leading),
                locInput.topAnchor.constraint(equalTo: location.bottomAnchor, constant: s_padding),
            ])
            
            
            //time timeInput
            NSLayoutConstraint.activate([
                time.widthAnchor.constraint(equalToConstant: 200),
                time.heightAnchor.constraint(equalToConstant: theheight),
                time.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leading),
                time.topAnchor.constraint(equalTo: locInput.bottomAnchor, constant: l_padding),
            ])
            NSLayoutConstraint.activate([
                timeInput.widthAnchor.constraint(equalToConstant: width),
                timeInput.heightAnchor.constraint(equalToConstant: theheight2),
                timeInput.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leading),
                timeInput.topAnchor.constraint(equalTo: time.bottomAnchor, constant: s_padding),
            ])
            
            
            //descrip & descripInput
            NSLayoutConstraint.activate([
                descrip.widthAnchor.constraint(equalToConstant: 107),
                descrip.heightAnchor.constraint(equalToConstant: theheight),
                descrip.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leading),
                descrip.topAnchor.constraint(equalTo: timeInput.bottomAnchor, constant: l_padding),
            ])
            NSLayoutConstraint.activate([
                descripInput.widthAnchor.constraint(equalToConstant: width),
                descripInput.heightAnchor.constraint(equalToConstant: theheight2),
                descripInput.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leading),
                descripInput.topAnchor.constraint(equalTo: descrip.bottomAnchor, constant: s_padding),
            ])
            
            
            //contact contact_input
            NSLayoutConstraint.activate([
                contact.widthAnchor.constraint(equalToConstant: 250),
                contact.heightAnchor.constraint(equalToConstant: theheight),
                contact.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leading),
                contact.topAnchor.constraint(equalTo: descripInput.bottomAnchor, constant: l_padding),
            ])
            NSLayoutConstraint.activate([
                contact_name_input.widthAnchor.constraint(equalToConstant: width),
                contact_name_input.heightAnchor.constraint(equalToConstant: theheight2),
                contact_name_input.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leading),
                contact_name_input.topAnchor.constraint(equalTo: contact.bottomAnchor, constant: s_padding),
            ])
            
            NSLayoutConstraint.activate([
                imagelabel.topAnchor.constraint(equalTo: contact_name_input.bottomAnchor, constant: l_padding),
                imagelabel.widthAnchor.constraint(equalToConstant: 250),
                imagelabel.heightAnchor.constraint(equalToConstant: theheight),
                imagelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading)
            ])
            
            let theheight3 = view.frame.height * 0.209
            //lost_image
            NSLayoutConstraint.activate([
                lost_image.widthAnchor.constraint(equalToConstant: width),
                lost_image.heightAnchor.constraint(equalToConstant: theheight3),
                lost_image.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leading),
                lost_image.topAnchor.constraint(equalTo: imagelabel.bottomAnchor, constant: l_padding),
            ])

            //imageUserProfile
            if (isPost){
            NSLayoutConstraint.activate([
                imageUserProfile.widthAnchor.constraint(equalToConstant: theheight3),
                imageUserProfile.heightAnchor.constraint(equalToConstant: theheight3),
                imageUserProfile.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leading),
                imageUserProfile.topAnchor.constraint(equalTo: imagelabel.bottomAnchor, constant: s_padding),
            ])
            }

            //PostLost_Button
            NSLayoutConstraint.activate([
                PostFound_Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                PostFound_Button.widthAnchor.constraint(equalToConstant: 130),
                PostFound_Button.heightAnchor.constraint(equalToConstant: 40),
                PostFound_Button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
            ])
            
            
            

        }
    }
