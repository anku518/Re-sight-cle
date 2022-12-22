//
//  ProcessingController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 4/13/22.
//

import UIKit
import AVKit
import Vision

class ProcessingController: UIViewController {
    
    var processingLable: UILabel = {
        let lbl = UILabel()
        lbl.text = "Processing"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .center
        return lbl
    }()
    
    var processingIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .large
        indicatorView.color = .white
        //indicatorView.startAnimating()
        return indicatorView
    }()
    
    var inputImage: CIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpIndicator()
        
        guard let cIImage = inputImage else {return}
        processImage(ciImage: cIImage)
    }
    
//    @objc func stopPressed(){
//        processingIndicator.stopAnimating();
//        let resultsController = ResultsController()
//        navigationController?.pushViewController(resultsController, animated: true)
//    }
    
    func setUpIndicator(){
        
        view.addSubview(processingLable)
        processingLable.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 300, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        processingLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       
        
        view.addSubview(processingIndicator)
        processingIndicator.anchor(top: processingLable.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        //processingIndicator.center = view.center
        processingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
//        let tapGesture  = UITapGestureRecognizer(target: self, action: #selector(stopPressed))
//        tapGesture.numberOfTapsRequired = 1
//        processingIndicator.addGestureRecognizer(tapGesture)
    }
    
    
    // Process Image output
        func processImage(ciImage: CIImage){
            processingIndicator.startAnimating()
            do{
                let model = try VNCoreMLModel(for: WasteClassification2_1().model)
                
                let request = VNCoreMLRequest(model: model) { (request, error) in
                    self.processClassifications(for: request, error: error)
                }
                
                DispatchQueue.global(qos: .userInitiated).async {
                   
                    let handler = VNImageRequestHandler(ciImage: ciImage,orientation: .right)
                    do {
                        try handler.perform([request])
            
                    } catch {
                        
                        print("Failed to perform classification.\n\(error.localizedDescription)")
                    }
                }
                
            }catch {
                print(error.localizedDescription)
            }
            
        }
        
        func processClassifications(for request: VNRequest, error: Error?) {
            DispatchQueue.main.async {
                guard let results = request.results else {
                    print("Unable to classify image.\n\(error!.localizedDescription)")
                    return
                }
                
               let classifications = results as! [VNClassificationObservation]
                
                if classifications.count == 0 {
                    self.processingIndicator.stopAnimating();
                    print("No item found")
                    let resultsController = ResultsController()
                    resultsController.resultNameLable.text = ""
                    self.navigationController?.pushViewController(resultsController, animated: true)
                }
                else {
                    self.processingIndicator.stopAnimating();
                    print(classifications.first?.confidence.description)
                    print(classifications.first?.identifier.description)
                    let resultsController = ResultsController()
                    resultsController.resultNameLable.text = classifications.first?.identifier.description
                    resultsController.resultImage.image = UIImage(ciImage: self.inputImage!)
                    resultsController.confidanceValue = classifications.first?.confidence.description
                    self.navigationController?.pushViewController(resultsController, animated: true)
                }
//                    for index in (0...(classifications.count-1)){
//                        print(classifications[index].confidence)
//                    }
                
                //self.resultLabel.text = classifications.first?.identifier.uppercased()
            }
            
        }



   
    
}

