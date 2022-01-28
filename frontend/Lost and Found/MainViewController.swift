
//
//  ViewController.swift
//  Lost and Found
//
//  Created by Haoxuan Zou on 11/19/21.
//
import UIKit
import SystemConfiguration

class MainViewController: UIViewController{
    
    private var netIdText = UITextField();
    private var passwordText = UITextField();
    private var loginButton = UIButton();
    private var registerButton = UIButton();
    private var token = ""
    private var id = 0
    private var email = ""
    private var ProfileImage = UIImageView()
    // private var registerLine = UITextField()
    

    
    
    override func viewDidLoad() {
        print("shit.now we go again.")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        assignbackground();
        
        let textColor = UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1)
        let buttonColor = UIColor(red: 0.859, green: 0.875, blue: 0.922, alpha: 1)
        
        
        // view.backgroundColor = UIColor(red: 0.722, green: 0.803, blue: 0.858, alpha: 1)
        let theWidth = view.frame.width * 0.685;
        let theHeight = view.frame.height * 0.06;
        
        ProfileImage.image = UIImage(named: "profile")
        ProfileImage.translatesAutoresizingMaskIntoConstraints = false
        ProfileImage.contentMode = .scaleAspectFill
        ProfileImage.clipsToBounds = true
        let parent = self.view!
        parent.addSubview(ProfileImage)
        ProfileImage.widthAnchor.constraint(equalToConstant: view.frame.width / 12).isActive = true
        ProfileImage.heightAnchor.constraint(equalToConstant: view.frame.height / 23).isActive = true
        ProfileImage.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor, constant: 110).isActive = true
        ProfileImage.centerXAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerXAnchor).isActive = true;
        
        
        //netIdText.backgroundColor = UIColor(red: 0.859, green: 0.875, blue: 0.922, alpha: 1)
        netIdText.layer.backgroundColor = buttonColor.cgColor
//        let parent = self.view!
        netIdText.textColor = textColor
        netIdText.layer.cornerRadius = 10;
        parent.addSubview(netIdText)
        netIdText.translatesAutoresizingMaskIntoConstraints = false
        netIdText.widthAnchor.constraint(equalToConstant: theWidth).isActive = true
        netIdText.heightAnchor.constraint(equalToConstant: theHeight).isActive = true
        netIdText.topAnchor.constraint(equalTo: ProfileImage.bottomAnchor, constant: 30).isActive = true
        netIdText.centerXAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerXAnchor).isActive = true;
        netIdText.placeholder = "  NetId"
        //the font is set in the rear part.
        netIdText.autocapitalizationType = .none
        
        
        passwordText.backgroundColor = .white
        passwordText.layer.backgroundColor = buttonColor.cgColor
        passwordText.placeholder = "  Password";
        passwordText.textColor = textColor
        parent.addSubview(passwordText)
        passwordText.isSecureTextEntry=true
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.widthAnchor.constraint(equalToConstant: theWidth).isActive = true
        passwordText.heightAnchor.constraint(equalToConstant: theHeight).isActive = true
        passwordText.topAnchor.constraint(equalTo: netIdText.bottomAnchor, constant: 20).isActive = true
        passwordText.layer.cornerRadius = 10;
        passwordText.centerXAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        
        loginButton.backgroundColor = buttonColor
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor(red: 0.063, green: 0.193, blue: 0.283, alpha: 1), for: .normal)
        loginButton.layer.cornerRadius = 15;
        loginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        loginButton.layer.shadowOpacity = 0.5
        loginButton.layer.shadowRadius = 0
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        loginButton.layer.masksToBounds = false

        parent.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false;
        loginButton.centerXAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerXAnchor).isActive = true;
        loginButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 30).isActive = true;
        loginButton.widthAnchor.constraint(equalToConstant: CGFloat(75)).isActive = true;
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
//        registerLine.
//
        registerButton.backgroundColor = .clear
        //registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        let yourAttributes: [NSAttributedString.Key: Any] = [
             .font: UIFont.systemFont(ofSize: 10),
             .foregroundColor:  UIColor(red: 0.505, green: 0.524, blue: 0.637, alpha: 1),
             .underlineStyle: NSUnderlineStyle.single.rawValue
         ]
        let attributeString = NSMutableAttributedString(
                string: "Do not have an account? Click to create first!",
                attributes: yourAttributes
             )
        registerButton.setAttributedTitle(attributeString, for: .normal)
        
        registerButton.layer.cornerRadius = 23;
        parent.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false;
        registerButton.centerXAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerXAnchor).isActive = true;
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true;
        registerButton.widthAnchor.constraint(equalToConstant: view.frame.width*0.7).isActive = true;
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
        
        let theFont = theHeight * 0.367;
        netIdText.font = UIFont(name: "RoundedMplus1c-Medium", size: theFont)
        loginButton.titleLabel?.font = UIFont(name:"RoundedMplus1c-Medium", size: theFont);
        passwordText.font = UIFont(name: "RoundedMplus1c-Medium", size: theFont)
        registerButton.titleLabel?.font = UIFont(name: "RoundedMplus1c-Medium", size: theFont)
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.505, green: 0.524, blue: 0.637, alpha: 1)
        /*** If needed Assign Title Here ***/
        self.navigationController?.navigationBar.backgroundColor = self.view.backgroundColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
 
        
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
    
    @objc func loginTapped(){
        //you lack an if let method!
        if let netId = netIdText.text, let password = passwordText.text{
            print("login iflet good.")
            print(netId);print(password)

            NetworkManager.login(email: netId, password: password, completion: { user in
                print("success!!??!!")
                self.updateToken(token: user.session_token);
//                print(user.session_token)
//                print(user.detail.id)
                self.navigationController?.popViewController(animated: true)
                
            },errorHandler: { boolresult in
                if boolresult=="false"{
                    let createAlert = UIAlertController(title: "Login Failed!", message: "Please make sure the password is correct, or the username is registered.", preferredStyle: .alert)
                    createAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(createAlert,animated: true)
                }
                
            }
            )
            
        }else{
            let createAlert = UIAlertController(title: "Login Failed!", message: "Please make sure the password is correct or the username is registered.", preferredStyle: .alert)
            createAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(createAlert,animated: true)
        }

    }
    
    @objc func registerTapped(){
        let rvc = RegisterController(delegate: self);
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    



}

extension MainViewController:UserDelegate{

    func updateToken(token: String) {
        self.token=token
    }
    func getToken() -> String{
        return self.token;
    }
}
