//
//  ResultsController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 4/13/22.
//

import UIKit

class ResultsController: UIViewController {
    
    var resultImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        //img.image = #imageLiteral(resourceName: "earth6")
        return img
    }()
    
    var resultNameLable: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    var confidanceValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    var recycleButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.titleLabel?.text = "Recycle"
        btn.setTitle("Recycle", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.titleLabel?.textAlignment = .center
        //btn.tintColor = .systemYellow
        btn.backgroundColor = .systemYellow
        btn.addTarget(self, action: #selector(recyclePressed), for: .touchUpInside)
        return btn
    }()
    
    @objc func recyclePressed(){
       let recycleController = RecycleController()
//       let rootController = UINavigationController(rootViewController: recycleController)
        //recycleController.modalPresentationStyle = .fullScreen
        guard let itemName = resultNameLable.text else {return}
        recycleController.item = itemName
        recycleController.recycleImage = resultImage.image
        navigationController?.pushViewController(recycleController, animated: true)
       //present(recycleController, animated: true, completion: nil)
    }
    
    
    var resultName: String?
    var inputImage: CIImage?
    var confidanceValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Results"
        
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .black
        view.alpha = 0.7
        
        setUpUI()
        //let resImg = UIImage(ciImage: inputImage!)
        
        //resultImage.image = resImg
        
       // guard let recognizedImage = resultName else {return}
        //resultNameLable.text = recognizedImage
        
        guard let confidance = confidanceValue else {return}
        confidanceValueLabel.text = confidance
        
        //print("Result is:",recognizedImage)
        print("Confidance is:",confidance)
    }
    
    func setUpUI(){
        view.addSubview(resultImage)
       
        resultImage.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 100, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 250, height: 250)
        
        
        view.addSubview(resultNameLable)
        resultNameLable.anchor(top: resultImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        resultNameLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       // resultNameLable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(confidanceValueLabel)
        confidanceValueLabel.anchor(top: resultNameLable.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        view.addSubview(recycleButton)
        recycleButton.anchor(top: confidanceValueLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 30, paddingLeft: 120, paddingRight: -120, paddingBottom: 0, width: 40, height: 0)
        //recycleButton.clipsToBounds = true
        recycleButton.layer.cornerRadius = 20
        
        //recycleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
}
