//
//  Chapter2LessonViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2018/2/25.
//  Copyright © 2018年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import JSQMessagesViewController

/**
 * Chapter 2 Lesson View Controller
 * var & let
 * This lesson teaches the student how to declear variables
 */
class Chapter2LessonViewController: Lessons {
    
    /**
     * This function returns a boolean checking if the user have completed the chapter
     * @return the boolean of userLevel higher than 2
     */
    func userCompletedChapter()->Bool {
        return defaults.getLevel()>2
    }
    
    /**
     * initial lesson messages
     */
    let initialMessages:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Welcome to the second lesson of Alpha Academy!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "In this lesson you will learn how to declare variables and constants using the magical spell ‘var’ and ‘let’."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "‘Variables’ and ‘Constant’ stands for all kinds of data that is stored in the program."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "By ‘Declaring’ a Variable or Constant it is to make a space for you to store the data."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Declaring is a super important spell to learn as a magician."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "In Swift you use the magical spell ‘var’ to declare a variable and ‘let’ to declare a constant!"),
        JSQMessage(senderId: "4", displayName: "Code", text: "var myVariable = 42\nvar myConstant = \"a Constant String\""),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Noticed the ‘=' sign, in programming ‘=’ does not means equals, instead it means saving the value on the right into the left."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Every Variable and Constant will have a name, type and a value."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "The code above can be read as: Declaring a variable named ‘myVariable’ with the value of 42, and Declaring a constant named ‘myConstant’ of value \"a Constant String\"."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Where is the type? You may ask."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Well, Swift do it for you using‘Type Inference’ where it automatically detects the type of the value passed in so you can, you can still explicitly state the type of the variable like the following:"),
        JSQMessage(senderId: "4", displayName: "Code", text: "var myVariable:Int = 42\nlet myConstant:String = \"a Constant String\""),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "The variable ‘myVariable’ is explicitly declared as an ‘Int’ variable which stands for Integer a data type used to store whole numbers without decimals, and the constant ‘myConstant’ is explicitly declared as a ‘String’ where we have learned from last class."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "When you declare type explicitly, make sure the first letter of the type is capitalized, like ‘String’ and ‘Int’."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "The only difference between declaring a variable or a constant is that a variable is mutable after you declared it, but constant is unchangeable."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "You can change a variable’s value by passing in a new value with the same type, if the type of the data is different it will fail, when you try to assign a value to a constant it always fail:"),
        JSQMessage(senderId: "4", displayName: "Code", text: "var aNumber = 12\naNumber = 24 // this works\naNumber = \"24\" // this fails\n\nlet three = 3\nthree = 4 // this fails"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "You can also print out a variable that you declared like this:"),
        JSQMessage(senderId: "4", displayName: "Code", text: "var myName = \"A-Chan\"\nprint(\"Hello, my name is \\(myName)!\")"),
        JSQMessage(senderId: "3", displayName: "Console", text: "Hello, my name is A-Chan!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "you use \\() to include a variable in the String you want to print out."),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Well-done! You have just mastered how to Declare variable and constants"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Before you receive your beret, let’s have a simple quiz! Please type 'q' or 'quiz' to start the quiz!")
    ]
    
    /**
     * quizes
     */
    var quizes:[Quiz] = [
        MultipleChoiceQuiz(
            questionText: "Which of the following is the correct definition of ‘=’ in Swift",
            choice1: "assigning the value on the left to the right",
            choice2: "the left equals the right value",
            choice3: "assigning the value on the right to the left",
            correctAnswer: "assigning the value on the right to the left",
            messageCorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "Correct! the '=' button assign the value on the right of the sign to the left"),
            messageIncorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "The answer is incorrect! Read carefully through the lesson and try again!")
        ),
        YesOrNoQuiz(
            questionText: "a Constant is mutable?",
            correctAnswer: "No",
            messageCorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "Remeber that "),
            messageIncorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "The answer is incorrect! Read carefully through the lesson and try again!")
        ),
        UserInputQuiz(
            questionText: "Please declare a constant called “lunch” with the value of “Burger” with it’s type explicitly",
            correctAnswer: "let lunch:String = burger",
            messageCorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "42 is the Answer"),
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
    let userLeveledUpMessage = JSQMessage(senderId: "3", displayName: "System", text: "Level Up! Lv2 -> Lv3")
    
    /**
     * post quiz messages2
     */
    let postQuizMessages2:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "You can always change your beret in your beret collection that have been opened in the home page!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Enjoy your time in Alpha Academy, see you in the next class~")
    ]
    
    override func correctResponse() {
        quizes.removeFirst()
        if quizes.count >= 2 {
            appendMessage(text: "\(quizes.count) questons left!", senderId: "3", senderDisplayName: "QUIZ!")
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
            if defaults.getLevel()==2 {
                appendMessageWithJSQMessage(message: userLeveledUpMessage)
                defaults.setLevel(to: 3)
            }
            defaults.setBeretNumber(with: 3)
            currentMessages += postQuizMessages2
            userHaveRecievedBeret = true
        }
        
        if userHaveRecievedBeret && messagesCount==currentMessages.count && !atEndOfRoute{
            appendMessage(text: "Please tap the button on the bottom left to quit Lesson 1!", senderId: "3", senderDisplayName: "Tip!")
            atEndOfRoute = true
        }
        
        super.next()
    }
    
    /**
     * This function shows and remove the first quiz if quizes is not empty
     */
    override func quiz() {
        if !quizes.isEmpty {
            showQuiz(with: quizes.first!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // append initial messages into the current messages
        currentMessages += initialMessages
    }

    
}
