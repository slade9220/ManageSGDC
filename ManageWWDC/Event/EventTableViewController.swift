//
//  EventTableViewController.swift
//  ManageWWDC
//
//  Created by Gennaro Amura on 04/06/18.
//  Copyright © 2018 Gennaro Amura. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    
    var events: [Event] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let all = loadEvents()
        for event in all{
            if(event.tag != "Train"){
                events.append(event)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        events = []
        let all = loadEvents()
        for event in all{
            if(event.tag != "Train"){
                events.append(event)
            }
        }
        tableView.reloadData()
    }



    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! EventTableViewCell
        
        cell.title.text = events[indexPath.row].name
        var endingMinute = "00"
        var startingMinute = "00"
        if(events[indexPath.row].endingMinute != 0){
            endingMinute = "\(events[indexPath.row].endingMinute)"
        }
        if(events[indexPath.row].startingMinute != 0){
            startingMinute = "\(events[indexPath.row].startingMinute)"
        }
        cell.subTitle.text = "\(events[indexPath.row].location) | \(events[indexPath.row].startingHour):\(startingMinute)- \(events[indexPath.row].endingHour):\(endingMinute)"
        

        return cell
    }
    
 

   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            events.remove(at: indexPath.row)
            let alert = UIAlertController(title: "Delete Event", message: "Are you sure you want to permanently delete?", preferredStyle: .actionSheet)
            
            let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {
                action in
                deleteEvent(event: self.events[indexPath.row]) { (error) in
                    guard let err = error else { return }
                    if(err) {
                        self.events.remove(at: indexPath.row)
                        DispatchQueue.main.async {
                            tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                        
                    }
                    
                }
            }))
            alert.addAction(CancelAction)
            alert.popoverPresentationController?.sourceRect = CGRect(x: 1.0, y: 1.0, width: self.view.bounds.size.width / 2.0, height: self.view.bounds.size.height / 2.0)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
   
   

}
