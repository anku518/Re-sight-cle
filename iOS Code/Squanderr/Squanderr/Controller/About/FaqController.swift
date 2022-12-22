//
//  FaqController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 11/23/22.
//

import UIKit

class FAQController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? FaqTableViewCell
        cell?.faqView.sizeToFit()
        cell?.faqView.layoutIfNeeded()
        cell?.faqQuestion.text = questions[indexPath.row]
        cell?.answerlabel.text = answer[indexPath.row]
        //cell?.textLabel?.text = "Hello"
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }
        else if indexPath.row == 4{
            return 250
        }
        else {
            return 150
        }
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var title = "FAQ"
//        if section == 0 {
//            return title
//        }
//        return ""
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    let headerView = UIView()
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        //headerView.backgroundColor = UIColor.lightGray
        let sectionLabel =  UILabel(frame: CGRect(x: 8, y: 28, width: tableView.frame.width, height: 40))
//     // let sectionLabel = UILabel(frame: CGRect(x: 8, y: 5, width:
//                    tableView.bounds.size.width, height: tableView.bounds.size.height))
        sectionLabel.font = .boldSystemFont(ofSize: 22)
                sectionLabel.textColor = UIColor.black
                sectionLabel.text = "FAQ"
                sectionLabel.sizeToFit()
                headerView.addSubview(sectionLabel)

     return headerView
    }
    
    
    var faqTableView = UITableView()
    
    var questions = ["What are the most common items that can be recycled?",
                     "What are the items that can never be recycled?",
                     "Why are some items that look recyclable not accepted at my recycling facility?",
                     "How do I know what my local recycling options are?",
                     "Why is it important to take the recyclable items to the recycling facilities for recycling?"]
    
    var answer = ["Paper,Plastic,Glass,Cans ,Cardboard,Metal",
                  "Food or food-soiled paper ,Aerosol cans ,Garden hoses ,Propane tanks or cylinder ,Hazardous chemical waste",
                  "Most of the time, the app will help you to identify the items which are recyclable. If it doesn’t then the picture uploaded wasn’t clear enough. Suggestible to re-upload the image on the app.",
                  "After you scan your item in the app, you will head to a screen which locates all the local recycling facilities in your nearby county or municipality area premises, if there are any.",
                  "If we don't recycle the recyclable items properly all the waste will contaminate the recycling stem. After these non recyclable items arrive at recycling centers, they can cause costly damage to the equipment. Also, it’s harmful to our environment in not depositing the waste properly. That is why it is important to take necessary actions and trash the waste in recycling facilities"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        navigationItem.title = "FAQ"
        
        navigationController?.navigationBar.backgroundColor = .systemYellow
        
        setUpTableView()
        faqTableView.headerView(forSection: 0)?.largeContentTitle = "FAQ"
        
    }
    
    func setUpTableView() {
        faqTableView.translatesAutoresizingMaskIntoConstraints = false
        faqTableView.estimatedRowHeight = 200
        faqTableView.rowHeight = UITableView.automaticDimension
        
        faqTableView.dataSource = self
        faqTableView.delegate = self
        
        faqTableView.register(FaqTableViewCell.self, forCellReuseIdentifier: "cellID")

        let heightContrint = faqTableView.heightAnchor.constraint(equalToConstant: view.frame.height + 250)
        faqTableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        view.addSubview(faqTableView)
        
        NSLayoutConstraint.activate([faqTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
                                     faqTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
                                     faqTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
                                     faqTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),heightContrint])
//        faqTableView.contentInset = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0);
        
        faqTableView.sectionHeaderTopPadding = 0
        faqTableView.largeContentTitle = "FAQ"
        faqTableView.tableHeaderView = headerView;
        
    }
    
}
