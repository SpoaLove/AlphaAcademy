//
//  Chapter7LessonViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2018/2/25.
//  Copyright © 2018年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import JSQMessagesViewController


class Chapter7LessonViewController: Lessons {

    // Chapter 7 is currentlly used as a Debug Lesson
    
    let initialMessage = JSQMessage(senderId: "3", displayName: "Debug", text: "This Chapter is a test debug chapter!")
    
    var quizes:[Quiz] = [
        
        // example multiple choice quiz
        MultipleChoiceQuiz(
            questionText: "The Answer is choice 2",
            choice1: "1",
            choice2: "2",
            choice3: "3",
            correctAnswer: "2",
            messageCorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "2 is the Answer"),
            messageIncorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "incorrect answer")
        ),
        
        // example yes or no quiz
        YesOrNoQuiz(
        questionText: "Answer Is No",
        correctAnswer: "No",
        messageCorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "No is the Answer"),
        messageIncorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "Yes is not the Answer")
        ),
        
        // example user input quiz
        UserInputQuiz(
        questionText: "Answer is 42",
        correctAnswer: "42",
        messageCorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "42 is the Answer"),
        messageIncorrect: JSQMessage(senderId: "1", displayName: "A-Chan", text: "Answer Incorrect")
        )
        
    ]
    
    override func quiz() {
        if !quizes.isEmpty {
            showQuiz(with: quizes.first!)
        }
    }
    
    override func correctResponse() {
        quizes.removeFirst()
        if quizes.count >= 2 {
            appendMessage(text: "\(quizes.count) questons left!", senderId: "3", senderDisplayName: "QUIZ!")
        } else if quizes.count == 1 {
            appendMessage(text: "1 queston left! Type 'Q' or Quiz to Continue!", senderId: "3", senderDisplayName: "QUIZ!")
        } else {
            appendMessage(text: "All Questions have been answered correctlly!", senderId: "3", senderDisplayName: "QUIZ!")
            messagesCount = currentMessages.count
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMessages.append(initialMessage!)
        
        // Do any additional setup after loading the view.
    }

}
