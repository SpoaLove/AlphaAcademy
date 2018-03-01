//
//  UserInfoPageViewController.swift
//  
//
//  Created by Tengoku no Spoa on 2017/7/20.
//
//

import UIKit


class UserInfoPageViewController: UIViewController {
    
    /**
     * Defines UI Components
     */
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLevelLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var redoTutorialButton: UIButton!
    @IBOutlet weak var setNameButton: UIButton!
    @IBOutlet weak var beretsCollectionButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    
    /**
     * This is an array of possible user images with different color of berets
     */
    var userImages = [
        #imageLiteral(resourceName: "userWhiteBeret"),
        #imageLiteral(resourceName: "userPinkBeret"),
        #imageLiteral(resourceName: "userRedBeret"),
        #imageLiteral(resourceName: "userOrangeBeret"),
        #imageLiteral(resourceName: "userYellowBeret"),
        #imageLiteral(resourceName: "userLimeBeret"),
        #imageLiteral(resourceName: "userGreenBeret"),
        #imageLiteral(resourceName: "userBlueBeret"),
        #imageLiteral(resourceName: "userBlackBeret")
    ]
    
    /**
     * Initiate the defaults class
     */
    let defaults = Defaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load User Info
        loadUserInfo()
        
    }
    
    
    /**
     * This function bring the user back to the title page
     */
    @IBAction func userDidPressedLogOutButton(_ sender: Any) {
        self.performSegue(withIdentifier: "LogOut", sender: self)
    }

    /**
     * This function triggers the setName function
     */
    @IBAction func setNameButtonDidPressed(_ sender: Any) {
        setName()
    }
    
    /**
     * This function triggers the setLevel function
     */
    @IBAction func setLevelButtonDidPressed(_ sender: UIButton) {
        setLevel()
    }
    
    /**
     * This function bring the user to the tutorial page
     */
    @IBAction func tutorialButtonDidPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "redoTutorial", sender: self)
    }
    
    /**
     * This function brings the user the the berets collections
     */
    @IBAction func beretsCollectionButtonDidPressed(_ sender: Any) {
        
        guard defaults.getLevel() > 0 else{
            print("Expect UserLevel to be over 0, instead found \(defaults.getLevel())")
            return
        }
        
        self.performSegue(withIdentifier: "Berets", sender: self)
    }
    
    /**
     * Thgis function loads and update the user information on the the UI
     */
    func loadUserInfo(){
        // set Username tag to userName
        self.userNameLabel.text = defaults.getName()
        self.userLevelLabel.text = getLevelString()
        self.userImageView.image = getBeret()
        
    }
    
    /**
     * This function shoews a UI Alert to set the user name for the user into the userDefaults
     */
    func setName(){
        
        let alert = UIAlertController(title: "Rename", message: "Please Enter Your Name:", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            var text:String
            
            if let username = UserDefaults.standard.object(forKey: "userName") as? String {
                text = username
            }else{
                text = "name?"
            }
            textField.text = text
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            print("Text field: \(String(describing: textField?.text))")
            let name = (textField?.text)!
            print(name)
            self.defaults.setName(with: name)
            self.setNameComplete()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    // DEBUG: Level Setting:
    func setLevel(){
        
        let alert = UIAlertController(title: "Reset Level", message: "New Level?", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            var text:String
            if let userLevel = UserDefaults.standard.object(forKey: "userLevel") as? Int {
                if userLevel < 0 {
                    text = "0"
                } else {
                    text = "\(userLevel)"
                }
            }else{
                text = "0"
            }
            textField.text = text
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            if var level = Int(textField!.text!) {
            
                if level < 0 || level > 8 {
                    level = 0
                    print("Expect level to be non-negative and lower than 8, instead found \(level)")
                }
                
                print(level)
                
                if level < self.defaults.getBeretNumber() {
                    self.defaults.setBeretNumber(with: level)
                }
                
                self.defaults.setLevel(to: level)
                self.setLevelComplete()
            } else {
                print("Error: failed to parse input '\(textField!.text!)' into Int ")
            }
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    /**
     * This function updates the userNameLabel with the userDefaults
     */
    func setNameComplete(){
        self.userNameLabel.text = defaults.getName()
    }
    
    /**
     * This function updates the userLevelLabel with the userDefaults
     */
    func setLevelComplete(){
        self.userLevelLabel.text = getLevelString()
    }
    
    /**
     * This function formats and returns the userLevel as String tom userDefaults
     *
     * @return a formatted String of the userLevel
     */
    func getLevelString() -> String {
        return "Lv: \(defaults.getLevel())"
    }
    
    /**
     * This function returns the corresponding UIImage of user's chosen beret using userDefaults
     *
     * @return a UIImage of user's beret
     */
    func getBeret() -> UIImage {
        return userImages[defaults.getBeretNumber()]
    }
}
