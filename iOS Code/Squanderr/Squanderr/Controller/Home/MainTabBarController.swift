//
//  MainTabBarController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 4/13/22.
//

import UIKit
import Firebase
import SwiftUI

class MainTabBarController: UITabBarController {
    
    var userID: User?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .gray
        
        tabBar.heightAnchor.constraint(equalToConstant: 120)
        tabBar.backgroundColor = .systemYellow
        
        guard let currentUser = Auth.auth().currentUser?.uid else {return}
        print(currentUser)
        
        if currentUser == nil {
            let loginController = LogInViewController()
            let navController = UINavigationController(rootViewController: loginController)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
        }
       
        
        
        setUpTabBar();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.selectedIndex =  2;
    }
    
    func setUpTabBar(){
        
        let homeController = templeteNavController(unselected_Image: #imageLiteral(resourceName: "recycleUnselected"),selected_Image: #imageLiteral(resourceName: "recycle"),rootViewController: HomeViewController())
        homeController.tabBarItem.selectedImage = #imageLiteral(resourceName: "recycle")
        homeController.tabBarItem.image = #imageLiteral(resourceName: "recycleUnselected")
        
        let swiftUIController = UIHostingController(rootView: StatsSwiftUI())
        
        let statsController = templeteNavController(unselected_Image: #imageLiteral(resourceName: "statsUnselected"),selected_Image: #imageLiteral(resourceName: "statsSelected"),rootViewController: StatsController())
        statsController.tabBarItem.selectedImage = #imageLiteral(resourceName: "statsSelected")
        statsController.tabBarItem.image = #imageLiteral(resourceName: "statsUnselected")
        
        let userProfileController = templeteNavController(unselected_Image: #imageLiteral(resourceName: "profile_un"),selected_Image: #imageLiteral(resourceName: "profie_sel"),rootViewController: UserProfileController())
        userProfileController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profie_sel")
        userProfileController.tabBarItem.image = #imageLiteral(resourceName: "profile_un")
        
        
        viewControllers = [homeController,statsController,userProfileController]
        
        tabBar.tintColor = .black
        
        guard let items = tabBar.items else {
            return
        }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
        }
         
        
    }
    
    
    fileprivate func templeteNavController(unselected_Image:UIImage,selected_Image:UIImage,rootViewController:UIViewController = UIViewController())-> UINavigationController{
        
        let rootController = rootViewController
        let navController = UINavigationController(rootViewController: rootController)
        tabBarController?.tabBarItem.selectedImage = selected_Image
        tabBarController?.tabBarItem.image = unselected_Image
        return navController
        
    }
}

