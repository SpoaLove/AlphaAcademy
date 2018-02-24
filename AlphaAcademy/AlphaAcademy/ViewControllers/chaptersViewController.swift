//
//  chaptersViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/7/29.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import GoogleMobileAds

class chaptersViewController: UIViewController {
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712")
        // Do any additional setup after loading the view.
        let request = GADRequest()
        interstitial.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAd(){
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
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
