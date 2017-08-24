//
//  BeretsCollectionViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/8/23.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit

class BeretsCollectionViewController: UIViewController {

    @IBOutlet weak var quitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func quitButtonIsTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "quitCollection", sender: self)
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
