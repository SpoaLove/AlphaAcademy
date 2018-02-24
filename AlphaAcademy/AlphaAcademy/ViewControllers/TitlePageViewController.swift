//
//  TitlePageViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/8/22.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit

class TitlePageViewController: UIViewController {
    fileprivate func startButtonIsPressed() {
        if UserDefaults.standard.object(forKey: "userStarted") != nil{
            performSegue(withIdentifier: "Start", sender: self)
        }else{
            UserDefaults.standard.set(true, forKey: "userStarted")
            performSegue(withIdentifier: "FirstTimeEnter", sender: self)
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
        print("Start")
        startButtonIsPressed()

    }
    
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

}
