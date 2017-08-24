//
//  UserInfoPageViewController.swift
//  
//
//  Created by Tengoku no Spoa on 2017/7/20.
//
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserInfoPageViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var redoTutorioButton: UIButton!
    @IBOutlet weak var setNameButton: UIButton!
    
    
    var ref: DatabaseReference! = Database.database().reference()
    
    let userID = Auth.auth().currentUser?.uid
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadDatabase()
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
    
    @IBAction func setNameButtonDidPressed(_ sender: Any) {
        setName()
    }
    @IBAction func tutorioButtonDidPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "redoTutorio", sender: self)
    }
}

extension UserInfoPageViewController {
    func loadDatabase(){
        ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["UserName"] as? String ?? "NotSet"
            let email = value?["Email"] as? String ?? "Email"
            
            
            self.userNameLabel.text = username
            self.userEmailLabel.text = email
            
        }) { (error) in
            print(error.localizedDescription)
        }
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
            
            
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            let userID = Auth.auth().currentUser?.uid
            
            let userReference = ref.child("Users").child(userID!)
            
            let userDataDictionary = ["UserName":self.getName()]
            
            userReference.updateChildValues(userDataDictionary, withCompletionBlock: { (err, userReference ) in
                if err != nil {
                    print(err!)
                    return
                }
                print("User Data is updated to database")
            })
            
            
            
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
}
