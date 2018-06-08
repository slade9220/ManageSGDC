//
//  AddTrainViewController.swift
//  ManageWWDC
//
//  Created by Gennaro Amura on 04/06/18.
//  Copyright © 2018 Gennaro Amura. All rights reserved.
//

import UIKit

class AddTrainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var meetH: UITextField!
    @IBOutlet weak var trainType: UIPickerView!
    @IBOutlet weak var meetM: UITextField!
    @IBOutlet weak var depHour: UITextField!
    @IBOutlet weak var depMinute: UITextField!
    var trainSelected = "Select"
    
    
    
    let trainOption = ["Select","Pozzuoli","Campi","Salerno"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trainType.dataSource = self
        trainType.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        
        meetH.text?.removeAll()
        meetM.text?.removeAll()
        depHour.text?.removeAll()
        depMinute.text?.removeAll()
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "train" {
            let controller = segue.destination as! SaveTrainViewController
            controller.event = sender as! Event
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView.tag == 0){
            return trainOption.count
        }else{
            return trainOption.count
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return trainOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView.tag == 0) {
            trainSelected = trainOption[row]
        }
    }
    
    
    
    @IBAction func saveTrain(_ sender: Any) {
        
        if(meetH.text! == "" || meetM.text! == "" || depHour.text! == "" || depMinute.text! == "") {
            
        } else {
            if(trainSelected != "Select") {
                
                var day = 0
                switch trainSelected{
                case "Pozzuli":
                    day = 0
                case "Campi":
                    day = 1
                case "Salerno":
                    day = 2
                default:
                    day = 0
                }
                
                let event = Event(id: 0, name: trainSelected, tag: "Train", day: day, startingHour: Int(meetH.text!)!, startingMinute: Int(meetM.text!)!, endingHour: Int(depHour.text!)!, endingMinute: Int(depMinute.text!)!, location: "WelcomeDesk", calendarLink: "link", description: "noDescription")
                    performSegue(withIdentifier: "train", sender: event)
  
            }
        }
        
    }
    

}
