//
//  UpdateScreenViewController.swift
//  Sell Your Junk
//
//  Created by Xavier Triplett on 5/16/19.
//  Copyright © 2019 Xavier Triplett. All rights reserved.
//

import UIKit

class UpdateScreenViewController: UIViewController, DataHandler {

    var delegate: DataHandler?
    
    var item: Item?
    
    func handle(fetchedData: [Item]) {
    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBAction func pressSave(_ sender: Any) {
        let updateItem: Item = Item()
        var save = true
        
        let alertController = UIAlertController(
            title: "",
            message: "\n \n",
            preferredStyle: .alert)
        
        if let price = self.priceField?.text {
            if (!price.isEmpty) {
                if let doublePrice = Double(price) {
                    updateItem.Price = doublePrice
                } else {
                    if (price.contains(",")) {
                        save = false
                        if var message = alertController.message {
                            message += "Please remove the comma from price! \n \n"
                            alertController.message = message
                        }
                    } else {
                        if var message = alertController.message {
                            message += "Price must be a number! Decimal places are optional. \n \n"
                            alertController.message = message
                        }
                    }
                    save = false
                }
            } else {
                save = false
                if var message = alertController.message {
                    message += "Price is required! \n \n"
                    alertController.message = message
                }
            }
        }
        
        if let category = self.categoryField?.text {
            if (!category.isEmpty) {
                updateItem.Category = category
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
                updateItem.Description = description
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
                self.updateItemCompletionHandler(updateItem)
            }))
            
            alertController.title = "Update Successful"
            alertController.message = "Click close to navigate back to items to see the item you just added."
            
        } else {
            alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            
            alertController.title = "Update Failed"
        }
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func updateItemCompletionHandler(_ item: Item) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
            navController.popViewController(animated: true)
        }
        let ds = MyData()
        ds.delegate = self.delegate
        ds.UpdateData(item)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = self.item?.Name {
            self.nameField.text = name
        }
        if let price = self.item?.Price {
            self.priceField.text = "\(price)"
        }
        if let category = self.item?.Category {
            self.categoryField.text = category
        }
        if let description = self.item?.Description {
            self.descriptionField.text = description
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
