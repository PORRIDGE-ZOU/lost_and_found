//
//  RegisterController.swift
//  Lost and Found
//
//  Created by Haoxuan Zou on 11/30/21.
//
import Foundation
import UIKit

protocol UserDelegate:class{
    func updateToken(token:String);
    func getToken()->String;
}//this protocol seems redundant.
class RegisterController: UIViewController{
    
    
    private var netIdText = UITextField();
    private var passwordText = UITextField();
    private var registerButton = UIButton();
    private var token = ""
    private var id = 0
    private var email = ""
    private var delegate:UserDelegate
    
    private var ProfileImage = UIImageView();
    
    init(delegate:UserDelegate){
        self.delegate=delegate
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func assignbackground(){
            let background = UIImage(named: "login")
            var imageView : UIImageView!
            imageView = UIImageView(frame: view.bounds)
            imageView.contentMode =  UIView.ContentMode.scaleAspectFill
            imageView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            imageView.clipsToBounds = true
            imageView.image = background
            imageView.center = view.center
            view.addSubview(imageView)
            self.view.sendSubviewToBack(imageView)
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // view.backgroundColor = UIColor(red: 0.325, green: 0.38, blue: 0.424, alpha: 1)
        assignbackground();
        
//        var shadows = UIView()
//        shadows.frame = view.frame
//        shadows.clipsToBounds = false
//        view.addSubview(shadows)
//
//        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
//        let layer0 = CALayer()
//        layer0.shadowPath = shadowPath0.cgPath
//        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
//        layer0.shadowOpacity = 0.5
//        layer0.shadowRadius = 4
//        layer0.shadowOffset = CGSize(width: 0, height: 4)
//        layer0.bounds = shadows.bounds
//        layer0.position = shadows.center
//        shadows.layer.addSublayer(layer0)
//
//
        
        let theWidth = view.frame.width * 0.685;
        let theHeight = view.frame.height * 0.06;
        
        
        let textColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1)
        let buttonColor = UIColor(red: 0.859, green: 0.875, blue: 0.922, alpha: 1)
        
        ProfileImage.image = UIImage(named: "profile")
        
        ProfileImage.translatesAutoresizingMaskIntoConstraints = false
        ProfileImage.contentMode = .scaleAspectFill
        ProfileImage.clipsToBounds = true
        let parent = self.view!
        parent.addSubview(ProfileImage)
        ProfileImage.widthAnchor.constraint(equalToConstant: view.frame.width / 10).isActive = true
        ProfileImage.heightAnchor.constraint(equalToConstant: view.frame.height / 21).isActive = true
        ProfileImage.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        ProfileImage.centerXAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerXAnchor).isActive = true;
        
        
        // netIdText.backgroundColor = .white
        // netIdText.font = UIFont(name:"RoundedMplus1c-Black",size: 22)
        netIdText.font = .systemFont(ofSize: 15)
        netIdText.layer.backgroundColor = buttonColor.cgColor
        netIdText.textColor = textColor

        parent.addSubview(netIdText)
        netIdText.translatesAutoresizingMaskIntoConstraints = false
        netIdText.widthAnchor.constraint(equalToConstant: theWidth).isActive = true
        netIdText.heightAnchor.constraint(equalToConstant: theHeight).isActive = true
        netIdText.topAnchor.constraint(equalTo: ProfileImage.bottomAnchor, constant: 30).isActive = true
        netIdText.centerXAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerXAnchor).isActive = true;
        netIdText.layer.cornerRadius = 10;
        netIdText.placeholder = "  CUNetId"
        //the font is set in the rear part.
        netIdText.autocapitalizationType = .none
        

        // passwordText.backgroundColor = .white
        // passwordText.font = UIFont(name:"RoundedMplus1c-Black",size: 22)
        passwordText.font = .systemFont(ofSize: 15)
        passwordText.layer.backgroundColor = buttonColor.cgColor
        passwordText.placeholder = "  Password";
        passwordText.textColor = textColor

        parent.addSubview(passwordText)
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.widthAnchor.constraint(equalToConstant: theWidth).isActive = true
        passwordText.heightAnchor.constraint(equalToConstant: theHeight).isActive = true
        passwordText.topAnchor.constraint(equalTo: netIdText.bottomAnchor, constant: 20).isActive = true
        passwordText.layer.cornerRadius = 10;
        passwordText.centerXAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerXAnchor).isActive = true
        passwordText.autocapitalizationType = .none
        
        
        registerButton.backgroundColor = buttonColor
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(textColor, for: .normal)
        registerButton.layer.cornerRadius = 15;
        registerButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        registerButton.layer.shadowOpacity = 0.5
        registerButton.layer.shadowRadius = 0
        registerButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        registerButton.layer.masksToBounds = false
        
        parent.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false;
        registerButton.centerXAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerXAnchor).isActive = true;
        registerButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 30).isActive = true;
        registerButton.widthAnchor.constraint(equalToConstant: CGFloat(120)).isActive = true;
        registerButton.heightAnchor.constraint(equalToConstant: CGFloat(40)).isActive = true;
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
        
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.505, green: 0.524, blue: 0.637, alpha: 1)
        /*** If needed Assign Title Here ***/
        self.navigationController?.navigationBar.backgroundColor = self.view.backgroundColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    @objc func registerTapped(){
        if let netId = netIdText.text, let password = passwordText.text{
            print("register iflet good.")
            print(netId);print(password)
            NetworkManager.register(email: netId, password: password, completion: { user in
                print("success,network,register")
                self.delegate.updateToken(token: user.session_token);
//                self.delegate.updateId(id: user.detail.id);
//                self.delegate.updateEmail(email: user.detail.email)
//                print(user.session_token)
                self.updateToken(token: user.session_token)
//                print(self.token)
//                print(user.detail.id)
                self.navigationController?.popViewController(animated: true)
            }, errorHandler: { boolresult in
                
                if boolresult=="false"{
                    print("now the bool is false")
                    let createAlert = UIAlertController(title: "Register Failed.", message: "The user name is already registered.", preferredStyle: .alert)
                    createAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(createAlert,animated: true)
                    //create an alert.
                }
            })
        }
    }
    

        
}


extension RegisterController:UserDelegate{
    func getId() -> Int {
        return self.id
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func updateToken(token: String) {
        self.token=token
    }
    
    func updateId(id: Int) {
        self.id=id
    }
    
    func updateEmail(email: String) {
        self.email=email
    }
    func getToken() -> String{
        return self.token;
    }
    
}
