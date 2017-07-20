//
//  UserInfoPageViewController.swift
//  
//
//  Created by Tengoku no Spoa on 2017/7/20.
//
//

import UIKit
import FirebaseAuth

class UserInfoPageViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func userDidPressedLogOutButton(_ sender: Any) {
        try? Auth.auth().signOut()
        // set user defaults to logged in
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        UserDefaults.standard.set(nil, forKey: "userEmail")
        UserDefaults.standard.set(nil, forKey: "userPass")
        self.performSegue(withIdentifier: "LogOut", sender: self)
    }

}
