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
    @IBOutlet weak var RoutesTable: UITableView!
    
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
        let index = self.tableView.indexPathForSelectedRow?.row
        let SVC = segue.destination as! StopsViewController
        SVC.shuttleSelected = shuttles?[index!]
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
        return cell
    }
    
    // Allows us to change the view from our Shuttles View Controller to the StopsViewController; showStop is the segue identifier from shuttle view controller to stop view controller.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showStop", sender: self)
    }
}
