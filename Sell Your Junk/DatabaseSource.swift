//
//  DatabaseSource.swift
//  Sell Your Junk
//
//  Created by Xavier Triplett on 4/24/19.
//  Copyright © 2019 Xavier Triplett. All rights reserved.
//

import Foundation

class Item: Codable {
    var Name = ""
    var Price = 0
    var Category = ""
    var Description = ""
    
    init(Name: String, Price: Int, Category: String, Description: String) {
        self.Name = Name
        self.Price = Price
        self.Category = Category
        self.Description = Description
    }
    
    convenience init() {
        self.init(Name: "", Price: 0, Category: "", Description: "")
    }
}

protocol DataHandler {
    func handle(fetchedData: [Item])
}

class MyData: NSObject {
    
    var delegate: DataHandler?
    
    func GetData(){
        let urlString = "http://127.0.0.1:8888/JunkGet.php"
        let urlSession = URLSession(configuration: .default)
        if let url = URL(string: urlString) {
            let dataTask = urlSession.dataTask(with: url, completionHandler: urlSessionDataTaskCompletionHandler)
            dataTask.resume()
        }
    }
    
    func urlSessionDataTaskCompletionHandler(possibleData: Data?, possibleResponse: URLResponse?, possibleError: Error?) {
        do {
            let dataArray = try JSONDecoder().decode([Item].self, from: possibleData!)
            
            DispatchQueue.main.async {
                self.delegate?.handle(fetchedData: dataArray)
            }
        }
        catch {
            print("Error decoding JSON data: \(error)")
        }
    }
    
    
    func AddData(_ data: Item){
        let urlString = "http://127.0.0.1:8888/JunkPost.php"
        let urlSession = URLSession(configuration: .default)
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL String")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let uploadData = try? JSONEncoder().encode(data) else {
            print("Unable to encode data")
            return
        }
        
        let dataTask = urlSession.uploadTask(with: urlRequest, from: uploadData, completionHandler: urlSessionUploadTaskCompletionHandler)
        dataTask.resume()
    }
    
    
    
    
    func urlSessionUploadTaskCompletionHandler(optionalData: Data?, optionalURLResponse: URLResponse?, optionalError: Error?) {
        if let data = optionalData {
            let response = String(decoding: data, as: UTF8.self)
            print(response
            )
        }
        else {
            print("web service error: returned data is nil")
        }
    }
}

