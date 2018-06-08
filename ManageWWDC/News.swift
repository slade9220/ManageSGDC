//
//  News.swift
//  WWDC Academy
//
//  Created by Gennaro Amura on 01/06/18.
//  Copyright © 2018 Gennaro Amura. All rights reserved.
//

import Foundation

struct New: Codable {
    
    var id: Int
    var name: String
    var text: String
    var data: String
    
    init (id: Int, name: String, text: String, data: String) {
        self.id = id
        self.name = name
        self.text = text
        self.data = data
    }
    
    
}


func loadNews()->[New] {
    var news : [New] = []
    let jsonUrl = "https://.../query/getNews.php"
    
    guard let url = URL(string: jsonUrl) else { return news }
    let request: URLRequest = URLRequest(url: url)
    let session = URLSession.shared
    
    let semaphore = DispatchSemaphore(value: 0)
    session.dataTask(with: request) { (data, response, err) in
        guard let data = data else { return }
        
        do {
            news = try JSONDecoder().decode([New].self, from: data)
        } catch let jsonErr {
            print("Error: ",jsonErr)
        }
        
        semaphore.signal()
        }.resume()
    
    semaphore.wait()
    return news
}

func sendN(new: New, completion:((Bool?) -> Void)?) {
    let postUrl = "https://.../query/sendnotification.php"
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
        let jsonData = try encoder.encode(new)
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


func sendNot(new: New, completion:((Bool?) -> Void)?) {
    let postUrl = "https://fcm.googleapis.com/fcm/send"
    let notificationFirebase = NotificationFirebase(body: new.text, title: new.name)
    let message = Data(notification: new.name)
    let firebase = FirebaseMessage(message: message)
    guard let url = URL(string: postUrl ) else { fatalError("Could not create URL") }
    
    // Specify this request as being a POST method
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // Make sure that we include headers specifying that our request's HTTP body
    // will be JSON encoded
    var headers = request.allHTTPHeaderFields ?? [:]
    headers["Content-Type"] = "application/json"
    headers["Authorization"] = "key=SERVERKEY"
    request.allHTTPHeaderFields = headers
    
    // Now let's encode out Post struct into JSON data...
    let encoder = JSONEncoder()
    do {
        let jsonData = try encoder.encode(firebase)
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

//{
//    "to": "/topics/anytopic",
//    "data": {
//        "message": "This is a GCM Topic Message!",
//    }

struct FirebaseMessage: Codable{
    var data: Data
    var to: String
    
    init(message: Data) {
        self.data = message
        self.to = "/topics/SGDC"
    }
    
}

struct Data: Codable{
    var message: String
    
    init(notification: String){
        self.message = notification
    }
}

struct  NotificationFirebase: Codable{
    var body: String
    var title: String
    
    init(body: String, title: String){
        self.body = body
        self.title = title
    }
}
