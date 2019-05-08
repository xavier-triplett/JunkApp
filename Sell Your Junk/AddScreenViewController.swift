//
//  AddScreenViewController.swift
//  Sell Your Junk
//
//  Created by Xavier Triplett on 4/26/19.
//  Copyright © 2019 Xavier Triplett. All rights reserved.
//

import UIKit

class AddScreenViewController: UIViewController, DataHandler {
    func handle(fetchedData: [Item]) {
        let data = fetchedData
    }
    

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBAction func savePress(_ sender: Any) {
        let addItem: Item = Item()
        var save = true
        if let name = nameField?.text {
            addItem.Name = name
        } else {
            save = false
        }
        if let price = Int(priceField.text!) {
            addItem.Price = price
        } else {
            save = false
        }
        if let category = categoryField?.text {
            addItem.Category = category
        } else {
            save = false
        }
        if let description = descriptionField?.text {
            addItem.Description = description
        } else {
            save = false
        }
        if (save) {
            let ds = MyData()
            ds.delegate = self
            ds.AddData(addItem)
            
            let alertController = UIAlertController(
                title: "Save Successful",
                message: "Navigate back to items to see the item you just added",
                preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(
                title: "Save Failed",
                message: "Please fill in all fields as they are all required",
                preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }


    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
