//
//  StopsViewController.swift
//  JBus
//
//  Created by William Thomas on 5/20/19.
//  Copyright © 2019 William Thomas. All rights reserved.
//

import UIKit

class StopsViewController: UITableViewController {
    @IBOutlet weak var label: UILabel!
    
    var shuttleSelected: shuttle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print("name: \(shuttleSelected?.title)")
    }
}
