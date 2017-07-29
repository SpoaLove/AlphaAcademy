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
    
    
    var currentMessages = [JSQMessage]()
    var messagesCount=0
    
}

extension LessonsViewController {
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        if text == "continue" {
            print("continue")
            if messagesCount>=currentMessages.count {
                let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
                
                messages.append(message!)
            }else{

                messages.append(currentMessages[messagesCount])
                messagesCount += 1
            }
            
        }else if text == "route"{
            self.selectRoute(title: "Which Route Do you Prefer", message: "message", action1title: "Route1", action2title: "Route2")
            
        }else if text == "quit"{
            
            self.performSegue(withIdentifier: "quit", sender: self)
            
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
        
        if currentUser.id == message.senderId {
            return bubbleFactory?.outgoingMessagesBubbleImage(with: .gray)
        } else {
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
