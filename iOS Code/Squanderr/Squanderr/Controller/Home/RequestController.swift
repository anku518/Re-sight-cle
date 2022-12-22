//
//  RequestController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 12/2/22.
//

import UIKit
import Firebase

class RequestController: UIViewController {
    
    
    var recyclingCompany: String?
    
    var scrollView: UIScrollView = {
        let vw  = UIScrollView()
        vw.translatesAutoresizingMaskIntoConstraints = false
       
        return vw
    }()
    
    var detailView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    var itemsImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "splash1.jpeg")
        return img
    }()
    
    var itemLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Items"
        lbl.font = .boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    var itemDetail: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = ""
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Description"
        lbl.font = .boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    var postDescription: UITextView = {
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
        guard let company = recyclingCompany else {return}

        let itemName = itemDetail.text
        let description = postDescription.text
        //let date = "12/5/2022"
        
        let recycleImage = itemsImage.image
        
        guard let uploadedData = recycleImage?.jpegData(compressionQuality: 0.3) else {return}
        
        let filename = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference().child("RecycledItem").child(filename)
        
        storageRef.putData(uploadedData,metadata: nil) {
            storageMeta, error in
            if let err = error {
                print(err.localizedDescription)
            }
            
            storageRef.downloadURL { url, error in
                if let err = error{
                    print(err.localizedDescription)
                }
                
                
                guard let recycleImageUrl = url?.absoluteString else  {return}
                print(recycleImageUrl)
                
                guard let currentUser = Auth.auth().currentUser?.uid else {return}
                
                let timestamp = Date().timeIntervalSince1970
                
                let date = Date(timeIntervalSince1970: timestamp)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM-dd-yyyy"
                dateFormatter.timeZone = TimeZone.current
                
                let dictionaryValues: [AnyHashable: Any] = ["company":company,"recycledItem": itemName,"imageUrl":recycleImageUrl,"userID": currentUser,"description":description,"date": dateFormatter.string(from: date)]
                
                let values = [dictionaryValues]
                
                
                Database.database().reference().child("RecycleInfo").child (currentUser).childByAutoId().updateChildValues(dictionaryValues) { error, dataRef in
                    if let err = error {
                        print(err.localizedDescription)
                    }
                    
                    print("Request sent succesfully")
                    
                    let alertController = UIAlertController(title: "Status", message: "Request has been sent sucessfully to recycling Company", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default,handler: { UIAlertAction in
                        let rootController = MainTabBarController()
                        let naController = UINavigationController(rootViewController: rootController)
                        self.view.window?.rootViewController  = rootController
                        //self.present(rootController, animated: true)
                    }))
                
                    self.present(alertController, animated: true)
//                Database.database().reference().child("RecycleInfo").updateChildValues(values) { error, dataRef in
//                    if let err = error {
//                        print(err.localizedDescription)
//                    }
//
//                    print("Request sent succesfully")
//
                }
                
            }
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Request"
        navigationItem.titleView?.tintColor = .black
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "BradleyHandITCTT-Bold", size: 25)]
        navigationController?.navigationBar.backgroundColor = .systemYellow
        
        
        
//        let widCon = detailView.widthAnchor.constraint(equalToConstant: view.frame.width)
//        let heitCon = detailView.heightAnchor.constraint(equalToConstant: view.frame.height + 200)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                                     scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isScrollEnabled = true
        
        scrollView.addSubview(detailView)
        
        detailView.anchor(top: scrollView.topAnchor,
                          left: view.leftAnchor,
                          right: view.rightAnchor,
                        bottom: scrollView.bottomAnchor,
                        paddingTop: -20,
                        paddingLeft: 0,
                        paddingRight: 0,
                        paddingBottom: 0,
                          width: view.frame.width,
                        height:800)
        
        detailView.addSubview(itemsImage)
        itemsImage.anchor(top: detailView.topAnchor, left: detailView.leftAnchor, right: detailView.rightAnchor, bottom: nil, paddingTop: 100, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 250, height: 250)
        
       detailView.addSubview(itemLabel)
        NSLayoutConstraint.activate([itemLabel.topAnchor.constraint(equalTo: itemsImage.bottomAnchor, constant: 20),
                                    itemLabel.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 10)])
       detailView.addSubview(itemDetail)
        NSLayoutConstraint.activate([itemDetail.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 10),
                                    itemDetail.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 10)])
       detailView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([descriptionLabel.topAnchor.constraint(equalTo: itemDetail.bottomAnchor, constant: 20),
                                     descriptionLabel.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 10)])
        let widthConstrant = postDescription.widthAnchor.constraint(equalToConstant: detailView.frame.width)
       let heightConstraint = postDescription.heightAnchor.constraint(equalToConstant: 200)

        detailView.addSubview(postDescription)
        NSLayoutConstraint.activate([postDescription.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),postDescription.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 10),postDescription.rightAnchor.constraint(equalTo: detailView.rightAnchor, constant: -10),widthConstrant,heightConstraint])


        let widthCons = sendButton.widthAnchor.constraint(equalToConstant: 120.0)
        let heightCons = sendButton.heightAnchor.constraint(equalToConstant: 40.0)

        detailView.addSubview(sendButton)
        NSLayoutConstraint.activate([sendButton.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 20),widthCons,heightCons])

        sendButton.centerXAnchor.constraint(equalTo: detailView.centerXAnchor).isActive = true

//        postDescription.anchor(top: descriptionLabel.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 50, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 40)

        print(recyclingCompany)
        print(itemDetail.text)
        
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        tapGestureRecog.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecog)
    }
    
    @objc func endEditing(){
        view.endEditing(true)
    }
    
    
    
    
}
