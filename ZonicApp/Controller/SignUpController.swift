//
//  AuthButton.swift
//  ZonicApp
//
//  Created by MagdielG on 4/17/20.
//  Copyright © 2020 Magdiel Gómez. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase


final class SignUpController: UIViewController, UITextFieldDelegate {
    
     //MARK: - Propiedades
    
   
    
    
    
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
    
    
        private lazy var nameContainerView: UIView = {
            let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: nameTextField)
            view.heightAnchor.constraint(equalToConstant: 50).isActive = true
            return view
        }()
        private let nameTextField: UITextField = {
            return UITextField().textField(withPlaceholder: "Fullname", isSecureTextEntry: false)
          }()

       
       
       private lazy var passwordContainerView: UIView = {
           let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
           view.heightAnchor.constraint(equalToConstant: 50).isActive = true
           return view
          }()
          private let passwordTextField: UITextField = {
           return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
            }()
    
    private lazy var accountTypeContainerView: UIView = {
     let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_account_box_white_2x"), segmentedControl: accountTypeSegmentedControl)
     view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
     return view
    }()
    
    private let accountTypeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Rider","Driver"])
        sc.backgroundColor = .darkGray
        sc.tintColor = UIColor(white: 1, alpha: 0)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private let signUpButton: AuthButton = {
           let button = AuthButton(type: .system)
           button.setTitle("Sign Up", for: .normal)
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
           button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
           return button
       }()
    
    let alreadyHaveAcountButton : UIButton = {
        let button = UIButton(type: .system)
        let attributeTitle = NSMutableAttributedString(string: "Already have Acount?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributeTitle.append(NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        button.setAttributedTitle(attributeTitle, for: .normal)
        
        
        return button
    }()
    
    
    //MARK: - Lifecicle
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        navigationController?.view.semanticContentAttribute = .forceLeftToRight
    }
    
    //MARK: - Selectors
    @objc func handleSignUp(){
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//
        guard let email = emailTextField.text else {return}
        guard passwordTextField.text != nil else {return}
        guard let fullname = nameTextField.text else {return}
        let accountTypeIndex = accountTypeSegmentedControl.selectedSegmentIndex

        
        
        
        Auth.auth().createUser(withEmail:emailTextField.text!, password: passwordTextField.text!, completion: {(result, error) in
            if let error = error{
                print("Error al registrar usuario\(error)")
                return
            }

            guard (result?.user.uid) != nil else {return}
            let values = ["email": email, "fullname": fullname, "accountType": accountTypeIndex ] as [String : Any]

            let db = Firestore.firestore()
            db.collection("users").addDocument(data: values){(error) in
            self.navigationController?.pushViewController(HomeController(), animated: true)
            guard let viewHomeController = UIApplication.shared.keyWindow?.rootViewController as? HomeController else { return }
            viewHomeController.configureUI()
            self.dismiss(animated: true, completion: nil)

            }
        })
        
    }
    
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }

    
    //MARK: - Helpers Function
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLabel.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   nameContainerView,
                                                   passwordContainerView,
                                                   accountTypeContainerView,
                                                   signUpButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 26
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(alreadyHaveAcountButton)
        alreadyHaveAcountButton.centerX(inView: view)
        alreadyHaveAcountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
            }
    
   
    
    
    
    
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }



}
