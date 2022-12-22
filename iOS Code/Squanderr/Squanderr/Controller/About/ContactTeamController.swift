//
//  ContactTeamController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 12/15/22.
//

import UIKit

class ContactTeamController: UIViewController{
    
    var contactView: UIView = {
        let vw = UIView()
        vw.backgroundColor = .white
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 20
        return vw
    }()
    
    var companyImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = #imageLiteral(resourceName: "earth1")
        img.layer.borderColor = UIColor.white.cgColor
        //img.layer.borderWidth = 3
        return img
    }()
    
    var companyLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Squander"
        lbl.font = .boldSystemFont(ofSize: 22)
        lbl.textColor = .black
        return lbl
    }()
    
    var contactLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        lbl.text = "Contact:"
        lbl.textColor = .black
        return lbl
    }()
    
    
    var emailLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16)
        lbl.text = "squander@gmail.com"
        lbl.numberOfLines = 0
        lbl.textColor = .black
        return lbl
    }()
    
    var mobileLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16)
        lbl.text = "+1-201-XXX-XXXX"
        lbl.textColor = .black
        return lbl
    }()
    
    var feedBackView: UIView = {
        let vw = UIView()
        vw.backgroundColor = .white
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 20
        return vw
    }()
    
    var feedBackLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Feedback"
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textColor = .black
        return lbl
    }()
    
    var feedbackDescription: UITextView = {
        let txt = UITextView()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.textColor = .black
        txt.layer.cornerRadius = 20
        txt.backgroundColor = .lightGray
        txt.beginFloatingCursor(at: CGPoint(x: 0, y: -10))
        txt.font = UIFont(name: "Helvetica-Bold", size: 18)
        return txt
    }()
    
    var sendButton: UIButton = {
        let btn = UIButton()
//        btn.frame.size = CGSize(width: 200, height: 50)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Request", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = .systemYellow
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func sendTapped(){
        print(123)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Contact team"
        navigationItem.titleView?.tintColor = .black
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "BradleyHandITCTT-Bold", size: 25)]
        navigationController?.navigationBar.backgroundColor = .systemYellow
        
        
        let widthCon = contactView.widthAnchor.constraint(equalToConstant: view.frame.width)
        let heightCon = contactView.heightAnchor.constraint(equalToConstant: 200)
        
        view.addSubview(contactView)
        NSLayoutConstraint.activate([contactView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
                                     contactView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 5),
                                     contactView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -5),widthCon,heightCon])
        
        contactView.addSubview(companyImage)
        companyImage.anchor(top: contactView.topAnchor, left: contactView.leftAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 150, height: 150)
        
        companyImage.clipsToBounds = true
        companyImage.layer.cornerRadius = 50
        
        contactView.addSubview(companyLbl)
        NSLayoutConstraint.activate([companyLbl.topAnchor.constraint(equalTo: contactView.topAnchor, constant: 30),
                                     companyLbl.leftAnchor.constraint(equalTo: companyImage.rightAnchor,constant: 40)])
        
        contactView.addSubview(contactLbl)
        NSLayoutConstraint.activate([contactLbl.topAnchor.constraint(equalTo: companyLbl.bottomAnchor, constant: 30),
                                     contactLbl.leftAnchor.constraint(equalTo: companyImage.rightAnchor, constant: 20)])
        
        contactView.addSubview(emailLbl)
        NSLayoutConstraint.activate([emailLbl.topAnchor.constraint(equalTo: contactLbl.bottomAnchor, constant: 10),
                                     emailLbl.leftAnchor.constraint(equalTo: companyImage.rightAnchor, constant: 20)])
        
        
        contactView.addSubview(mobileLbl)
        NSLayoutConstraint.activate([mobileLbl.topAnchor.constraint(equalTo: emailLbl.bottomAnchor, constant: 10),
                                     mobileLbl.leftAnchor.constraint(equalTo: companyImage.rightAnchor, constant: 20)])
        
        
        let widthConstrant = feedBackView.widthAnchor.constraint(equalToConstant: view.frame.width)
        let heightConstrant = feedBackView.heightAnchor.constraint(equalToConstant: 300)
        
        view.addSubview(feedBackView)
        NSLayoutConstraint.activate([feedBackView.topAnchor.constraint(equalTo: contactView.bottomAnchor,constant: 50),
                                     feedBackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 5),
                                     feedBackView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -5),widthConstrant,heightConstrant])
        
        feedBackView.addSubview(feedBackLbl)
        NSLayoutConstraint.activate([feedBackLbl.topAnchor.constraint(equalTo: feedBackView.topAnchor, constant: 20),feedBackLbl.leftAnchor.constraint(equalTo: feedBackView.leftAnchor, constant: 10)])
        
        let desWidthConstraint = feedbackDescription.widthAnchor.constraint(equalToConstant: feedBackView.frame.width)
       let desheightConstraint = feedbackDescription.heightAnchor.constraint(equalToConstant: 150)

        feedBackView.addSubview(feedbackDescription)
        NSLayoutConstraint.activate([feedbackDescription.topAnchor.constraint(equalTo: feedBackLbl.bottomAnchor, constant: 20),feedbackDescription.leftAnchor.constraint(equalTo: feedBackView.leftAnchor, constant: 10),feedbackDescription.rightAnchor.constraint(equalTo: feedBackView.rightAnchor, constant: -10),desheightConstraint,desheightConstraint])
        
        let sendWidthCons = sendButton.widthAnchor.constraint(equalToConstant: 120.0)
        let sendHeightCons = sendButton.heightAnchor.constraint(equalToConstant: 40.0)

        feedBackView.addSubview(sendButton)
        NSLayoutConstraint.activate([sendButton.topAnchor.constraint(equalTo: feedbackDescription.bottomAnchor, constant: 20),sendWidthCons,sendHeightCons])

        sendButton.centerXAnchor.constraint(equalTo: feedBackView.centerXAnchor).isActive = true
    }
}
