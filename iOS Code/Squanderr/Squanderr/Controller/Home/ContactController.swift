//
//  ContactController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 11/14/22.
//

import UIKit
import MapKit



class ContactController: UIViewController {
    
    var itemName: String = ""
    var recycleImage: UIImage?
    
    var items : String?{
        didSet{
            guard let name = items else {return}
            print(name)
            recycleCompanyLbl.text = name
        }
    }
    var recycleCompany: String = ""
    var phone: String = ""
    var url: String = ""
    var address: String = ""
    
    var detailView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .darkGray
        vw.layer.cornerRadius = 20
        return vw
    }()
    
    var recycleCompanyLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        //lbl.text = "Evergreen Recycling"
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textColor = .white
        return lbl
    }()
    
    var companyAddressLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Address:"
        lbl.textColor = .white
        return lbl
    }()
    
    var addressDetailLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "343 William Street"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        return lbl
    }()
    
    var companyContactLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Contact:"
        lbl.textColor = .white
        return lbl
    }()
    
    var contactDetailLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "+1 201 345 555"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        return lbl
    }()
    
    var companyWebsiteLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Website:"
        lbl.textColor = .white
        return lbl
    }()
    
    var websiteDetailLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "www.recyclenation.com"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        return lbl
    }()
    
    var requestButton: UIButton = {
        let btn = UIButton()
//        btn.frame.size = CGSize(width: 200, height: 50)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Contact", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = .systemYellow
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(requestTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func requestTapped(){
        let requestController = RequestController()
        requestController.recyclingCompany = recycleCompany
        //let navController = UINavigationController(rootViewController: requestController)
        requestController.itemDetail.text = itemName
        requestController.itemsImage.image = recycleImage
        navigationController?.pushViewController(requestController, animated: true)
        //navController.modalPresentationStyle = .fullScreen
        //present(navController, animated: true)
        
    }
    
    
    var mapItem: [MKMapItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.titleView?.tintColor = .black
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "BradleyHandITCTT-Bold", size: 25)]
        
        navigationItem.title = "Detail"
        
        navigationController?.navigationBar.backgroundColor = .systemYellow
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))
        
        let widthConstrant = detailView.widthAnchor.constraint(equalToConstant: view.frame.width)
        let heightConstraint = detailView.heightAnchor.constraint(equalToConstant: 300)
        
        view.addSubview(detailView)
        NSLayoutConstraint.activate([detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
                                     detailView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                                     detailView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),widthConstrant,heightConstraint])
        
        detailView.addSubview(recycleCompanyLbl)
        NSLayoutConstraint.activate([recycleCompanyLbl.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 20)])
        
        recycleCompanyLbl.centerXAnchor.constraint(equalTo: detailView.centerXAnchor).isActive = true
        
        detailView.addSubview(companyAddressLbl)
        NSLayoutConstraint.activate([companyAddressLbl.topAnchor.constraint(equalTo: recycleCompanyLbl.bottomAnchor, constant: 20),
                                     companyAddressLbl.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 10)])
        
        detailView.addSubview(addressDetailLbl)
        NSLayoutConstraint.activate([addressDetailLbl.topAnchor.constraint(equalTo: companyAddressLbl.bottomAnchor, constant: 10),
                                     addressDetailLbl.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 10),addressDetailLbl.rightAnchor.constraint(equalTo: detailView.rightAnchor, constant: 20)])
        
        detailView.addSubview(companyContactLbl)
        NSLayoutConstraint.activate([companyContactLbl.topAnchor.constraint(equalTo: addressDetailLbl.bottomAnchor, constant: 10),
                                     companyContactLbl.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 10)])
        
        detailView.addSubview(contactDetailLbl)
        NSLayoutConstraint.activate([contactDetailLbl.topAnchor.constraint(equalTo: companyContactLbl.bottomAnchor,constant: 10),
                                     contactDetailLbl.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 10)])

        detailView.addSubview(companyWebsiteLbl)
        NSLayoutConstraint.activate([companyWebsiteLbl.topAnchor.constraint(equalTo: contactDetailLbl.bottomAnchor, constant: 10),
                                     companyWebsiteLbl.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 10)])
        
        detailView.addSubview(websiteDetailLbl)
        NSLayoutConstraint.activate([websiteDetailLbl.topAnchor.constraint(equalTo: companyWebsiteLbl.bottomAnchor,constant: 10),
                                     websiteDetailLbl.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 10)])
        
        let widthCons = requestButton.widthAnchor.constraint(equalToConstant: 120.0)
        let heightCons = requestButton.heightAnchor.constraint(equalToConstant: 40.0)
        
        view.addSubview(requestButton)
        NSLayoutConstraint.activate([requestButton.topAnchor.constraint(equalTo: detailView.bottomAnchor, constant: 20),widthCons,heightCons])
        
        requestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //getDetails()
        //guard let name = recycleCompany else {return}
        print("Recycle:\(recycleCompany)")
        recycleCompanyLbl.text = recycleCompany
        contactDetailLbl.text = phone
        addressDetailLbl.text = address
        websiteDetailLbl.text = url
        
    }
    
//    func getDetails(){
//        let searchRequest = MKLocalSearch.Request()
//       // guard let name = recycleCompany else {return}
//        //print(name)
//        searchRequest.naturalLanguageQuery = "\(name)"
//
//        //Search object
//        let activeSearch = MKLocalSearch(request: searchRequest)
//
//        //Start Search
//        activeSearch.start { response, error in
//            if let error = error {
//                print(error.localizedDescription)
//
//            }
//            else {
//                print(response)
//            }
//
//            guard let item = response?.mapItems else {return}
//            self.mapItem = item
//            print(self.mapItem)
//
//
//        }
//
//
//    }
//
//
    
    @objc func backPressed(){
        let recycleController = RecycleController()
        let navController = UINavigationController(rootViewController: RecycleController())
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    
}
