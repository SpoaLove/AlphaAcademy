//
//  Chapter1LessonViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2018/1/1.
//  Copyright © 2018年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import AVKit
import JSQMessagesViewController

class Chapter1LessonViewController: Lessons {
    
    
    /**
     * Additional variables
     */
    var userCompleteQuiz = false
    var userHaveRecievedBeret = false
    
    /**
     * This function returns a boolean checking if the user have completed the chapter
     * @return the boolean of userLevel higher than 1
     */
    func userCompletedChapter()->Bool {
        return defaults.getLevel()>1
    }

    /**
     * initial lesson messages
     */
    let initialMessages:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Welcome to the first lesson of Alpha Academy!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "In this lesson you will learn about your first spell in Swift!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "For any magician that is learning a new programming language, the first spell they will have to master is the ‘print' function spell!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "‘print’ is super simple to use, all you have to do is to type the code below:"),
        JSQMessage(senderId: "4", displayName: "Code", text: "print(\"Hello, World!\")"),
        JSQMessage(senderId: "3", displayName: "Console", text: "Hello, World!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "The code above is a complete program that can print out the ‘String’ “Hello, World!” onto the console!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "A ‘String’ is a data type used in swift to store text that will be used in the program, a ‘String’ should always start and end with double quotation marks!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Well-done! You have just mastered your very first spell in Swift!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Before you receive your beret, let’s have a simple quiz! Please type quiz to start the quiz!")
    ]

    /**
     * quizes
     */
    var quizes = [
        Quiz(
            questionText: "Which of the following is the correct function of the ‘print’ function",
            choice1: "print out a String onto the console",
            choice2: "print out a Cotton onto the console",
            choice3: "print put a Kitten onto the console",
            correctAnswer: "print out a String onto the console",
            messageCorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "Correct! Remember that the print function prints a String"),
            messageIncorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "The answer is incorrect! Read carefully through the lesson and try again!")
        ),
        Quiz(
            questionText: "Which of the following code is a valid ‘print’ function:",
            choice1: "print(‘Hello, Alpha Academy!’)",
            choice2: "print(Hello, Alpha Academy!)",
            choice3: "print(\"Hello, Alpha Academy!\")",
            correctAnswer: "print(\"Hello, Alpha Academy!\")",
            messageCorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "Correct! Remember that a ‘String’ should always start and end with double quotation marks!"),
            messageIncorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "The answer is incorrect! Read carefully through the lesson and try again!")
            )
    ]
    
    /**
     * post quiz messages
     */
    let postQuizMessages:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "You have successfully passed the quiz!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "This is your new beret!")
    ]
    
    let beretRecievingMessage = JSQMessage(senderId: "3", displayName: "System", text: "You have received the Pink Beret!")
    let userLeveledUpMessage = JSQMessage(senderId: "3", displayName: "System", text: "Level Up! Lv1 -> Lv2")
    
    
    /**
     * post quiz messages2
     */
    let postQuizMessages2:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "You can always change your beret in your beret collection that have been opened in the home page!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Enjoy your time in Alpha Academy, see you in the next class~")
    ]
    
    
    
    /**
     * This function shows and remove the first quiz if quizes is not empty
     */
    func showQuizes(){
        if !quizes.isEmpty {
            showQuiz(with: quizes.first!)
        }
    }
    
    override func correctResponse() {
        quizes.removeFirst()
        if quizes.count >= 2 {
            appendMessage(text: "\(quizes.count-1) questons left!", senderId: "3", senderDisplayName: "QUIZ!")
        } else if quizes.count == 1 {
            appendMessage(text: "1 queston left! Type 'Q' or Quiz to Continue!", senderId: "3", senderDisplayName: "QUIZ!")
        } else {
            appendMessage(text: "All Questions have been answered correctlly!", senderId: "3", senderDisplayName: "QUIZ!")
            
            messagesCount = currentMessages.count
            currentMessages += postQuizMessages
            userCompleteQuiz = true
        }
    }
    
    override func next(){
        if userCompleteQuiz && messagesCount==currentMessages.count && !userHaveRecievedBeret {
            appendMessageWithJSQMessage(message: beretRecievingMessage)
            if defaults.getLevel()==1 {
                appendMessageWithJSQMessage(message: userLeveledUpMessage)
                defaults.setLevel(to: 2)
            }
            defaults.setBeretNumber(with: 1)
            currentMessages += postQuizMessages2
            userHaveRecievedBeret = true
        }
        
        if userHaveRecievedBeret && messagesCount==currentMessages.count && !atEndOfRoute{
            appendMessage(text: "Please tap the button on the bottom left to quit Lesson 1!", senderId: "3", senderDisplayName: "Tip!")
            atEndOfRoute = true
        }
        
        super.next()
    }

    
    override func quiz() {
        showQuizes()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentMessages += initialMessages
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}




