//
//  ViewController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 4/13/22.
//

import UIKit
import AVKit
import Vision

class HomeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var earthImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "earth1")
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .black
        view.alpha = 0.7
        
        navigationItem.title = "Squander"
        navigationItem.titleView?.tintColor = .black
        
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "BradleyHandITCTT-Bold", size: 25),.foregroundColor:UIColor.black]
        
        navigationController?.navigationBar.backgroundColor = .systemYellow
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "about3"), style: .plain, target: self, action: #selector(aboutPressed))
        
        setUpUI()
        
    }
    
    @objc func aboutPressed(){
        let vc = InfoViewController()
        vc.modalPresentationStyle = .formSheet
        vc.preferredContentSize = .init(width: 500, height: 800)
        present(vc, animated: true, completion: nil)
    }
    
    @objc func dismissAlert(){
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func recyclePressed(){
        
        let alertActionSheet = UIAlertController(title: "Capture or select from..", message: nil, preferredStyle: .alert)
        
        alertActionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { UIAlertAction in
            self.showCamera()
        }))
        
        alertActionSheet.addAction(UIAlertAction(title: "Photo Libray", style: .default, handler: { UIAlertAction in
            self.showPhotoLibrary()
        }))
        
        present(alertActionSheet, animated: true) {
            alertActionSheet.view.superview?.isUserInteractionEnabled = true
            alertActionSheet.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissAlert)))
        }
        
    }
    
    
    func showCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    
        
    }
    
    func showPhotoLibrary(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            picker.dismiss(animated: true)
            print(pickedImage.description)
            
            // Convert the image for CIImage
            if let ciImage = CIImage(image: pickedImage) {
                        //processImage(ciImage: ciImage)
                        let processController = ProcessingController()
                        processController.inputImage = ciImage
                        navigationController?.pushViewController(processController, animated: true)
                    }else {
                        print("CIImage convert error")
                    }
        }
    }
    

    func setUpUI(){
        
        view.addSubview(earthImage)
        NSLayoutConstraint.activate([
            earthImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            earthImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            earthImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            earthImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
        
        let gestureRecog = UITapGestureRecognizer(target: self, action: #selector(recyclePressed))
        earthImage.addGestureRecognizer(gestureRecog)
        gestureRecog.numberOfTapsRequired = 1
        earthImage.isUserInteractionEnabled = true
        
    }

}

extension UIView {
  func anchor(top: NSLayoutYAxisAnchor?,left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?,bottom: NSLayoutYAxisAnchor?,paddingTop: CGFloat,paddingLeft: CGFloat,paddingRight: CGFloat,paddingBottom: CGFloat,width: CGFloat,height: CGFloat){
    translatesAutoresizingMaskIntoConstraints = false
    if let top = top{
      self.topAnchor.constraint(equalTo: top,constant: paddingTop).isActive = true
    }
    if let left = left {
      self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    if let right = right{
      self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
    }
    if let bottom = bottom {
      self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
    }
    if width != 0{
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    if height != 0 {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
}
