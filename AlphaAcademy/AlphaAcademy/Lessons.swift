//
//  Chapter1LessonViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/12/31.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import AVKit

class Lessons: JSQMessagesViewController {

    
    // Define Users
    let user1 = ChatUser(id: "1", name: "A-Chan")
    var user2 = ChatUser(id: "2", name: "You")
    let user3 = ChatUser(id: "3", name: "Console")
    let user4 = ChatUser(id: "4", name: "Code")

    // Define Conditions
    var atEndOfRoute = false
    var choosenRouteName:String = ""
    var finishedLesson = false

    // define Current User
    var name:String {
        return user2.name
    }
    var currentUser: ChatUser {
        return user2
    }
    
    // all Messages
    var messages = [JSQMessage]()
    
    // Messages variables
    var currentMessages = [JSQMessage]()
    var messagesCount=0
    
    // Messages
    let initailMessages:[JSQMessage] = [
        JSQMessage(senderId: "3", displayName: "Tip!", text: "please type in 'next' or 'n' and press the send button to start the conversation!")
    ]
    
    // Avatar size
    let avatarSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height: kJSQMessagesCollectionViewAvatarSizeDefault)
    
    
    // quit when accessoryButton is Pressed
    override func didPressAccessoryButton(_ sender: UIButton!) {
        if atEndOfRoute {
            atEndOfRoute = false
            performSegue(withIdentifier: "goToHome", sender: self)
            return
        }else{
            quitLesson()
        }
    }
    
    // quit lesson function
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
                
            // reach end of the Route
            }else if messagesCount==currentMessages.count && messagesCount != 0{
                if finishedLesson{
                    appendMessage(text: "Please tap the button on the bottom left to quit Chpater 1!", senderId: "3", senderDisplayName: "Tip!")
                    atEndOfRoute = true
                }
                
            }else{
                appendMessage(text: text, senderId: senderId, senderDisplayName: senderDisplayName)
            }
            
        // debug video message
        }else if text.caseInsensitiveCompare("Video") == ComparisonResult.orderedSame{
            playVideo()
        
        // other inputs have been found
        }else{
            appendMessage(text: "please type 'next' or 'n' to continue", senderId: "3", senderDisplayName: "System")
        }
        finishSendingMessage()
    }
    
    // Message sender Display Name
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.row]
        let messageUsername = message.senderDisplayName
        
        return NSAttributedString(string: messageUsername!)
    }
    
    
    // Message Bubble Height
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
    // Message Bubble Image
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        
        let message = messages[indexPath.row]
        
        if message.isMediaMessage {
            playVideo()
        }
        
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
    
    // Message Avatar Image
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        let avatarImageFactory = JSQMessagesAvatarImageFactory.self
        
        let message = messages[indexPath.item]
        
        switch message.senderId {
        case "1":
            // Sender is A-Chan
            return avatarImageFactory.avatarImage(with: UIImage(named: "Title.png"), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        case "2":
            // Sender is Yourself
            return avatarImageFactory.avatarImage(with: UIImage(named: "userWhiteBeret.png"), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        case "3":
            // Sender is Console
            return JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: ">_", backgroundColor: UIColor.black, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        case "4":
            // Sender is Code
            return JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: ">_", backgroundColor: UIColor.orange, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 14), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        default:
            // Sender is Code
            return JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: "?", backgroundColor: UIColor.white, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 14), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    
    // Messages functions
    // set Chapter
    func setChapter(chapter:[JSQMessage]){
        currentMessages += chapter
        
    }
    // appending Messages
    func appendMessage(text: String!, senderId: String!, senderDisplayName: String!){
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        messages.append(message!)
        finishSendingMessage()
    }
    func appendMessageWithJSQMessage(message: JSQMessage){
        messages.append(message)
        finishSendingMessage()
    }

    // Videos
    func playVideo() {
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
    
    // get userName from user defaults
    func getName()->String{
        if let username = UserDefaults.standard.object(forKey: "userName") as? String {
            return username
        }else{
            return "You"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // tell JSQMessageViewController who is the current user
        senderId = currentUser.id
        senderDisplayName = currentUser.name
        
        // append initial messages
        user2.name = getName()
        messages += initailMessages
        
    }

}
