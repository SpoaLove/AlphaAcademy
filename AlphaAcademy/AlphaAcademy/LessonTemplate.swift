//
//  LessonTemplate.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/7/29.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import GoogleMobileAds


class LessonTemplate: Lessons {
    
    
 
    // Test Messages
    let chapter1Messages:[JSQMessage] = [
        JSQMessage(senderId: "2", displayName: "You", text: "Test Message from chapt 1"),
        JSQMessage(senderId: "2", displayName: "You", text: "Test Message from chapt 1!")
    ]
    
    let testRoute:[JSQMessage] = [
        JSQMessage(senderId: "2", displayName: "You", text: "Test Route1"),
        JSQMessage(senderId: "2", displayName: "You", text: "Test Route1!")
    ]
    
    let testRoute2:[JSQMessage] = [
        JSQMessage(senderId: "2", displayName: "You", text: "Test Route2"),
        JSQMessage(senderId: "2", displayName: "You", text: "Test Route2!")
    ]
    
    let alotOfTestMessages:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Hello, World!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "This is an Test of lots of Messages"),
        JSQMessage(senderId: "4", displayName: "Code", text: "print(\"Hello,World!\")"),
        JSQMessage(senderId: "3", displayName: "Console", text: "Hello,World!")
        
    ]
  
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messages += alotOfTestMessages
    }
    
}

// extension for ads
//extension LessonTemplate {
//
//    func createAndLoadInterstitial() -> GADInterstitial {
//        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712")
//        interstitial.delegate = (self as! GADInterstitialDelegate)
//        interstitial.load(GADRequest())
//        return interstitial
//    }
//
//    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//        interstitial = createAndLoadInterstitial()
//    }
//
//    func showAd(){
//        if interstitial.isReady {
//            interstitial.present(fromRootViewController: self)
//        } else {
//            print("Ad wasn't ready")
//        }
//        print("Ad")
//    }
//
//    /// Tells the delegate an ad request succeeded.
//    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
//        print("interstitialDidReceiveAd")
//    }
//
//    /// Tells the delegate an ad request failed.
//    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
//        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
//    }
//
//    /// Tells the delegate that an interstitial will be presented.
//    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
//        print("interstitialWillPresentScreen")
//    }
//
//    /// Tells the delegate the interstitial is to be animated off the screen.
//    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
//        print("interstitialWillDismissScreen")
//    }
//
//
//
//    /// Tells the delegate that a user click will open another app
//    /// (such as the App Store), backgrounding the current app.
//    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
//        print("interstitialWillLeaveApplication")
//    }
//}

