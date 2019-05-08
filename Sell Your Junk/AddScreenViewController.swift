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
        if let name = nameField?.text {
            addItem.Name = name
        }
        if let price = Int(priceField.text!) {
            addItem.Price = price
        }
        if let category = categoryField?.text {
            addItem.Category = category
        }
        if let description = descriptionField?.text {
            addItem.Description = description
        }
        let ds = MyData()
        ds.delegate = self
        ds.AddData(addItem)
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
