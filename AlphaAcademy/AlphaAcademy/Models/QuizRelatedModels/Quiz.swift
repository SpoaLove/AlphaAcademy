//
//  Quiz.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2018/3/1.
//  Copyright © 2018年 Tengoku no Spoa. All rights reserved.
//

import JSQMessagesViewController.JSQMessage

/**
 * Quiz Protocol
 * This protocol defines all the necessary variables that a quiz have
 */
protocol Quiz {
    var quizStyle:QuizStyle { get }
    var questionText:String { get }
    var correctAnswer:String { get }
    var messageCorrect:JSQMessage { get }
    var messageIncorrect:JSQMessage { get }
}
