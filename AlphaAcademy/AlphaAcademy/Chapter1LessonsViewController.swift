//
//  Chapter1LessonsViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2018/1/1.
//  Copyright © 2018年 Tengoku no Spoa. All rights reserved.
//

import UIKit
import AVKit
import JSQMessagesViewController

class Chapter1LessonsViewController: Lessons {

    let initialMessages:[JSQMessage] = [
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Welcome to the first chapter of Alpha Academy"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "In this chapter you will learn about the fundementals of programming in kotlin"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "To write a kotlin program you have to first write the 'main function'"),
        JSQMessage(senderId: "4", displayName: "Code", text: """
        fun main(args: Array<String>){
            // some Codes
        }
        """),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "The main function of a propgram is the start of the program, when a program is runned the main function will be called first"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "Let's add some code into the main function!"),
        JSQMessage(senderId: "4", displayName: "Code", text: """
        fun main(args: Array<String>) {
            print("Hello, World!")
        }
        """),
        JSQMessage(senderId: "3", displayName: "Console", text: "Hello, World!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "The print() function is a function that will output the 'arguments' that was passed in!"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "In this case the argument passed in is a 'String': \"Hello,World\""),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: "'String' one of the data types that a kotlin program can deal with, Strings is used store words and sentences, or can be simply define as a collection of characters"),
        JSQMessage(senderId: "1", displayName: "A-Chan", text: """
        Other than 'String's there is other data types such as:
        'Int' which means intergers, used to store numbers without decimals,

        'Double' which means double precision, used to store numbers with decimals,
        'Boolean' which contains 2 members 'True' or 'False', used for storing conditions
        """),
        JSQMessage(senderId: ',', displayName: <#T##String!#>, text: <#T##String!#>)
        //JSQMessage(senderId: <#T##String!#>, displayName: <#T##String!#>, text: <#T##String!#>)

        
    
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMessages += initialMessages
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
