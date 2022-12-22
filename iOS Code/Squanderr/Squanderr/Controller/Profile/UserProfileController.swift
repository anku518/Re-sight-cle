//
//  UserProfileController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 11/11/22.
//

import UIKit
import Firebase


struct User {
    var uid: String
    let email: String?
    let userName: String?
    let workType: String?
    let password: String?
    
    
    
    init(uid:String,dictionary: [String:Any]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.workType = dictionary["workType"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
    }
}


class UserProfileController: UIViewController {
    
    var profileView: UIView = {
       let vw = UIView()
       vw.translatesAutoresizingMaskIntoConstraints = false
       vw.backgroundColor = .white
        vw.layer.cornerRadius = 20
       return vw
    }()
    
    //UserName
    var userNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "UserName:"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var userDetailLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Rajat Nagavkar"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    
    //Email
    
    var emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Email:"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var emailDetailLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "nagavkarrajat2852@gmail.com"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    //Worktype
    var workNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Work:"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var workDetailLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Mechanic"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    //Address
    
    var addressNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Address:"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var addressDetailLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "NA"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    //Contact
    var contactLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Contact:"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var contactDetailLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "NA"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var recycleButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Logout", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = .systemYellow
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        return btn
    }()
    
    
    @objc func logoutPressed(){
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive,handler: { (_) in
            do {
                try Auth.auth().signOut()
                
                let loginController = LogInViewController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true,completion: nil)
            }
            catch let signOutError {
                print(signOutError.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true,completion: nil)
    }
    
    let db = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        navigationItem.title = "Profile"
        navigationItem.titleView?.tintColor = .black
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "BradleyHandITCTT-Bold", size: 25)]
        navigationController?.navigationBar.backgroundColor = .systemYellow
        
        
        
        view.addSubview(profileView)
        let heightAnchor = profileView.heightAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
                                     profileView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                                     profileView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),heightAnchor])
        
        profileView.addSubview(userNameLabel)
        NSLayoutConstraint.activate([userNameLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 20),
                                                                        userNameLabel.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 10)])
        profileView.addSubview(userDetailLabel)
        NSLayoutConstraint.activate([userDetailLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 20),
                                     userDetailLabel.leftAnchor.constraint(equalTo: userNameLabel.rightAnchor, constant: 20)])
                                     
        
        profileView.addSubview(emailLabel)
        NSLayoutConstraint.activate([emailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
                                                                        emailLabel.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 10)])
        profileView.addSubview(emailDetailLabel)
        NSLayoutConstraint.activate([emailDetailLabel.topAnchor.constraint(equalTo: userDetailLabel.bottomAnchor, constant: 10),
                                     emailDetailLabel.leftAnchor.constraint(equalTo: emailLabel.rightAnchor, constant: 60)])
        
        profileView.addSubview(workNameLabel)
        NSLayoutConstraint.activate([workNameLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
                                     workNameLabel.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 10  )])
        
        profileView.addSubview(workDetailLabel)
        NSLayoutConstraint.activate([workDetailLabel.topAnchor.constraint(equalTo: emailDetailLabel.bottomAnchor, constant: 10),
                                     workDetailLabel.leftAnchor.constraint(equalTo: workNameLabel.rightAnchor, constant: 60)])
        
        profileView.addSubview(addressNameLabel)
        NSLayoutConstraint.activate([addressNameLabel.topAnchor.constraint(equalTo: workNameLabel.bottomAnchor, constant: 10),
                                     addressNameLabel.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 10)])
        
        
        profileView.addSubview(addressDetailLabel)
        NSLayoutConstraint.activate([addressDetailLabel.topAnchor.constraint(equalTo: workNameLabel.bottomAnchor, constant: 10),
                                     addressDetailLabel.leftAnchor.constraint(equalTo: addressNameLabel.rightAnchor, constant: 40)]
        )
        
        
        profileView.addSubview(contactLabel)
        NSLayoutConstraint.activate([contactLabel.topAnchor.constraint(equalTo: addressNameLabel.bottomAnchor, constant: 10),
                                     contactLabel.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 10)])
        
        profileView.addSubview(contactDetailLabel)
        NSLayoutConstraint.activate([contactDetailLabel.topAnchor.constraint(equalTo: addressDetailLabel.bottomAnchor, constant: 10),
                                     contactDetailLabel.leftAnchor.constraint(equalTo: contactLabel.rightAnchor, constant: 40)])
        
        profileView.addSubview(recycleButton)
        NSLayoutConstraint.activate([recycleButton.topAnchor.constraint(equalTo: contactDetailLabel.bottomAnchor, constant: 40)])
        
        let widthConstraint = recycleButton.widthAnchor.constraint(equalToConstant: 120)
        let heightConstrint = recycleButton.heightAnchor.constraint(equalToConstant: 40)
        
        NSLayoutConstraint.activate([widthConstraint,heightAnchor])
        recycleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        fetchUserProfile();
    }
    
    
    func fetchUserProfile(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        db.child("Users").child(uid).observeSingleEvent(of: .value) { dataSnapshot in
            print(dataSnapshot.value)
          
        guard let dictionary = dataSnapshot.value as? [String: Any] else {return}
            
        let user = User(uid: uid, dictionary: dictionary)
            self.userDetailLabel.text = user.userName
            self.workDetailLabel.text = user.workType
            self.emailDetailLabel.text = user.email
        }
            
    }
}
