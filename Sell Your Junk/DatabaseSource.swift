//
//  DatabaseSource.swift
//  Sell Your Junk
//
//  Created by Xavier Triplett on 4/24/19.
//  Copyright © 2019 Xavier Triplett. All rights reserved.
//

import Foundation

struct Item: Codable {
    var Name = ""
    var Price = 0
    var Category = ""
    var Description = ""
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
}
