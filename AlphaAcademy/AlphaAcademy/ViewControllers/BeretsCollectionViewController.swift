//
//  BeretsCollectionViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/8/23.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit

class BeretsCollectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /**
     * Defines UI Components
     */
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var beretImageView: UIImageView!
    @IBOutlet weak var beretLabel: UILabel!
    @IBOutlet weak var beretPickerView: UIPickerView!
    
    /**
     * The current selected beret identifying number
     */
    var currentBeretNumber:Int = 0
    
    /**
     * This is an array of the picker title data source
     */
    var pickerData = [
        "White Beret",
        "Pink Beret",
        "Red Beret",
        "Orange Beret",
        "Yellow Beret",
        "Lime Beret",
        "Green Beret",
        "Blue Beret",
    ]
    
    /**
     * This is an array of different color of berets
     */
    let beretArray = [
        #imageLiteral(resourceName: "0White"),
        #imageLiteral(resourceName: "1Pink"),
        #imageLiteral(resourceName: "2Red"),
        #imageLiteral(resourceName: "3Orange"),
        #imageLiteral(resourceName: "4Yellow"),
        #imageLiteral(resourceName: "5Lime"),
        #imageLiteral(resourceName: "6Green"),
        #imageLiteral(resourceName: "7Blue"),
        #imageLiteral(resourceName: "8Black")
    ]
    
    /**
     * Initiate the defaults class
     */
    var defaults = Defaults()
    
    
    /**
     * This function defines the number of components in the pickerView
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /**
     * This function returns the number of pickerDatas
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    /**
     * This function returns the pickerData of the each row
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    /**
     * This function triggers the updateBeret function whenever the pickerView have been moved
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        updateBeret(with: row)
        self.view.endEditing(true)
    }
    
    /**
     * This function updates the beretLabel and beretImageView according to the given beretNumber
     *
     * @param beretNumber an Interger identifiying user's chosen beret
     */
    func updateBeret(with beretNumber:Int){
        if beretNumber > 8 {
            beretLabel.text = pickerData[7]
        } else {
            beretLabel.text = pickerData[beretNumber]
        }
        beretImageView.image = beretArray[beretNumber]
        currentBeretNumber = beretNumber
    }
    
    override func viewDidLoad() {
        
        var removeAmount = 8-defaults.getLevel()
        
        // append black beret into the picker Data if userlevel is higher than 8, else remove the last entry for each userLevel lower than 8
        if defaults.getLevel()>=8 || defaults.getBeretNumber()==8{
            pickerData += ["Black Beret"]
            removeAmount = 0
        } else if defaults.getLevel() == 0 {
            pickerData = ["White Beret"]
        } else {
            pickerData.removeLast(removeAmount)
        }
        
        // defining pickerView's delegate and datasource
        self.beretPickerView.delegate = self
        self.beretPickerView.dataSource = self
        
        // setting default currentBeretNumber and update the UI when the view is first loaded
        self.currentBeretNumber = defaults.getBeretNumber()
        super.viewDidLoad()
    }
    
    /**
     * This function brings the user back to the chapters selection page
     */
    @IBAction func quitButtonIsTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "quitCollection", sender: self)
    }
    
    /**
     * This function updates the userdefault's beretNumber using the currentBeretNumber
     */
    @IBAction func wearBeretButtonIsPressed(_ sender: Any) {
        defaults.setBeretNumber(with: currentBeretNumber)
    }


}
