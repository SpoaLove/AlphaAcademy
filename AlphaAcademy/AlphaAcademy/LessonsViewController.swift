//
//  LessonsViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/7/29.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import JSQMessagesViewController

struct ChatUser{
    let id: String
    let name: String
}

class LessonsViewController: JSQMessagesViewController {
    
    
    let user1 = ChatUser(id: "1", name: "A-Chan")
    let user2 = ChatUser(id: "2", name: "You")
    let user3 = ChatUser(id: "3", name: "Console")
    let user4 = ChatUser(id: "4", name: "Code")
    
    var atEndOfRoute:Bool = false
    
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
        JSQMessage(senderId: "2", displayName: "You", text: "This is an Test of lots of Messages"),
        JSQMessage(senderId: "4", displayName: "Code", text: "print(\"Hello,World!\")"),
        JSQMessage(senderId: "3", displayName: "Console", text: "Hello,World!")

    ]
    
    
    var currentMessages = [JSQMessage]()
    var messagesCount=0
    
}

extension LessonsViewController {
    override func didPressAccessoryButton(_ sender: UIButton!) {
        quitLesson()
    }

}

extension LessonsViewController {
    func quitLesson(){
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
            atEndOfRoute = false
            self.selectRoute(title: "Which Route Do you Prefer", message: "message", action1title: "Route1", action2title: "Route2")
            finishSendingMessage()
            return
        }
        
        if text.caseInsensitiveCompare("continue") == ComparisonResult.orderedSame{
            print("continue")
            
            if messagesCount>currentMessages.count {
                let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
                messages.append(message!)
                
            }else if messagesCount==currentMessages.count{
                messages.append(currentMessages[messagesCount])
                messagesCount += 1
                atEndOfRoute = true
                
            }else{

                messages.append(currentMessages[messagesCount])
                messagesCount += 1
            }
            
        }else if text.caseInsensitiveCompare("route") == ComparisonResult.orderedSame{
            self.selectRoute(title: "Which Route Do you Prefer", message: "message", action1title: "Route1", action2title: "Route2")
            
        }else if text.caseInsensitiveCompare("quit") == ComparisonResult.orderedSame{
            quitLesson()
        }else if text.caseInsensitiveCompare("more") == ComparisonResult.orderedSame{
            messages += alotOfTestMessages
        }else{
            
            let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
            
            
            messages.append(message!)
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


extension LessonsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tell JSQMessageViewController
        // who is the current user
        self.senderId = currentUser.id
        self.senderDisplayName = currentUser.name
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
            self.setChapter(chapter: self.testRoute)
            })
        let action2 = UIAlertAction(title: action2title, style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.setChapter(chapter: self.testRoute2)
        })
        selector.addAction(action1)
        selector.addAction(action2)
        self.present(selector, animated: true, completion: nil)
    }

}
