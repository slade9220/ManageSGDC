//
//  Event.swift
//  ManageWWDC
//
//  Created by Gennaro Amura on 03/06/18.
//  Copyright © 2018 Gennaro Amura. All rights reserved.
//

import Foundation

import Foundation
import UIKit


struct Event: Codable {
    
    var id: Int
    var name: String
    var tag: String
    var day: Int
    var startingHour: Int
    var startingMinute: Int
    var endingHour: Int
    var endingMinute: Int
    var location: String
    var calendarLink: String
    var description: String
    
    init(id: Int, name: String, tag: String, day: Int, startingHour: Int, startingMinute: Int, endingHour:Int, endingMinute:Int, location:String, calendarLink: String, description: String) {
        self.id = id
        self.name = name
        self.tag = tag
        self.day = day
        self.startingHour = startingHour
        self.startingMinute = startingMinute
        self.endingHour = endingHour
        self.endingMinute = endingMinute
        self.location = location
        self.calendarLink = calendarLink
        self.description = description
    }

    
    init() {
        self.id = 0
        self.name = ""
        self.tag = ""
        self.day = 0
        self.startingHour = 0
        self.startingMinute = 0
        self.endingHour = 0
        self.endingMinute = 0
        self.location = ""
        self.calendarLink = ""
        self.description = ""
    }
    
}

func loadEvents()->[Event] {
    var events : [Event] = []
    let jsonUrl = "https://.../query/getEvents.php"
    
    guard let url = URL(string: jsonUrl) else { return events }
    let request: URLRequest = URLRequest(url: url)
    let session = URLSession.shared
    
    let semaphore = DispatchSemaphore(value: 0)
    session.dataTask(with: request) { (data, response, err) in
        guard let data = data else { return }
        
        do {
            events = try JSONDecoder().decode([Event].self, from: data)
            
        } catch let jsonErr {
            print("Error: ",jsonErr)
        }
        
        semaphore.signal()
        }.resume()
    
    semaphore.wait()
    return events
}

func sendEvent(event: Event, completion:((Bool?) -> Void)?) {
    let postUrl = "https:/../query/createEvent.php"
    guard let url = URL(string: postUrl ) else { fatalError("Could not create URL") }
    
    // Specify this request as being a POST method
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // Make sure that we include headers specifying that our request's HTTP body
    // will be JSON encoded
    var headers = request.allHTTPHeaderFields ?? [:]
    headers["Content-Type"] = "application/json"
    request.allHTTPHeaderFields = headers
    
    // Now let's encode out Post struct into JSON data...
    let encoder = JSONEncoder()
    do {
        let jsonData = try encoder.encode(event)
        request.httpBody = jsonData
        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
    } catch {
        completion?(false)
    }
    
    // Create and run a URLSession data task with our JSON encoded POST request
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
        guard responseError == nil else {
            completion?(false)
            return
        }
        
        // APIs usually respond with the data you just sent in your POST request
        if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
            print(request)
            print("response: ", utf8Representation)
            completion?(true)
        } else {
            print("no readable data received in response")
        }
    }
    task.resume()
}

func deleteEvent(event: Event, completion:((Bool?) -> Void)?) {
    let postUrl = "https://../query/deleteEvent.php"
    guard let url = URL(string: postUrl ) else { fatalError("Could not create URL") }
    
    // Specify this request as being a POST method
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // Make sure that we include headers specifying that our request's HTTP body
    // will be JSON encoded
    var headers = request.allHTTPHeaderFields ?? [:]
    headers["Content-Type"] = "application/json"
    request.allHTTPHeaderFields = headers
    
    // Now let's encode out Post struct into JSON data...
    let encoder = JSONEncoder()
    do {
        let jsonData = try encoder.encode(event)
        request.httpBody = jsonData
        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
    } catch {
        completion?(false)
    }
    
    // Create and run a URLSession data task with our JSON encoded POST request
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
        guard responseError == nil else {
            completion?(false)
            return
        }
        
        // APIs usually respond with the data you just sent in your POST request
        if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
            print(request)
            print("response: ", utf8Representation)
            completion?(true)
        } else {
            print("no readable data received in response")
        }
    }
    task.resume()
}


