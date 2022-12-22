//
//  PasswordResetController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 11/14/22.
//

import UIKit

class PasswordResetController: UIViewController{
    
    
    var resetLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Please enter registered email address to reset password."
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 18)
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
    
    var resetButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Reset", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = .black
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func resetTapped(){
        print(3444)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        
        navigationItem.titleView?.tintColor = .black
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "BradleyHandITCTT-Bold", size: 25)]
        navigationController?.navigationBar.backgroundColor = .systemYellow
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))
        
        let stackView = UIStackView(arrangedSubviews: [resetLabel,emailTxt])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
                                     stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                                     stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)])
        
        view.addSubview(resetButton)
        NSLayoutConstraint.activate([resetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 20)])
        
        let widthConstraint = resetButton.widthAnchor.constraint(equalToConstant: 120.0)
        let heightConstraint = resetButton.heightAnchor.constraint(equalToConstant: 40.0)
        
        NSLayoutConstraint.activate([widthConstraint,heightConstraint])

        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func backPressed(){
        let loginController = LogInViewController()
        let navController = UINavigationController(rootViewController: LogInViewController())
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true,completion: nil)
    }
}
