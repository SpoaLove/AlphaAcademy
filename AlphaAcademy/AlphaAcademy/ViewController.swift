//
//  ViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/7/16.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import FirebaseAuth
import WechatKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var viewLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var signInWithWechat: UIButton!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWechatManager()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
        // Flip the boolean
        isSignIn = !isSignIn
        
        // Check the bool and set the button and labels
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        viewLoadingIndicator.startAnimating()
        
        // TODO: Do some form validation on the email and password
        
        if let email = emailTextField.text, let pass = passwordTextField.text {
            
            // Check if it's sign in or register
            if isSignIn {
                // Sign in the user with Firebase
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                    
                    // Check that user isn't nil
                    if user != nil {
                        
                        self.viewLoadingIndicator.stopAnimating()
                        
                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                        
                    }
                    else {
                        // Error: check error and show message
                        
                        self.viewLoadingIndicator.stopAnimating()
                        
                    }
                    
                })
                
            }
            else {
                // Register the user with Firebase
                
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                    
                    // Check that user isn't nil
                    if user != nil {
                        
                        self.viewLoadingIndicator.stopAnimating()

                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        // Error: check error and show message
                        
                        self.viewLoadingIndicator.stopAnimating()

                    }
                })
                
            }
            
        }
    }
    
    @IBAction func wechatLogin(_ sender: Any) {
        if !WechatManager.shared.isInstalled() {
            print("not install, it will open a webview")
        }
        WechatManager.shared.checkAuth { result in
            switch result {
            case .failure(let errCode):
                print(errCode)
            case .success(let value):
                // User is found, go to home screen
                self.performSegue(withIdentifier: "goToHome", sender: self)
                print(value)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
    }
    

}

extension ViewController {
    fileprivate func setupWechatManager() {
        //设置appid
        WechatManager.appid = "wxd930ea5d5a258f4f"
        WechatManager.appSecret = ""//如果不设置 appSecret 则无法获取access_token 无法完成认证
        
        //设置分享Delegation
        WechatManager.shared.shareDelegate = self
    }
}

// MARK: - WechatManagerShareDelegate
extension ViewController: WechatManagerShareDelegate {
    //app分享之后 点击分享内容自动回到app时调用 该方法
    public func showMessage(_ message: String) {
        print(message)
    }
}
