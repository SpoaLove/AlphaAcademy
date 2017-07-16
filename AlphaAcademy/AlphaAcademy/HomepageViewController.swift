//
//  HomepageViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/7/17.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseStorage

class HomepageViewController: UIViewController {

    
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let user = Auth.auth().currentUser {
            //user is signied in
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid
            
            let storage = Storage.storage()
            let storageRef = storage.reference(forURL: "gs://alphaacademy-406a5.appspot.com")


        
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userDidLogOut(_ sender: UIButton) {
        try? Auth.auth().signOut()
        WechatManager.shared.logout()
        self.performSegue(withIdentifier: "Logout", sender: self)
    }




}
