//
//  AuthButton.swift
//  ZonicApp
//
//  Created by MagdielG on 4/17/20.
//  Copyright © 2020 Magdiel Gómez. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth



final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    

    //MARK: - Variables
    
   
    
   
    
    
    //MARK: - Propiedades
//    private let googleIcon: UIImageView = {
//        let googleImage = UIImageView()
//        googleImage.image = nil
//        return googleImage
//    }()
    
    

//     private let progress: UIActivityIndicatorView = {
//        let progressCircle = UIActivityIndicatorView()
//        return progressCircle
//    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ZonicApp"
        label.font = UIFont(name: "Avenir-Light", size: 40)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
      }()
    
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
       }()
       private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
         }()
    
    private let loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        //        button.addTarget(self, action: #selector(showProgerssActivity), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAcountButton : UIButton = {
        let button = UIButton(type: .system)
        let attributeTitle = NSMutableAttributedString(string: "Don't have Acount?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributeTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributeTitle, for: .normal)
        return button
    }()
    
    
   
  
    
    
    
    //MARK: - super.viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
//        googleImageView()
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //MARK: - Selectors
    @objc func handleLogin(){
        
        
        
        let alerta = UIAlertController(title: "Error", message: "This User or Password is invalid", preferredStyle: .alert)
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        
        
       Auth.auth().signIn(withEmail:email, password: password) {(result, error) in
        if error != nil{
            alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil)); self.present(alerta, animated: true)
//            print("Error al encotrar usuario \(error.localizedDescription)")
            return
        }
//        self.showProgerssActivity()
        self.navigationController?.pushViewController(HomeController(), animated: true)
        guard let viewHomeController = UIApplication.shared.keyWindow?.rootViewController as? HomeController else { return }
        viewHomeController.configureUI()
        self.dismiss(animated: true, completion: nil)
        }
     }
    
    @objc func handleShowSignUp(){
       let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
        }
    
    //MARK: - Helpers Function
    
    func configureUI() {
        configureNavigationBar()
        view.backgroundColor = .backgroundColor
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        titleLabel.centerX(inView: view)

        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 26

        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)

        
        view.addSubview(dontHaveAcountButton)
        dontHaveAcountButton.centerX(inView: view)
        dontHaveAcountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
        
        
        
    }
    
    
    func configureNavigationBar(){
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
// @objc func showProgerssActivity(){
//        view.addSubview(progress)
//        progress.anchor(top: loginButton.topAnchor, right: view.rightAnchor, paddingTop: 15, paddingRight: 40)
//        progress.startAnimating()
//        progress.color = .white
//
//    }
    
//    func googleImageView(){
//        view.addSubview(googleIcon)
//        googleIcon.image = .some(#imageLiteral(resourceName: "googleLogo"))
//        googleIcon.anchor(top: loginButton.topAnchor, right: view.rightAnchor, paddingTop: 15, paddingRight: 80, width: 25, height: 25)
//
//    }
    
    
    
    
    
}

