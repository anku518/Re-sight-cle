//
//  LogInViewController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 11/10/22.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    var emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Email"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var emailTxt: UITextField = {
        let txt = UITextField()
        txt.borderStyle = .roundedRect
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 18)
        txt.textAlignment = .left
        txt.backgroundColor = UIColor.white
        txt.textColor = UIColor.black
        return txt
    }()
    
    var passwordLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Password"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var passwordTxt: UITextField = {
        let txt = UITextField()
        txt.borderStyle = .roundedRect
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 18)
        txt.textContentType = .password
        txt.textAlignment = .left
        txt.backgroundColor = UIColor.white
        txt.textColor = UIColor.black
        txt.isSecureTextEntry = true
        return txt
    }()
    
    var forgotPasswordLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Forgot Password?"
        lbl.textColor = .red
        lbl.font = .systemFont(ofSize: 16)
        lbl.highlightedTextColor = .white
        return lbl
    }()
    
    var logInButton: UIButton = {
        let btn = UIButton()
//        btn.frame.size = CGSize(width: 200, height: 50)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = .black
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(logInUptapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func logInUptapped(){
        guard let email =  emailTxt.text else {return}
        
        guard let password = passwordTxt.text else {return}
        print(email)
        print(password)
        
        //Sign In User
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let err =  error {
                print(err.localizedDescription)
                let alert = UIAlertController(title: "Sign In", message: "User ID or Password Incorrect", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(alertAction)
                self.present(alert, animated: true)
                
            }
            
            print("SignIn Successful")
            guard let uid  = result?.user.uid else {return}
            print(uid)
//            let alert = UIAlertController(title: "Sign In", message: "Sucessfull", preferredStyle: .alert)
//            alert.view.backgroundColor = .systemYellow
//            let alertAction = UIAlertAction(title: "Ok", style: .cancel)
//            alert.addAction(alertAction)
//            self.present(alert, animated: true)
            
            
            let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
            
            
            let mySceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
            mySceneDelegate?.setRootViewController()
            

        }
        
        
    }
    
    var logInSignUpLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Not Registered? SignUp"
        lbl.textColor = .darkGray
        lbl.font = .systemFont(ofSize: 18)
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        
        let vStackView = UIStackView(arrangedSubviews: [emailLabel,emailTxt,passwordLabel,passwordTxt,forgotPasswordLabel])
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        vStackView.spacing = 5
        
        view.addSubview(vStackView)
        NSLayoutConstraint.activate([vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                                     vStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                                     vStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)])
        view.addSubview(logInButton)
        NSLayoutConstraint.activate([logInButton.topAnchor.constraint(equalTo: vStackView.bottomAnchor,constant: 20)])
        
        let widthConstraint = logInButton.widthAnchor.constraint(equalToConstant: 120.0)
        let heightConstraint = logInButton.heightAnchor.constraint(equalToConstant: 40.0)
        
        NSLayoutConstraint.activate([widthConstraint,heightConstraint])

        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(logInSignUpLabel)
        logInSignUpLabel.anchor(top: logInButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 50, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        logInSignUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        forgotPasswordLabel.isUserInteractionEnabled = true
        let passTapGesture = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
        passTapGesture.numberOfTapsRequired = 1
        forgotPasswordLabel.addGestureRecognizer(passTapGesture)
        
        
        logInSignUpLabel.isUserInteractionEnabled = true
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        tapGestureRecog.numberOfTapsRequired = 1
        logInSignUpLabel.addGestureRecognizer(tapGestureRecog)
    }
    
    @objc func forgotPasswordTapped(){
        let resetController = PasswordResetController()
        let navController = UINavigationController(rootViewController: resetController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true,completion: nil)
    }
    
    @objc func labelTapped(){
        logInSignUpLabel.textColor =  .white
        let controller =  SignUpViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true  ,completion: nil)
    }
    
    
}
