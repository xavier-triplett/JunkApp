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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
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
