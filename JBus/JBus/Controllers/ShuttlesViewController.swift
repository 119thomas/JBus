//
//  ShuttleViewController.swift
//  JBus
//
//  Created by William Thomas on 4/4/19.
//  Copyright © 2019 William Thomas. All rights reserved.
//

import UIKit

class ShuttlesViewController: UITableViewController {
    let pinky = brains()
    var shuttles: [shuttle]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        shuttles = pinky.getShuttles()
    }
    
    /* This is where we will pass data between the ShuttlesViewController and the
        StopsViewController. Our StopsViewController needs to know which shuttle was
        selected in order to display the correct stops and times */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("seague is \(segue.identifier)")
        if(segue.identifier == "ShowShuttleStops") {
            
        }
    }
    
    /* delegates */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shuttles?.count ?? 0
    }
    
    // access cells here; indexPath.row is the index for each row, i.e. each specific shuttle
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(shuttles?[indexPath.row].title ?? "")"
        
        let shuttleStops = shuttles?[indexPath.row].stops ?? []
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row \(indexPath.row)")
        
    }
}
