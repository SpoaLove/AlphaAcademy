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


/**
 * The Lessons class is a sub-class of JSQMessagesViewController
 * this class provides the nessesary templates for the lessons to inherit from
 */
class Lessons: JSQMessagesViewController {
    
    /**
     * Defines Users
     */
    let achan = ChatUser(id: "1", name: "A-Chan")
    var user = ChatUser(id: "2", name: "You")
    let console = ChatUser(id: "3", name: "Console")
    let code = ChatUser(id: "4", name: "Code")

    /**
     * all possible user avatar images
     */
    var userImages = [
        #imageLiteral(resourceName: "userWhiteBeret"),
        #imageLiteral(resourceName: "userPinkBeret"),
        #imageLiteral(resourceName: "userRedBeret"),
        #imageLiteral(resourceName: "userOrangeBeret"),
        #imageLiteral(resourceName: "userYellowBeret"),
        #imageLiteral(resourceName: "userLimeBeret"),
        #imageLiteral(resourceName: "userGreenBeret"),
        #imageLiteral(resourceName: "userBlueBeret"),
        #imageLiteral(resourceName: "userBlackBeret")
    ]
    
    /**
     * Defines Conditions
     */
    var atEndOfRoute = false
    var choosenRouteName:String = ""
    var finishedLesson = false
    var userCompleteQuiz = false
    var userHaveRecievedBeret = false


    /**
     * Defines the Current User
     */
    var name:String {
        return user.name
    }
    var currentUser: ChatUser {
        return user
    }
    
    /**
     * Declare all the Messages
     */
    var messages = [JSQMessage]()
    
    /**
     * Messages Variables:
     * 'currentMessages': queue of messages
     * 'messagesCount'  : index of the current message
     */
    var messageQueue = [JSQMessage]()
    var messagesCount=0
    
    /**
     * Initializing Defaults Class
     */
    let defaults = Defaults()

    /**
     * Defines the initial Messages, the first array of messages that will be put on the queue
     */
    let tipMessage:[JSQMessage] = [
        JSQMessage(senderId: "3", displayName: "Tip!", text: "please type in 'next' or 'n' and press the send button to start or continue the conversation!")
    ]
    
    /**
     * Tip messages
     */
    let continueTip = JSQMessage(senderId: "3", displayName: "Tip!", text: "please type 'next' or 'n' to continue")
    let endTip = JSQMessage(senderId: "3", displayName: "Tip!", text: "Please tap the button on the bottom left to quit!")
    
