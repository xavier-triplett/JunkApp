//
//  BuyViewController.swift
//  Sell Your Junk
//
//  Created by Xavier Triplett on 5/3/19.
//  Copyright © 2019 Xavier Triplett. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, DataHandler {

    var delegate: DataHandler?
    
    var item: Item?

    func handle(fetchedData: [Item]) {
    }

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var PriceField: UITextField!
    @IBOutlet weak var CategoryField: UITextField!
    @IBOutlet weak var DescriptionField: UITextField!
    
    @IBAction func BuyPress(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Buy Successful",
            message: "\n",
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: {
            (_)in
            if let junk = self.item {
                self.soldItemCompletionHandler(junk)
            }
        }))
        
        if let name = self.item?.Name, var message = alertController.message {
            message = message + "Successfully bought \(name)! Click close to navigate back to the item list."
            alertController.message = message
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func soldItemCompletionHandler(_ item: Item) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        let ds = MyData()
        ds.delegate = self.delegate
        ds.RemoveData(item)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = self.item?.Name {
            self.NameField.text = name
        }
        if let price = self.item?.Price {
            let nsprice = NSNumber(value: price)
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            self.PriceField.text = formatter.string(from: nsprice)
        }
        if let category = self.item?.Category {
            self.CategoryField.text = category
        }
        if let description = self.item?.Description {
            self.DescriptionField.text = description
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
 
    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         let updateVC = segue.destination as! UpdateScreenViewController
         updateVC.delegate = self.delegate
         updateVC.item = self.item
     }

}
