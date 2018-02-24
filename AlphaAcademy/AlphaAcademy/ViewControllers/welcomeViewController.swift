//
//  welcomeViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/7/16.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit

class welcomeViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueButtonDidPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toTutor", sender: self)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
