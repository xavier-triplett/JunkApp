//
//  AddScreenViewController.swift
//  Sell Your Junk
//
//  Created by Xavier Triplett on 4/26/19.
//  Copyright © 2019 Xavier Triplett. All rights reserved.
//

import UIKit

class AddScreenViewController: UIViewController, DataHandler {
    
    var delegate: DataHandler?

    func handle(fetchedData: [Item]) {
    }

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBAction func savePress(_ sender: Any) {
        let addItem: Item = Item()
        var save = true
        
        let alertController = UIAlertController(
            title: "",
            message: "\n \n",
            preferredStyle: .alert)

        if let name = self.nameField?.text {
            if (!name.isEmpty) {
                addItem.Name = name
            } else {
                save = false
                if var message = alertController.message {
                    message += "Name is required! \n \n"
                    alertController.message = message
                }
            }
        }
        
        if let price = Int(self.priceField.text!) {
            addItem.Price = price
        } else {
            save = false
            if var message = alertController.message {
                message += "Price is required and must be a number! \n \n"
                alertController.message = message
            }
        }
        
        if let category = self.categoryField?.text {
            if (!category.isEmpty) {
                addItem.Category = category
            } else {
                save = false
                if var message = alertController.message {
                    message += "Category is required! \n \n"
                    alertController.message = message
                }
            }
        }
        
        if let description = self.descriptionField?.text {
            if (!description.isEmpty) {
                addItem.Description = description
            } else {
                save = false
                if var message = alertController.message {
                    message += "Description is required! \n \n"
                    alertController.message = message
                }
            }
        }
        
        if (save) {
            alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: {
                (_)in
                self.addItemCompletionHandler(addItem)
            }))
            
            alertController.title = "Save Successful"
            alertController.message = "Navigate back to items to see the item you just added"
            
        } else {
            alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            
            alertController.title = "Save Failed"
        }

        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func addItemCompletionHandler(_ item: Item) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        let ds = MyData()
        ds.delegate = self.delegate
        ds.AddData(item)
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
