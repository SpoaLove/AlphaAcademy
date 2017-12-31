//
//  TutorialViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/8/18.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import AVKit


class TutorialViewController: Lessons {
    
    
    // additional variables
    var finishedSettingName = false
    var setNamebyTyping = false
    var userRefuse = false
    
    // Tutorial Messages!
    let tutorialMessages1:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Welcome to Alpha Academy! My name is A-Chan, your classmate in the Alpha Academy! Please type 'next' or 'n' to continue."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Before we start, I want to know what is your name?")
    ]
    
    let tutorialMessages2:[JSQMessage]=[
        JSQMessage(senderId: "1", displayName: "A", text: "Test Text!"),
        JSQMessage(senderId: "1", displayName: "TestMedia", media: JSQPhotoMediaItem.init(image: UIImage(named: "Title.png")))
        //JSQMessage(senderId: "1", displayName: "TestVideo", media: JSQVideoMediaItem.init(fileURL: URL!, isReadyToPlay: true))
        //JSQMessage(senderId: "1", displayName: "A", media: JSQMessageMediaData.self(#imageLiteral(resourceName: "bubble_regular.png")))
    ]
    
    let tutorialMessages1_1:[JSQMessage]=[
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Good Job! You have just mastered how to answer a multiple choice question! You are now ready for Alpha Academy!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "The future chapters will consists of 2 parts: a Video Lesson and a quiz"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Watch the video, clear the quiz and collect your berets!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Let's meet again in the future courses!")
    ]
    let tutorialMessages1_2:[JSQMessage]=[
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Come on! I know that you are intrested!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Let's try again!")
    
    ]
    
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        if atEndOfRoute {
            atEndOfRoute = false
            self.performSegue(withIdentifier: "goToHome", sender: self)
            return
        }else{
            quitLesson()
        }
    }
    
    
    // quit lesson function
    override func quitLesson(){
        
        guard finishedSettingName else {
            let alertController = UIAlertController(title: "Wait!", message:"The tutorial is not over yet!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let selector = UIAlertController(title: "Quit Tutorial", message: "Press 'quit' to Quit Tutorial!", preferredStyle: .actionSheet)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.performSegue(withIdentifier: "goToHome", sender: self)
        })
        let no = UIAlertAction(title: "no", style: .default, handler: {
            (action:UIAlertAction) -> () in
        })
        selector.addAction(yes)
        selector.addAction(no)
        self.present(selector, animated: true, completion: nil)
        
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        if atEndOfRoute {
            atEndOfRoute = false
            return
        }
        
        // If user entered Next
        if text.caseInsensitiveCompare("next") == ComparisonResult.orderedSame || text.caseInsensitiveCompare("N") == ComparisonResult.orderedSame{
            print("Next Button is pressed")
            
            if messagesCount<currentMessages.count {
                messages.append(currentMessages[messagesCount])
                messagesCount += 1
                
            }else if messagesCount==currentMessages.count && messagesCount != 0{
                
                if finishedSettingName{
                    if choosenRouteName == "" || userRefuse {
                        selectRoute(title: "Ready?", message: "Are You Ready for Alpha Academy?", action1title: "Yes!", action2title: "Not Yet", route1: tutorialMessages1_1, route2: tutorialMessages1_2)
                    }else{
                        appendMessage(text: "Please tap the button on the bottom left to quit Tutorial Lesson!", senderId: "3", senderDisplayName: "Tip!")
                    }
                    atEndOfRoute = true
                }else{
                    setName()
                }
                
                
            }else{
                appendMessage(text: text, senderId: senderId, senderDisplayName: senderDisplayName)
                
            }
            
        // debug Setname
        }else if text.caseInsensitiveCompare("setName") == ComparisonResult.orderedSame{
            setName()
         
        // debug
        }else if text.caseInsensitiveCompare("Debug") == ComparisonResult.orderedSame{
            appendMessageWithJSQMessage(message: tutorialMessages2[1])
            
        // debug video message
        }else if text.caseInsensitiveCompare("Video") == ComparisonResult.orderedSame{
            playVideo()
        }else{
            
            // Other Inputs
            if messagesCount==currentMessages.count && !finishedSettingName {
                
                self.settingName(text)
                return
            }
            appendMessage(text: "please type 'next' or 'n' to continue", senderId: "3", senderDisplayName: "System")
        }
        
        
        finishSendingMessage()
        
    }
    


    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add tutorialMessages into currentMessages
        currentMessages += tutorialMessages1
    }

    // Route Selection with 2 routes
    func selectRoute(title:String, message:String, action1title:String, action2title:String, route1:[JSQMessage], route2:[JSQMessage]){
        let selector = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: action1title, style: .default, handler: {
            (action:UIAlertAction) -> () in
            
            if(action1title == "Yes!"){
                self.userRefuse = false
            }
            
            self.choosenRouteName = action1title
            self.appendMessage(text: action1title, senderId: "2", senderDisplayName: self.getName())
            self.setChapter(chapter: route1)
        })
        let action2 = UIAlertAction(title: action2title, style: .default, handler: {
            (action:UIAlertAction) -> () in
            
            if(action2title == "Not Yet"){
                self.userRefuse = true
            }
            
            self.choosenRouteName = action2title
            self.appendMessage(text: action2title, senderId: "2", senderDisplayName: self.getName())
            self.setChapter(chapter: route2)
        })
        selector.addAction(action1)
        selector.addAction(action2)
        self.present(selector, animated: true, completion: nil)
    }
    
    fileprivate func settingName(_ name: String) {
        print(name)
        UserDefaults.standard.set(name, forKey: "userName")
        self.setNameComplete()
    }
    
    func setName(){
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Setting Name", message: "Please Enter Your Name:", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            var text:String
            
            if let username = UserDefaults.standard.object(forKey: "userName") as? String {
                text = username
            }else{
                text = "name?"
            }
            
            textField.text = text
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            let name = (textField?.text)!
            self.settingName(name)
            
            
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func setNameComplete(){
        user2.name = getName()
        finishedSettingName = true
        let nameIsSetMessage:String = "My name is \(self.getName())!"
        appendMessage(text: nameIsSetMessage, senderId: "2", senderDisplayName: self.getName())
        currentMessages.append(JSQMessage(senderId: "1", displayName: "A-Chan", text: "Hi \(self.getName())! What a nice name!"))
        
    }

    func test(){
        print(user2.name)
        appendMessage(text: user2.name, senderId: "1", senderDisplayName: user2.name)
    }

    // play Video Functions
    override func playVideo() {
        guard let path = Bundle.main.path(forResource: "TeachingVideos/AGintro", ofType:"mp4") else {
            debugPrint("video notfound not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    
    }
    
}
