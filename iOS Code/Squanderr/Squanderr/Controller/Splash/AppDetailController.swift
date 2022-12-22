//
//  AppDetailController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 11/21/22.
//

import UIKit

class AppDetailController: UIViewController {
    
    var recycleImage: UIImageView = {
        let img  = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = #imageLiteral(resourceName: "splash1.jpeg")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    var messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Squander is here \n to help \n anytime \n anywhere.. "
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 25, weight: .medium)
        lbl.textColor = .black
        return lbl
    }()
    
    var proceedButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Proceed", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = .systemYellow
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(proceedtapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func proceedtapped(){
       let loginController = LogInViewController()
       let navController = UINavigationController(rootViewController: LogInViewController())
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
        view.addSubview(recycleImage)
        NSLayoutConstraint.activate([recycleImage.topAnchor.constraint(equalTo: view.topAnchor),
                                     recycleImage.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     recycleImage.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     recycleImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        view.addSubview(messageLabel)
        NSLayoutConstraint.activate([messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 80),
                                     messageLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20)])
        
        view.addSubview(proceedButton)
        let widthConstraint = proceedButton.widthAnchor.constraint(equalToConstant: 120);
        let heightConstraint = proceedButton.heightAnchor.constraint(equalToConstant: 40);
        
        
        NSLayoutConstraint.activate([proceedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),widthConstraint,heightConstraint])
        
        proceedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //proceedButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
