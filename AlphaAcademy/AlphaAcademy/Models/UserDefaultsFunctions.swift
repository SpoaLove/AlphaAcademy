//
//  UserDefaultsFunctions.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2018/2/28.
//  Copyright © 2018年 Tengoku no Spoa. All rights reserved.
//

import Foundation

/**
 * This class provides all the function that is used for userDefaults, both get and set functions
 */
class Defaults {
    
    /**
     * This function sets the userdefaults userName to the String passed in
     *
     * @param name a String that will be set as the userName
     */
    func setName(with name:String) {
        UserDefaults.standard.set(name, forKey: "userName")
    }
    
    /**
     * This function returns the String of the User name
     *
     * @return a String of the User Defaut of the username, if the username cannot be fetched from the UserDefauts "You"
     */
    func getName()->String{
        if let username = UserDefaults.standard.object(forKey: "userName") as? String {
            return username
        }else{
            return "You"
        }
    }
    
    /**
     * This function sets the userdefaults userlevel to the interger passed in
     *
     * @param level an interger that is <=9 that will be set as the userLevel
     */
    func setLevel(to level:Int){
        if level > 9 || level < 0 {
            print("Error: The input number is expected to be >0 && <=9, but found \(level)")
            UserDefaults.standard.set(0, forKey: "userLevel")
        } else {
            UserDefaults.standard.set(level, forKey: "userLevel")
        }
    }
    
    /**
     * This function returns the Int of the Level
     *
     * @return the userLevel Int from the UserDefaut, if the userLevel cannot be fetched 0 will be returned instead
     */
    func getLevel()->Int{
        if let userLevel = UserDefaults.standard.object(forKey: "userLevel") as? Int {
            return userLevel
        }else{
            return 0
        }
    }
    
    /**
     * This function sets the userdefaults selectedBeret to the interger passed in
     *
     * @param beretNumber an interger
     */
    func setBeretNumber(with beretNumber:Int){
        UserDefaults.standard.set(beretNumber, forKey: "selectedBeret")
    }
    
    /**
     * This function returns the Int of the chosen beret's id number
     *
     * @return the selectedBeret Int from the UserDefaut, if the selectedBeret cannot be fetched 0 will be returned instead
     */
    func getBeretNumber() -> Int {
        if let selectedBeret = UserDefaults.standard.object(forKey: "selectedBeret") as? Int {
            return selectedBeret
        }else{
            return 0
        }
    }
}
