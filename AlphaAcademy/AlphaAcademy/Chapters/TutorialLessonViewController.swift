//
//  TutorialLessonViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2018/2/10.
//  Copyright © 2018年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class TutorialLessonViewController: Lessons {

    /**
     * Defining additional conditions
     */
    var finishSettingName = false
    var nameDidSet = false
    
    /**
     * Tutorial Messages
     */
    let initialMessages:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Welcome to Alpha Academy! I am your classmate A-Chan! Please type 'next' or 'n' to continue."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Before we start may I ask what is your name?")
    ]
    
    let tutorialMessages:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Alpha Academy is a magical school that is located on the programming island."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "In Alpha Academy everything that happens is governed by magical spells, which is the ‘Swift’ Programming Language!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Swift is a safe and fast programming language which is a fantastic way to write programs! "),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "It is also an easy and friendly way for new programmers to start learning programming!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Everyday, students in Alpha Academy work hard and excel their techniques on using these magical spells!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Here is your beret!")
    ]
    
    let beretRecievingMessage = JSQMessage(senderId: "3", displayName: "System", text: "You have received the White Beret!")
    let userLeveledUpMessage = JSQMessage(senderId: "3", displayName: "System", text: "Level Up! Lv0 -> Lv1")
    
    
    let tutorialMessages2:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Students in Alpha Academy receive new berets as they master new techniques!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "After you have master it all you will receive the Black Beret which is the symbol of being one of the most elite students in the Alpha Academy!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Enjoy your time in Alpha Academy, see you in the next class~")
    ]
    
    
    /**
     * This function s hows a alert when the user attempts to quit the lesson
     * if the user tries to quit the lesson before the user name have been set
     * if the user did finish setting their user name a alert will ask the user if they want to quit the tutorial
     */
    override func quitLesson(){
        guard nameDidSet else {
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
    
    
    /**
     * This function checks if the user have finished the whole tutorial
     * if true the user will be guided to the home page directlly
     * if false the 'quitLesson' function will be called which asks the user to confrim quitting the tutorial
     */
    override func didPressAccessoryButton(_ sender: UIButton!) {
        if atEndOfRoute {
            atEndOfRoute = false
            self.performSegue(withIdentifier: "goToHome", sender: self)
            return
        }else{
            quitLesson()
        }
    }
    
    
    /**
     * Overrided the next function
     * allows the user to set their username
     */
    override func next(){
        if messagesCount<messageQueue.count {
            messages.append(messageQueue[messagesCount])
            messagesCount += 1
        }else if messagesCount==messageQueue.count && messagesCount != 0{
            if finishSettingName{
                if userHaveRecievedBeret {
                    appendMessage(text: "Please tap the button on the bottom left to quit Tutorial Lesson!", senderId: "3", senderDisplayName: "Tip!")
                    atEndOfRoute = true
                }else{
                    appendMessageWithJSQMessage(message: beretRecievingMessage)
                    if defaults.getLevel()==0 {
                        appendMessageWithJSQMessage(message: userLeveledUpMessage)
                        defaults.setLevel(to: 1)
                    }
                    defaults.setBeretNumber(with: 0)
                    messageQueue += tutorialMessages2
                    userHaveRecievedBeret = true
                }
            }else{
                setName()
            }
        }
    }
    
    /**
     * This function overrides the super class reply function allowing the user to set name using the text box
     */
    override func reply(with message: String) -> () {
        for command in commandList{
            if message.caseInsensitiveCompare(command.key)==ComparisonResult.orderedSame {
                return executeCommand(with:command.key)
            }
        }
        
        if messagesCount==messageQueue.count && messagesCount != 0{
            if !nameDidSet{
                return setNameWith(name: message)
            }
        }
        
        return appendMessageWithJSQMessage(message: continueTip)

    }
    
    /**
     * set username to User Defaults using a given username String
     *
     * @param name the String passed in that will be set as the user defaults username
     */
    func setNameWith(name:String) {
        print("Username: \(name)")
        UserDefaults.standard.set(name, forKey: "userName")
        self.setNameComplete()
        next()
    }
    
    /**
     * This function allows the user to set their user name into the UserDefaults
     */
    func setName(){
        let alert = UIAlertController(title: "Setting Name", message: "Please Enter Your Name:", preferredStyle: .alert)
        alert.addTextField { (textField) in
            var text:String
            if let username = UserDefaults.standard.object(forKey: "userName") as? String {
                text = username
            }else{
                text = "name?"
            }
            textField.text = text
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let name = alert?.textFields![0].text!
            self.setNameWith(name: name!)
            self.next()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * This function is called after the user name have been setted
     */
    func setNameComplete(){
        user.name = defaults.getName()
        finishSettingName = true
        let nameIsSetMessage:String = "My name is \(self.defaults.getName())!"
        appendMessage(text: nameIsSetMessage, senderId: "2", senderDisplayName: self.defaults.getName())
        messageQueue.append(JSQMessage(senderId: "1", displayName: "A-Chan", text: "Hi \(self.defaults.getName())! What a nice name!"))
        messageQueue += tutorialMessages
        nameDidSet = true
    }
    
    override func quitSegueIdentifier()->String{
        return "goToHome"
    }
    
    
    override func viewDidLoad() {
        messageQueue += initialMessages
        super.viewDidLoad()
        commandList.removeValue(forKey: "Quiz")
        commandList.removeValue(forKey: "Q")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
