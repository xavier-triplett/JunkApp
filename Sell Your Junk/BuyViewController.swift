//
//  BuyViewController.swift
//  Sell Your Junk
//
//  Created by Xavier Triplett on 5/3/19.
//  Copyright © 2019 Xavier Triplett. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, DataHandler {
    func handle(fetchedData: [Item]) {
        //let data = fetchedData
    }

    var item: Item?
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var PriceField: UITextField!
    @IBOutlet weak var CategoryField: UITextField!
    @IBOutlet weak var DescriptionField: UITextField!
    
    @IBAction func BuyPress(_ sender: Any) {
        let ds = MyData()
        ds.delegate = self
        ds.RemoveData(item!)
        let alertController = UIAlertController(
            title: "Buy Successful",
            message: "\n",
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        if let name = item?.Name, var message = alertController.message {
            message = message + "Successfully bought \(name)!"
            alertController.message = message
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = item?.Name {
            NameField.text = name
        }
        if let price = item?.Price {
            let nsprice = NSNumber(value: price)
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            PriceField.text = formatter.string(from: nsprice)
        }
        if let category = item?.Category {
            CategoryField.text = category
        }
        if let description = item?.Description {
            DescriptionField.text = description
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
