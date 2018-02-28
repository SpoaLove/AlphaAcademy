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
        
        // google ads stuff
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712")
        let request = GADRequest()
        interstitial.load(request)
    }
    
    /**
     * This function shows an ad
     */
    func showAd(){
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
}
