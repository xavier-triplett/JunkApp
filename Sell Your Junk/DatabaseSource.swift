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
    var Price = 0.0
    var Category = ""
    var Description = ""
    
    init(Name: String, Price: Double, Category: String, Description: String) {
        self.Name = Name
        self.Price = Price
        self.Category = Category
        self.Description = Description
    }
    
    convenience init() {
        self.init(Name: "", Price: 0.0, Category: "", Description: "")
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
    
    func urlSessionDataTaskCompletionHandler(optionalData: Data?, optionalURLResponse: URLResponse?, optionalError: Error?) {
        do {
            let dataArray = try JSONDecoder().decode([Item].self, from: optionalData!)
            
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
    
    func RemoveData(_ data: Item){
        let urlString = "http://127.0.0.1:8888/JunkDelete.php"
        let urlSession = URLSession(configuration: .default)
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL String")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let removeData = try? JSONEncoder().encode(data) else {
            print("Unable to encode data")
            return
        }
        
        let dataTask = urlSession.uploadTask(with: urlRequest, from: removeData, completionHandler: urlSessionUploadTaskCompletionHandler)
        dataTask.resume()
    }
    
    func UpdateData(_ data: Item){
        let urlString = "http://127.0.0.1:8888/JunkPut.php"
        let urlSession = URLSession(configuration: .default)
    
        guard let url = URL(string: urlString) else {
            print("Invalid URL String")
            return
        }
    
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        guard let updateData = try? JSONEncoder().encode(data) else {
            print("Unable to encode data")
            return
        }
    
        let dataTask = urlSession.uploadTask(with: urlRequest, from: updateData, completionHandler: urlSessionUploadTaskCompletionHandler)
        dataTask.resume()
    }
    
    func urlSessionUploadTaskCompletionHandler(optionalData: Data?, optionalURLResponse: URLResponse?, optionalError: Error?) {
        self.GetData()
    }

}

