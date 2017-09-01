//
//  NetworkManager.swift
//  The Movie
//
//  Created by Ankur Nautiyal on 01/09/17.
//  Copyright © 2017 Impinge. All rights reserved.
//

import Foundation


class NetworkController {
//    static let questionsURL = "https://api.stackexchange.com/2.2/questions?order=desc&sort=votes&site=stackoverflow"
//    static let usersURL = "https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&site=stackoverflow"
//    
//    func load(_ urlString: String, withCompletion completion: @escaping ([Any]?) -> Void) {
//        
//        
//        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
//        let url = URL(string: urlString)!
//        
//        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//            guard (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) != nil else {
//                completion(nil)
//                return
//            }
//            let result: [Any]
//            switch urlString {
//            case NetworkController.questionsURL:
//                result = [] // Transform JSON into Question values
//            case NetworkController.usersURL:
//                result = [] // Transform JSON into Question values
//            default:
//                result = []
//            }
//            completion(result)
//        })
//        task.resume()
//    }
//    
//    
//    
//    let myUrl = NSURL(string: url as String)
//    let request = NSMutableURLRequest(url:myUrl! as URL);
//    request.httpMethod = "GET"
//    
//    
//    // Excute HTTP Request
//    
//    let task = URLSession.shared.dataTask(with: request as URLRequest) {
//        data, response, error in
//        // Check for error
//        if error != nil
//        {
//            print("error=\(String(describing: error))")
//            return
//        }
//        
//        let str = request.url?.absoluteString
//        do {
//            if (try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary) != nil
//            {
//                let jsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
//                print( jsonDict as Any )
//                
//                
//                
//            }
//        }
//        catch let error as NSError
//        {
//            print(error.localizedDescription)
//        }
//    }
//    task.resume()
//    
    
}
