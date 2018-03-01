//
//  UserInputQuiz.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2018/3/1.
//  Copyright © 2018年 Tengoku no Spoa. All rights reserved.
//

import JSQMessagesViewController.JSQMessage

/**
 * UserInputQuiz Structure
 *
 * @property quizStyle  defines the quizStyle
 * @property questionText the String of the question
 * @property correctAnswer the String of correct choice answer text
 * @property messageCorrect a 'JSQMessage' as a reply of the quiz when the user answered correctly
 * @property messageIncorrect a 'JSQMessage' as a reply of the quiz when the user answered incorrectly
 */
struct UserInputQuiz: Quiz{
    let quizStyle: QuizStyle = QuizStyle.UserInputQuiz
    let questionText:String
    let correctAnswer:String
    let messageCorrect:JSQMessage
    let messageIncorrect:JSQMessage
}

