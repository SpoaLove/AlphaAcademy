//
//  BeretsCollectionViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/8/23.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit

class BeretsCollectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        beretLabel.text = pickerData[row]
        beretImageView.image = beretArray[row]
        currentBeretNumber = row
        self.view.endEditing(true)
    }


    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var beretImageView: UIImageView!
    @IBOutlet weak var beretLabel: UILabel!
    @IBOutlet weak var beretPickerView: UIPickerView!
    
    var currentBeretNumber:Int = 0
    
    var pickerData = [
        "White Beret",
        "Pink Beret",
        "Red Beret",
        "Orange Beret",
        "Yellow Beret",
        "Lime Beret",
        "Green Beret",
        "Blue Beret",
        "Black Beret"
    ]
    
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
    
    
    override func viewDidLoad() {
        pickerData.removeLast(9-getLevel())
        self.beretPickerView.delegate = self
        self.beretPickerView.dataSource = self
        super.viewDidLoad()
    }

    
    @IBAction func quitButtonIsTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "quitCollection", sender: self)
    }



    @IBAction func wearBeretButtonIsPressed(_ sender: Any) {
        UserDefaults.standard.set(currentBeretNumber, forKey: "selectedBeret")
    }
    
    func getLevel()->Int{
        if let userLevel = UserDefaults.standard.object(forKey: "userLevel") as? Int {
            return userLevel
        }else{
            return 0
        }
    }

}
