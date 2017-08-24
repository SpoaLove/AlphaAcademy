//
//  LessonsViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/7/29.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseDatabase
import FirebaseAuth
import GoogleMobileAds

struct ChatUser{
    let id: String
    var name: String
}

class LessonsViewController: JSQMessagesViewController {
    
    
    let user1 = ChatUser(id: "1", name: "A-Chan")
    var user2 = ChatUser(id: "2", name: "You")
    let user3 = ChatUser(id: "3", name: "Console")
    let user4 = ChatUser(id: "4", name: "Code")
    
    
    
    var atEndOfRoute:Bool = false
    
    var name:String {
        return user2.name
    }
    
    
    var currentUser: ChatUser {
        
        return user2
    }
    
    
    // all messages
    var messages = [JSQMessage]()
    
    
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
    
    
    var currentMessages = [JSQMessage]()
    var messagesCount=0
    
    var interstitial: GADInterstitial!
    
}

extension LessonsViewController {
    override func didPressAccessoryButton(_ sender: UIButton!) {
        if atEndOfRoute {
            atEndOfRoute = false
            self.selectRoute(title: "Which Route Do you Prefer", message: "message", action1title: "Route1", action2title: "Route2")
            return
        }else{
            quitLesson()
        }
    }
    
}

extension LessonsViewController {
    
    func quitLesson(){
        showAd()
        let selector = UIAlertController(title: "Quit", message: "Do You Really Want to Quit? Progress will be lost!", preferredStyle: .actionSheet)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.performSegue(withIdentifier: "quit", sender: self)
        })
        let no = UIAlertAction(title: "no", style: .default, handler: {
            (action:UIAlertAction) -> () in
        })
        selector.addAction(yes)
        selector.addAction(no)
        self.present(selector, animated: true, completion: nil)
    }
}

extension LessonsViewController {
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        if atEndOfRoute {
            appendMessage(text: "tap the button on the left to answer", senderId: "1", senderDisplayName: "A-Chan")
            return
        }
        
        if text.caseInsensitiveCompare("continue") == ComparisonResult.orderedSame{
            print("continue")
            
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
            
        }else if text.caseInsensitiveCompare("setName") == ComparisonResult.orderedSame{
            setNameTest()
        }else if text.caseInsensitiveCompare("quit") == ComparisonResult.orderedSame{
            quitLesson()
        }else if text.caseInsensitiveCompare("more") == ComparisonResult.orderedSame{
            messages += alotOfTestMessages
        }else if text.caseInsensitiveCompare("test") == ComparisonResult.orderedSame{
            test()
        }else{
            
            appendMessage(text: text, senderId: senderId, senderDisplayName: user2.name)
        }
        
        
        finishSendingMessage()
        
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.row]
        let messageUsername = message.senderDisplayName
        
        return NSAttributedString(string: messageUsername!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        let message = messages[indexPath.row]
        
        switch message.senderId {
        case "2":
            return bubbleFactory?.outgoingMessagesBubbleImage(with: .blue)
        case "1":
            return bubbleFactory?.incomingMessagesBubbleImage(with: .red)
        case "3":
            return bubbleFactory?.incomingMessagesBubbleImage(with: .orange)
        case "4":
            return bubbleFactory?.incomingMessagesBubbleImage(with: .gray)
        default:
            return bubbleFactory?.incomingMessagesBubbleImage(with: .orange)
            
        }
        
        
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
}

//When View is loaded
extension LessonsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712")
        // Do any additional setup after loading the view.
        let request = GADRequest()
        interstitial.load(request)
        
        interstitial.delegate = self as? GADInterstitialDelegate

        
        // tell JSQMessageViewController
        
        
        // who is the current user
        self.senderId = currentUser.id
        self.senderDisplayName = currentUser.name
        
        
        
        
        //append initial messages
        user2.name = getName()
        messages += alotOfTestMessages
        
    }
}

extension LessonsViewController {
    func getMessages(chapter:[JSQMessage]) -> [JSQMessage]{
        
        
        var messages = [JSQMessage]()
        
        messages += chapter
        
        return messages
    }
}

extension LessonsViewController {
    func setChapter(chapter:[JSQMessage]){
        self.currentMessages += getMessages(chapter: chapter)
        
    }
}

extension LessonsViewController {
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

extension LessonsViewController {
    func appendMessage(text: String!, senderId: String!, senderDisplayName: String!){
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        messages.append(message!)
        finishSendingMessage()
    }
}

extension LessonsViewController {
    
    
    func setNameTest(){
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Rename", message: "Please Enter Your Name:", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Name?"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            let name = (textField?.text)!
            print(name)
            UserDefaults.standard.set(name, forKey: "userName")
            self.setNameComplete()
            
            
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            let userID = Auth.auth().currentUser?.uid
            
            let userReference = ref.child("Users").child(userID!)
            
            let userDataDictionary = ["UserName":self.getName()]
            
            userReference.updateChildValues(userDataDictionary, withCompletionBlock: { (err, userReference ) in
                if err != nil {
                    print(err!)
                    return
                }
                print("User Data is updated to database")
            })
            
            
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
    }
}

extension LessonsViewController {
    func setNameComplete(){
        user2.name = getName()
    }
    func getName()->String{
        if let username = UserDefaults.standard.object(forKey: "userName") as? String {
            return username
        }else{
            return "You"
        }
    }
}

extension LessonsViewController {
    func test(){
        print(user2.name)
        appendMessage(text: user2.name, senderId: "1", senderDisplayName: user2.name)
    }
}

extension LessonsViewController {
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712")
        interstitial.delegate = self as! GADInterstitialDelegate
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    func showAd(){
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        print("Ad")
    }
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    

    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}
