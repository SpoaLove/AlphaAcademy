//
//  welcomeViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/7/16.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit

class welcomeViewController: UIViewController {
    
    /**
     * This function brings the user to the tutorial lesson
     */
    @IBAction func continueButtonDidPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toTutor", sender: self)
    }
    
}
