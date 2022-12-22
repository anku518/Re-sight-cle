//
//  InfoViewController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 9/22/22.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    let array = ["FAQ","Contact Team"]
    let imageArray = ["faq","Icon-20"]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? SearchTableViewCell
        cell?.searchContentLabel.text = array[indexPath.row]
        cell?.searchImageView.image =  UIImage(imageLiteralResourceName: imageArray[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID",for: indexPath)
        if array[indexPath.row] == "FAQ"{
            let faqController = FAQController()
            let navController = UINavigationController(rootViewController: faqController)
            navController.modalPresentationStyle = .popover
            present(navController, animated: true)
        }
        else if array[indexPath.row] == "Contact Team"{
            let contactController = ContactTeamController()
            let navController = UINavigationController(rootViewController: contactController)
            navController.modalPresentationStyle = .popover
            present(navController, animated: true)
        }
        else{
            return
        }
    }
    
    
    var recycleImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = #imageLiteral(resourceName: "squand")
        return img
    }()
    
    var aboutLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "What Sqander Does"
        lbl.font = .boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    var aboutDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Sqander is waste detection and recycling application.It provides a way for proper disposal of recyclable waste and make our planet more greener."
        lbl.font = .systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var useLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "How to Use"
        lbl.font = .boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    var useDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Click on Earth image to capture photo of recyclable items and once it recognizes, you can choose to recycle at specific location nearby to your area."
        lbl.font = .systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    var searchLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Look for"
        lbl.font = .boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    var searchForTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpUI()
    }
    
    func setUpUI(){
        view.addSubview(recycleImageView)
        NSLayoutConstraint.activate([recycleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),recycleImageView.leftAnchor.constraint(equalTo: view.leftAnchor),recycleImageView.rightAnchor.constraint(equalTo: view.rightAnchor)
                                     ,recycleImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
                                     recycleImageView.heightAnchor.constraint(equalToConstant: 250)
                                    ])
        
        view.addSubview(aboutLabel)
        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: recycleImageView.bottomAnchor, constant: 20),
            aboutLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)])
        
        view.addSubview(aboutDescription)
        NSLayoutConstraint.activate([aboutDescription.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 10),aboutDescription.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),aboutDescription.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 10)])
        
        view.addSubview(useLabel)
        NSLayoutConstraint.activate([
            useLabel.topAnchor.constraint(equalTo: aboutDescription.bottomAnchor, constant: 20),
            useLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)])
        
        view.addSubview(useDescription)
        NSLayoutConstraint.activate([useDescription.topAnchor.constraint(equalTo: useLabel.bottomAnchor, constant: 10),useDescription.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),useDescription.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10)])
        
        view.addSubview(searchLabel)
        NSLayoutConstraint.activate([
            searchLabel.topAnchor.constraint(equalTo: useDescription.bottomAnchor, constant: 20),
            searchLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)])
        
        
        let heighttable = searchForTableView.heightAnchor.constraint(equalToConstant: 100)
        
        view.addSubview(searchForTableView)
        searchForTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([searchForTableView.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 10),
                                     searchForTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                                     searchForTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
                                     searchForTableView.widthAnchor.constraint(equalTo: view.widthAnchor),searchForTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),heighttable])
        
        
        searchForTableView.delegate = self
        searchForTableView.dataSource = self
        
        searchForTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "cellID")
        
    }
}
