//
//  TutorialViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/8/18.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import JSQMessagesViewController


class TutorialViewController: JSQMessagesViewController {
    
    
    let user1 = ChatUser(id: "1", name: "A-Chan")
    var user2 = ChatUser(id: "2", name: "You")
    let user3 = ChatUser(id: "3", name: "Console")
    let user4 = ChatUser(id: "4", name: "Code")
    
    
    
    var atEndOfRoute:Bool = false
    var finishedSettingName:Bool = false
    var setNamebyTyping = false
    
    var name:String {
        return user2.name
    }
    
    
    var currentUser: ChatUser {
        return user2
    }
    
    
    // all messages
    var messages = [JSQMessage]()
    
    
    // Tutorial Messages!
    let initailMessages:[JSQMessage] = [
        JSQMessage(senderId: "3", displayName: "Tip!", text: "please type in 'continue' and press the send button to start the conversation!")
    ]
    let tutorialMessages1:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "??", text: "Welcome to Alpha Academy!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "My name is Alpha, You can call me A-Chan"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Before we start I want to know what is your name?")
    ]
    
    
    var currentMessages = [JSQMessage]()
    var messagesCount=0
    
}

extension TutorialViewController {
    override func didPressAccessoryButton(_ sender: UIButton!) {
        if atEndOfRoute {
            atEndOfRoute = false
            self.performSegue(withIdentifier: "goToHome", sender: self)
            return
        }else{
            quitLesson()
        }
    }
    
}

extension TutorialViewController {
    
    func quitLesson(){
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
}

extension TutorialViewController {
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        if atEndOfRoute {
            atEndOfRoute = false
            return
        }
        
        
        if text.caseInsensitiveCompare("continue") == ComparisonResult.orderedSame{
            print("continue")
            
            if messagesCount<currentMessages.count {
                messages.append(currentMessages[messagesCount])
                messagesCount += 1
                
            }else if messagesCount==currentMessages.count && messagesCount != 0{
                
                if finishedSettingName{
                    appendMessage(text: "tap the button on the left to quit Tutorial Lesson", senderId: "1", senderDisplayName: "A-Chan")
                    
                    atEndOfRoute = true
                }else{
                    setNameTest()
                }
                
            }else{
                appendMessage(text: text, senderId: senderId, senderDisplayName: senderDisplayName)
                
            }
            
        }else if text.caseInsensitiveCompare("setName") == ComparisonResult.orderedSame{
            setNameTest()
        }else{
            if messagesCount==currentMessages.count && !finishedSettingName {
                
                self.settingName(text)
                return
            }
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
extension TutorialViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tell JSQMessageViewController
        
        
        // who is the current user
        self.senderId = currentUser.id
        self.senderDisplayName = currentUser.name
        
        
        
        // append initial messages
        user2.name = getName()
        messages += initailMessages
        
        // add tutorialMessages into currentMessages
        currentMessages += tutorialMessages1
    }
}

// Append Messages
extension TutorialViewController {
    func getMessages(chapter:[JSQMessage]) -> [JSQMessage]{
        
        var messages = [JSQMessage]()
        
        messages += chapter
        
        return messages
    }
}

extension TutorialViewController {
    func setChapter(chapter:[JSQMessage]){
        self.currentMessages += getMessages(chapter: chapter)
        
    }
}

extension TutorialViewController {
    func selectRoute(title:String, message:String, action1title:String, action2title:String, route1:[JSQMessage], route2:[JSQMessage]){
        let selector = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: action1title, style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.appendMessage(text: action1title, senderId: "2", senderDisplayName: "You")
            self.setChapter(chapter: route1)
        })
        let action2 = UIAlertAction(title: action2title, style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.appendMessage(text: action2title, senderId: "2", senderDisplayName: "You")
            self.setChapter(chapter: route2)
        })
        selector.addAction(action1)
        selector.addAction(action2)
        self.present(selector, animated: true, completion: nil)
    }
    
}

extension TutorialViewController {
    func appendMessage(text: String!, senderId: String!, senderDisplayName: String!){
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        messages.append(message!)
        finishSendingMessage()
    }
}

extension TutorialViewController {
    
    
    fileprivate func settingName(_ name: String) {
        print(name)
        UserDefaults.standard.set(name, forKey: "userName")
        self.setNameComplete()
    }
    
    func setNameTest(){
        
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
}

extension TutorialViewController {
    func setNameComplete(){
        user2.name = getName()
        finishedSettingName = true
        let nameIsSetMessage:String = "My name is \(self.getName())!"
        appendMessage(text: nameIsSetMessage, senderId: "2", senderDisplayName: self.getName())
        currentMessages.append(JSQMessage(senderId: "1", displayName: self.getName(), text: "Hi \(self.getName())! What a nice name!"))
        
    }
    func getName()->String{
        if let username = UserDefaults.standard.object(forKey: "userName") as? String {
            return username
        }else{
            return "You"
        }
    }
}

extension TutorialViewController {
    func test(){
        print(user2.name)
        appendMessage(text: user2.name, senderId: "1", senderDisplayName: user2.name)
    }
}
