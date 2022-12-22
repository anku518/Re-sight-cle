//
//  SignUpViewController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 11/10/22.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workType.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return workType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedWork = workType[row]
        workTypeTxt.text = selectedWork
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    
    var pickerView: UIPickerView = {
        let pKView = UIPickerView()
        return pKView
    }()
    
    @objc func donePressed(){
        view.endEditing(true)
    }
    
    
    var selectedWork: String?
    var workType = ["Homeowner","Mechanical","Electronics","Construction"]
    
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
    
    
    var userNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "UserName"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var userNameTxt: UITextField = {
        let txt = UITextField()
        txt.borderStyle = .roundedRect
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 18)
        txt.textAlignment = .left
        txt.backgroundColor = UIColor.white
        txt.textColor = UIColor.black
        return txt
    }()
    
    var workTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Work Type"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var workTypeTxt: UITextField = {
        let txt = UITextField()
        txt.borderStyle = .roundedRect
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 18)
        txt.textContentType = .password
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
    
    var signUpButton: UIButton = {
        let btn = UIButton()
//        btn.frame.size = CGSize(width: 200, height: 50)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = .black
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(signUptapped), for: .touchUpInside)
        return btn
    }()
    
    
    @objc func signUptapped(){
        print(3332)
        guard let email =  emailTxt.text else {return}
        guard let username = userNameTxt.text else {return}
        guard let workType = workTypeTxt.text else {return}
        guard let password = passwordTxt.text else {return}
        print(email)
        print(username)
        print(workType)
        print(password)
        
        //Create User
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let err = error {
                print(err.localizedDescription)
            }
            
            print("User Created Successfully")
            
            //Create database
            guard let uid = result?.user.uid else {return}
            print(uid)
            
            let dictionaryValues = ["email": email,"userName":username,"workType":workType,"password": password]
            
            let values = [uid: dictionaryValues]
            
            //Get database refrence
            Database.database().reference().child("Users").updateChildValues(values) { error, dataRef in
                if let err =  error {
                    print(err.localizedDescription)
                }

                print("User added to Database")
                
                let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
                
                
                let mySceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
                mySceneDelegate?.setRootViewController()
                


            }
            
        }
        
    }
    
    var logInSignUpLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Registered? SignIn"
        lbl.textColor = .red
        lbl.font = .systemFont(ofSize: 18)
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        
        let vStackView = UIStackView(arrangedSubviews: [emailLabel,emailTxt,userNameLabel,userNameTxt,workTypeLabel,workTypeTxt,passwordLabel,passwordTxt])
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        vStackView.spacing = 5
        
        pickerView.delegate = self
        workTypeTxt.inputView = pickerView
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        workTypeTxt.inputAccessoryView =  toolbar
        
        
        
        view.addSubview(vStackView)
        NSLayoutConstraint.activate([vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                                     vStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                                     vStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)])
        
        view.addSubview(signUpButton)
        NSLayoutConstraint.activate([signUpButton.topAnchor.constraint(equalTo: vStackView.bottomAnchor,constant: 20)])
        
        let widthConstraint = signUpButton.widthAnchor.constraint(equalToConstant: 120.0)
        let heightConstraint = signUpButton.heightAnchor.constraint(equalToConstant: 40.0)
        
        NSLayoutConstraint.activate([widthConstraint,heightConstraint])

       signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(logInSignUpLabel)
        logInSignUpLabel.anchor(top: signUpButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 50, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        logInSignUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        logInSignUpLabel.isUserInteractionEnabled = true
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        tapGestureRecog.numberOfTapsRequired = 1
        logInSignUpLabel.addGestureRecognizer(tapGestureRecog)
       
        
    }
    
    @objc func labelTapped(){
        logInSignUpLabel.textColor =  .white
        let controller =  LogInViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true  ,completion: nil)
    }
    
    
}