    /**
     * Defines the avatar size
     */
    let avatarSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height: kJSQMessagesCollectionViewAvatarSizeDefault)
    
    
    /**
     * This funtion returns the quit seque identifier
     *
     * @return a string of the quit sequre identifier
     */
    func quitSegueIdentifier()->String{
        return "quit"
    }
    
   /**
     * This function quits the lesson to home if the user have reached the end of the script
     */
    override func didPressAccessoryButton(_ sender: UIButton!) {
        if atEndOfRoute {
            performSegue(withIdentifier: quitSegueIdentifier(), sender: self)
            return
        }else{
            quitLesson()
        }
    }
    
    /**
     * This function asks the user to confrim using an alert before quitting the lesson
     */
    func quitLesson(){
        let selector = UIAlertController(title: "Quit", message: "Do You Really Want to Quit? Progress will be lost!", preferredStyle: .actionSheet)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.performSegue(withIdentifier: self.quitSegueIdentifier(), sender: self)
        })
        let no = UIAlertAction(title: "no", style: .default, handler: {
            (action:UIAlertAction) -> () in
        })
        selector.addAction(yes)
        selector.addAction(no)
        self.present(selector, animated: true, completion: nil)
    }
    
    /**
     * This array contains the list of commands that is valid in the chapter
     * Override this command List to add new commands to the chapter
     * Key is the keyword of command
     * Value is the desctiption of the function of the command
     */
    var commandList:[String:String] = [
        "Help":"Shows this help message",
        "H":"Shows this help message",
        "?":"Shows this help message",
        "Next":"Continue the Lesson",
        "N":"Continue the Lesson",
        "Quiz":"Start the Quiz of the Chapter",
        "Q":"Start the Quiz of the Chapter"
    ]
    
    /**
     * This function automaticlly generates a help message for all the valid commands
     */
    func help(){
        var helpMessage = """
                Help!
                Command: Function
                """
        for command in commandList {
            helpMessage += "\n\(command.key): \(command.value)"
        }
        appendMessage(text: helpMessage, senderId: "3", senderDisplayName: "Help!")
    }
    
    /**
     * This function appends messages from the queue if the queue is not empty
     * Overide this message to add flags or events during the conversation
     */
    func next(){
        print("Next is sent")
        if messagesCount<messageQueue.count {
            messages.append(messageQueue[messagesCount])
            messagesCount += 1
            
        // reach end of the Route
        }else if messagesCount==messageQueue.count && messagesCount != 0{
            if finishedLesson{
                appendMessageWithJSQMessage(message: endTip)
                atEndOfRoute = true
            }
        }else{
            appendMessageWithJSQMessage(message: continueTip)
        }
    }
    
    
    /**
     * This function parse the quizStyle of the quiz and call corresponding functions to display the quiz
     *
     * @param quiz a Quiz under the quiz protocal that will be parsed and displayed
     */
    func showQuiz(with quiz:Quiz){
        switch quiz.quizStyle {
        case .MultipleChoice :
            showMultipleChoiceQuiz(with: quiz as! MultipleChoiceQuiz)
        case .YesOrNo:
            showYesOrNoQuiz(with: quiz as! YesOrNoQuiz)
        case .UserInputQuiz:
            showUserInputQuiz(with: quiz as! UserInputQuiz)
        case .TrueOrFalse:
            showTrueOrFalseQuiz(with: quiz as! TrueOrFalseQuiz)
        }
    }
    
    /**
     * This function checks if the user have answered the quiz correctlly
     * If the user answered correctlly the message correct will be appended
     * Else the message incorrect will be appended
     */
    func checkAns(with answer:String, quiz:Quiz){
        self.appendMessage(text: answer, senderId: user.id, senderDisplayName: user.name)
        if answer == quiz.correctAnswer {
            self.appendMessageWithJSQMessage(message: quiz.messageCorrect)
            correctResponse()
        } else {
            self.appendMessageWithJSQMessage(message: quiz.messageIncorrect)
        }
    }
    
    /**
     * This function shows a MultipleChoiceQuiz
     *
     * @param quiz a MultipleChoiceQuize that wull be displayed
     */
    func showMultipleChoiceQuiz(with quiz:MultipleChoiceQuiz) {
        
        let selector = UIAlertController(title: "QUIZ!", message: quiz.questionText, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: quiz.choice1, style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.checkAns(with: quiz.choice1, quiz: quiz)
            selector.dismiss(animated: true, completion: nil)
        })
        let action2 = UIAlertAction(title: quiz.choice2, style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.checkAns(with: quiz.choice2, quiz: quiz)
            selector.dismiss(animated: true, completion: nil)
        })
        let action3 = UIAlertAction(title: quiz.choice3, style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.checkAns(with: quiz.choice3, quiz: quiz)
            selector.dismiss(animated: true, completion: nil)
        })
        selector.addAction(action1)
        selector.addAction(action2)
        selector.addAction(action3)
        self.present(selector, animated: true, completion:nil)
    }
    
    
    /**
     * This function shows a Yes or No Quiz
     *
     * @param quiz a YesOrNoQuiz that wull be displayed
     */
    func showYesOrNoQuiz(with quiz:YesOrNoQuiz) {
        let selector = UIAlertController(title: "QUIZ!", message: quiz.questionText, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Yes", style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.checkAns(with: "Yes", quiz: quiz)
            selector.dismiss(animated: true, completion: nil)
        })
        let action2 = UIAlertAction(title: "No", style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.checkAns(with: "No", quiz: quiz)
            selector.dismiss(animated: true, completion: nil)
        })
        selector.addAction(action1)
        selector.addAction(action2)
        self.present(selector, animated: true, completion:nil)
    }
    
    
    /**
     * This function shows a User Input Quiz
     *
     * @param quiz a UserInputQuiz that wull be displayed
     */
    func showUserInputQuiz(with quiz:UserInputQuiz) {
        let alert = UIAlertController(title: "QUIZ!", message: quiz.questionText, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Confrim", style: .default, handler:{ [weak alert] (_) in
            let textField = alert?.textFields![0].text!
            self.checkAns(with: textField!, quiz: quiz)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    /**
     * This function shows a True or False Quiz
     *
     * @param quiz a TrueOrFalseQuiz that wull be displayed
     */
    func showTrueOrFalseQuiz(with quiz:TrueOrFalseQuiz) {
        let selector = UIAlertController(title: "QUIZ!", message: quiz.questionText, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "True", style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.checkAns(with: "True", quiz: quiz)
            selector.dismiss(animated: true, completion: nil)
        })
        let action2 = UIAlertAction(title: "False", style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.checkAns(with: "False", quiz: quiz)
            selector.dismiss(animated: true, completion: nil)
        })
        selector.addAction(action1)
        selector.addAction(action2)
        self.present(selector, animated: true, completion:nil)
    }
    
    
    /**
     * This function is called when the quiz is answered correctly
     */
    func correctResponse(){
        // need to be implemented in sub classes
    }
    
    
    
    /**
     * This function shows the quizes of the chapter to the user
     * override this function to customize the quiz!
     */
    func quiz(){
        printMsg(text: "Quiz Is not Implemented")
    }
    
    /**
     * This function parse through the user input for commands
     * if the command is valid then the command will be executed
     * if the command is invalid a tips message will be appended
     *
     * @param message the user inputed string
     */
    func reply(with message:String)->(){
        for command in commandList{
            if message.caseInsensitiveCompare(command.key)==ComparisonResult.orderedSame {
                return executeCommand(with:command.key)
            }
        }
        return appendMessageWithJSQMessage(message: continueTip)
    }
    
    
    /**
     * This function execute the user inputted command
     * @param the user inputed command String
     */
    func executeCommand(with command:String)->(){
        switch command {
        case "Help","H","?":
            help()
        case "Next","N":
            next()
        case "Video","V":
            playVideo(with: "TeachingVideos/AGintro", of: "mp4")
        case "Quiz","Q":
            quiz()
        default:
            help()
        }
        finishSendingMessage()
    }
    
    /**
     * This function checks if the lesson reaches the end
     * if the lesson does reach the end the function returns
     * else the function pass the sented message to the 'reply' function
     */
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        guard !atEndOfRoute else{
            atEndOfRoute = false
            return
        }
        reply(with: text)
    }
    
    
    // Collection View Stuff
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
            playVideo(with: "TeachingVideos/AGintro", of: "mp4")
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
        
        let userAvatar = getBeret()
        
        switch message.senderId {
        case "1":
            // Sender is A-Chan
            return avatarImageFactory.avatarImage(with: UIImage(named: "Title.png"), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        case "2":
            // Sender is Yourself
            return avatarImageFactory.avatarImage(with: userAvatar, diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
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
    /**
     * This function appends the input [JSQMessage] into the messages queue
     *
     * @param chapter an array of JSQMessages that will be added into the messages queue
     */
    func setChapter(chapter:[JSQMessage]){
        messageQueue += chapter
    }
    
    /**
     * This function append a message to the collection view wirh
     *
     * @param text the text content of the message
     * @param senderId the user identifier of the selected sender
     * @param senderDisplayName the name of the sender
     */
    func appendMessage(text: String!, senderId: String!, senderDisplayName: String!){
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        messages.append(message!)
        finishSendingMessage()
    }
    
    /**
     * This function append a messgae to the collection view using a JSQMessage
     *
     * @param message the JSQMessage that will be appended
     */
    func appendMessageWithJSQMessage(message: JSQMessage!){
        messages.append(message!)
        finishSendingMessage()
    }
    
    /**
     * This function prints a debug message into the messages
     *
     * @param text the String that will be printed
     */
    func printMsg(text:String){
        appendMessage(text: text, senderId: "3", senderDisplayName: "DEBUG")
    }

    /**
     * This function plays a video from a given path
     *
     * @param videoPath the path of the video
     * @param videoType the type of the video
     * @sample playVideo(with: "TeachingVideos/AGintro", of: "mp4")
     */
    func playVideo(with videoPath:String, of videoType:String) {
        guard let path = Bundle.main.path(forResource: videoPath, ofType:videoType) else {
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
    
    
    /**
     * This function shows user a choice betweem two routes that can be appended into the queue
     *
     * @param title the title of the route choice alert
     * @param message the message of the route choice alert
     * @param action1title the button title of the first route
     * @param action2title the button title of the second route
     * @param route1 an array of JSQMessage for the first route
     * @param route2 an array of JSQMessage for the second route
     */
    func selectRoute(title:String, message:String, action1title:String, action2title:String, route1:[JSQMessage], route2:[JSQMessage]){
        let selector = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: action1title, style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.additionalFunctionForRoute1()
            self.choosenRouteName = action1title
            self.appendMessage(text: action1title, senderId: "2", senderDisplayName: self.defaults.getName())
            self.setChapter(chapter: route1)
        })
        let action2 = UIAlertAction(title: action2title, style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.additionalFunctionForRoute2()
            self.choosenRouteName = action2title
            self.appendMessage(text: action2title, senderId: "2", senderDisplayName: self.defaults.getName())
            self.setChapter(chapter: route2)
        })
        selector.addAction(action1)
        selector.addAction(action2)
        self.present(selector, animated: true, completion: nil)
    }
    
    /**
     * Additional functions that takes no arguments that can be called during a route selection
     */
    func additionalFunctionForRoute1(){}
    func additionalFunctionForRoute2(){}
    
    
    /**
     * This function returns the user's chosen beret's image
     *
     * @return the corresponding UIImage of the beret id number
     */
    func getBeret() -> UIImage {
        return userImages[defaults.getBeretNumber()]
    }
    
    
    /**
     * This function prompts a debug alert that shows that the Chapter is under development.
     * This function should not be used in the actual release
     */
    func unimplemented(){
        let selector = UIAlertController(title: "Alert!", message: "This Chapter is currentlly in Development!", preferredStyle: .actionSheet)
        let quit = UIAlertAction(title: "Quit", style: .default, handler: {
            (action:UIAlertAction) -> () in
            self.performSegue(withIdentifier: self.quitSegueIdentifier(), sender: self)
        })
        selector.addAction(quit)
        self.present(selector, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // tell JSQMessageViewController who is the current user
        senderId = currentUser.id
        senderDisplayName = currentUser.name
        
        // append initial messages
        user.name = defaults.getName()
        messages += tipMessage
    }
    
    
    /*
     * This function allows the return button on the keboard to act just like the send button on the right!
     */
    override func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            didPressSend(nil, withMessageText: textView.text, senderId: user.id, senderDisplayName: user.name, date: nil)
            return false
        }
        return true
    }
    
}
