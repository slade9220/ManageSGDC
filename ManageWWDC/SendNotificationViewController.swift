//
//  SendNotificationViewController.swift
//  ManageWWDC
//
//  Created by Gennaro Amura on 06/06/2018.
//  Copyright © 2018 Gennaro Amura. All rights reserved.
//

import UIKit

class SendNotificationViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func sendNotification(_ sender: Any) {
        if(nameField.text == "") {
            
        } else {
            
            let newS = New(id: 0, name: nameField.text!, text: "Testo", data: "data")
            sendNot(new: newS) { (bool) in
                if(bool!) {
                    DispatchQueue.main.async {
                        self.label.isHidden = false
                        self.label.text = "SENT NOT!"
                    }
                }
            }
            
        }
        
        
    }
}
