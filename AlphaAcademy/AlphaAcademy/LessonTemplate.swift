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
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        if atEndOfRoute {
            atEndOfRoute = false
            self.selectRoute(title: "Which Route Do you Prefer", message: "message", action1title: "Route1", action2title: "Route2")
            return
        }else{
            quitLesson()
        }
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        if atEndOfRoute {
            appendMessage(text: "tap the button on the left to answer", senderId: "1", senderDisplayName: "A-Chan")
            return
        }
        
        if text.caseInsensitiveCompare("next") == ComparisonResult.orderedSame || text.caseInsensitiveCompare("N") == ComparisonResult.orderedSame{
            print("Next Button is pressed")
            
            if messagesCount<currentMessages.count {
                messages.append(currentMessages[messagesCount])
                messagesCount += 1
                
            }else if messagesCount==currentMessages.count && messagesCount != 0{
                appendMessage(text: "tap the button on the left to answer", senderId: "1", senderDisplayName: "A-Chan")
                
                atEndOfRoute = true
                
            }else{
                appendMessage(text: text, senderId: senderId, senderDisplayName: senderDisplayName)
                
            }
            
        }else if text.caseInsensitiveCompare("route") == ComparisonResult.orderedSame{
            self.selectRoute(title: "Which Route Do you Prefer", message: "message", action1title: "Route1", action2title: "Route2")
            
        }else if text.caseInsensitiveCompare("quit") == ComparisonResult.orderedSame{
            quitLesson()
        }else if text.caseInsensitiveCompare("more") == ComparisonResult.orderedSame{
            messages += alotOfTestMessages
        }else{
            appendMessage(text: text, senderId: senderId, senderDisplayName: user2.name)
        }
        finishSendingMessage()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712")
//        // Do any additional setup after loading the view.
//        let request = GADRequest()
//        interstitial.load(request)
//
//        interstitial.delegate = self as? GADInterstitialDelegate

        
        //append initial messages
        user2.name = getName()
        messages += alotOfTestMessages
        
        //
        
    }


    func selectRoute(title:String, message:String, action1title:String, action2title:String){
        let selector = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: action1title, style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.appendMessage(text: action1title, senderId: "2", senderDisplayName: "You")
            self.setChapter(chapter: self.testRoute)
        })
        let action2 = UIAlertAction(title: action2title, style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.appendMessage(text: action2title, senderId: "2", senderDisplayName: "You")
            self.setChapter(chapter: self.testRoute2)
        })
        selector.addAction(action1)
        selector.addAction(action2)
        self.present(selector, animated: true, completion: nil)
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

