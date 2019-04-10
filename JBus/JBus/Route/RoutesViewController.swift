//
//  ShuttleViewController.swift
//  JBus
//
//  Created by William Thomas on 4/4/19.
//  Copyright © 2019 William Thomas. All rights reserved.
//

import UIKit

class RoutesViewController: UITableViewController {
    let pinky = brains()
    var routes: [shuttle]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        routes = pinky.getShuttles()
    }
    
    /* delegates */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(routes?[indexPath.row].title ?? "")"
        return cell
    }
}
