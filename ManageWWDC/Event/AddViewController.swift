//
//  ViewController.swift
//  ManageWWDC
//
//  Created by Gennaro Amura on 03/06/18.
//  Copyright © 2018 Gennaro Amura. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var savePressed: UIBarButtonItem!
    
    
    @IBOutlet weak var tag: UIPickerView!
    @IBOutlet weak var day: UIPickerView!
    @IBOutlet weak var location: UIPickerView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var startingHourField: UITextField!
    @IBOutlet weak var startingMinuteField: UITextField!
    @IBOutlet weak var endingHourField: UITextField!
    @IBOutlet weak var endingMinuteField: UITextField!
    
    
    var tagOptions: [String] = []
    var dayOptions: [Int] = []
    var locatiOndayoptions: [String] = []
    var dayValue: Int = 5
    var tagValue: String = ""
    var locationValue: String = ""
    var nameCheck = "Gennaro"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tag.delegate = self
        tag.dataSource = self
        day.delegate = self
        day.dataSource = self
        location.delegate = self
        location.dataSource = self
        
        tagOptions = ["Select","Wwdc Event","Academy"]
        dayOptions = [-4,0,1,2,3,4]
        locatiOndayoptions = ["Select","Main","Collab1","Lab2","Collab2","Lab2+Collab2","Lab3","Lab4","Collab4","Lab4+Collab4","Kitchen"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        nameField.text?.removeAll()
        startingMinuteField.text?.removeAll()
        startingHourField.text?.removeAll()
        endingMinuteField.text?.removeAll()
        endingHourField.text?.removeAll()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "event" {
            let controller = segue.destination as! SaveViewController
            controller.event = sender as! Event
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return tagOptions.count
        case 1:
            return dayOptions.count
        case 2:
            return locatiOndayoptions.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return tagOptions[row]
        case 1:
            let day = dayOptions[row] + 4
            return "\(day) June"
        case 2:
            return locatiOndayoptions[row]
        default:
            return "NIL"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            tagValue = tagOptions[row]
        case 1:
            dayValue = dayOptions[row]
        case 2:
            locationValue = locatiOndayoptions[row]
        default:
            return
        }
    }
    
   
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if(nameField.text == "" || startingHourField.text == "" || startingMinuteField.text == "" || endingHourField.text == "" || endingMinuteField.text == "" ) {
            return
        } else {
            if(tagValue == "Select" || dayValue == -1 || locationValue == "Select"){
                return
            } else{
                let event = Event(id: 0, name: nameField.text!, tag: tagValue, day: dayValue, startingHour: Int(startingHourField.text!)!, startingMinute: Int(startingMinuteField.text!)!, endingHour: Int(endingHourField.text!)!, endingMinute: Int(endingMinuteField.text!)!, location: locationValue, calendarLink: "Gennaro", description: "noDescription" )
                performSegue(withIdentifier: "event", sender: event)
            }
        }
        
    }
    
  

}

