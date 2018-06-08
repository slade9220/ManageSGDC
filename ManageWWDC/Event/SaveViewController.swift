//
//  SabeViewController.swift
//  ManageWWDC
//
//  Created by Gennaro Amura on 03/06/18.
//  Copyright © 2018 Gennaro Amura. All rights reserved.
//

import UIKit

class SaveViewController: UIViewController {
    
    var event = Event()

    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    
    var eventToModify = Event()
    
    var labelText: String = "Loading.."{
        willSet(newTotalSteps) {
            DispatchQueue.main.async {
                self.label.text = newTotalSteps
                self.activity.stopAnimating()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = labelText
        activity.startAnimating()
        print(event)
        sendEvent(event: event) { (error) in
            guard let err = error else { return }
            if(err) {
                self.labelText = "SENT !"
            } else {
                self.labelText = "FAIL !"
            }

        }
        
    }


}
