//
//  UserInfoPageViewController.swift
//  
//
//  Created by Tengoku no Spoa on 2017/7/20.
//
//

import UIKit


class UserInfoPageViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLevelLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var redoTutorialButton: UIButton!
    @IBOutlet weak var setNameButton: UIButton!
    @IBOutlet weak var beretsCollectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load User Info
        loadUserInfo()
        
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
        // set user defaults to logged in
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        UserDefaults.standard.set(nil, forKey: "userEmail")
        UserDefaults.standard.set(nil, forKey: "userPass")
        self.performSegue(withIdentifier: "LogOut", sender: self)
    }
    
    @IBAction func setNameButtonDidPressed(_ sender: Any) {
        setName()
    }
    @IBAction func tutorialButtonDidPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "redoTutorio", sender: self)
    }
    @IBAction func beretsCollectionButtonDidPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "Berets", sender: self)
    }
}

extension UserInfoPageViewController {
    func loadUserInfo(){
        // set Username tag to userName
        self.userNameLabel.text = getName()
        self.userLevelLabel.text = getLevel()
    }
}



// Name Setting
extension UserInfoPageViewController {
    
    
    func setName(){
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Rename", message: "Please Enter Your Name:", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            var text:String
            
            if let username = UserDefaults.standard.object(forKey: "userName") as? String {
                text = username
            }else{
                text = "name?"
            }
            
            textField.text = text
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            let name = (textField?.text)!
            print(name)
            UserDefaults.standard.set(name, forKey: "userName")
            self.setNameComplete()
            
            
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
    }
}

extension UserInfoPageViewController {
    func setNameComplete(){
        self.userNameLabel.text = getName()
    }
    func getName()->String{
        if let username = UserDefaults.standard.object(forKey: "userName") as? String {
            return username
        }else{
            return "Name"
        }
    }
    func getLevel()->String{
        if let userLevel = UserDefaults.standard.object(forKey: "userLevel") as? Int {
            return "Lv:\(String(userLevel))"
        }else{
            return "Lv:0"
        }
    }
}
