//
//  MultipleChoiceQuiz.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2018/2/16.
//  Copyright © 2018年 Tengoku no Spoa. All rights reserved.
//

import JSQMessagesViewController.JSQMessage

/**
 * Multiple Choice Quiz Structure
 *
 * @property quizStyle defines the quizStyle
 * @property questionText the String of the question
 * @property choice1 the String of first given choice of answer
 * @property choice2 the String of second given choice of answer
 * @property choice3 the String of thrid given choice of answer
 * @property correctAnswer the String of correct choice answer text
 * @property messageCorrect a 'JSQMessage' as a reply of the quiz when the user answered correctly
 * @property messageIncorrect a 'JSQMessage' as a reply of the quiz when the user answered incorrectly
 */
struct MultipleChoiceQuiz: Quiz{
    let quizStyle: QuizStyle = QuizStyle.MultipleChoice
    let questionText:String
    let choice1:String
    let choice2:String
    let choice3:String
    let correctAnswer:String
    let messageCorrect:JSQMessage
    let messageIncorrect:JSQMessage
}
