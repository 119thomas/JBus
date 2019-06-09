//
//  MapViewController.swift
//  JBus
//
//  Created by William Thomas on 5/20/19.
//  Copyright © 2019 William Thomas. All rights reserved.
//

import UIKit

class StopsViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("seague is \(segue.identifier)")
        if(segue.identifier == "ShowShuttleStops") {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
