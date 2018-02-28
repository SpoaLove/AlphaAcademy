//
//  TitlePageViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/8/22.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit

class TitlePageViewController: UIViewController {
    
    
    /**
     * This function bring the user to a different story board according to if the user have used the application for at least once or not
     * if true the user will be brought to the chapters selection page
     * if false the user wil be brought to the tutorial lessons
     */
    @IBAction func startButton(_ sender: Any) {
        print("Start")
        if UserDefaults.standard.object(forKey: "userStarted") != nil{
            performSegue(withIdentifier: "Start", sender: self)
        }else{
            UserDefaults.standard.set(true, forKey: "userStarted")
            performSegue(withIdentifier: "FirstTimeEnter", sender: self)
        }
    }

}
