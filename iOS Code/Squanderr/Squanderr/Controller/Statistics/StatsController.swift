//
//  StatsController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 4/13/22.
//

import UIKit
import Firebase


struct RecycleInfo {
    let company: String?
    let recycledItem: String?
    let date: String?
    let description: String?
    let imageUrl: String?

    init(dictionary: [String: Any]) {
        self.company = dictionary["company"] as? String ?? ""
        self.recycledItem = dictionary["recycledItem"] as? String ?? ""
        self.date = dictionary["date"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}







class StatsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var recycleStat = [RecycleInfo]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recycleStat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? StatsTableViewCell
        cell?.stats = recycleStat[indexPath.item]
        //cell.textLabel?.text = "Hello"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    var statTableView =  UITableView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "Stats"
        navigationItem.titleView?.tintColor = .black
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "BradleyHandITCTT-Bold", size: 25)]
        navigationController?.navigationBar.backgroundColor = .systemYellow
        
        setUpTableView()
        fetchStatistics()
        
    }
    
    func setUpTableView(){
        statTableView.delegate = self
        statTableView.dataSource = self
        
        statTableView.register(StatsTableViewCell.self, forCellReuseIdentifier: "cellID")
        
        view.addSubview(statTableView)
        statTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([statTableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     statTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     statTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     statTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        
    }
    
    func fetchStatistics(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let dataRef = Database.database().reference().child("RecycleInfo").child(uid)
        
        dataRef.observe(.value) { dataSnapShot in
            guard let dataSnap = dataSnapShot.value as? [String:Any] else {return}
                //print(dataSnap)
            
            for data in dataSnap {
                self.fetchRecycles(id: data.key, uid: uid)
                
            }
        }
        
    }
    
    func fetchRecycles(id: String,uid: String){
        let dataRef = Database.database().reference().child("RecycleInfo").child(uid).child(id)
            
            
        dataRef.observeSingleEvent(of: .value) { dataSnapShot in
            let recycleinfo = RecycleInfo(dictionary: dataSnapShot.value as! [String : Any])
            print(recycleinfo)
            self.recycleStat.append(recycleinfo)
            self.statTableView.reloadData()
        }
        
        
    }
    
}
