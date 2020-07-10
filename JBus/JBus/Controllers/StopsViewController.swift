//
//  StopsViewController.swift
//  JBus
//
//  Created by William Thomas on 5/20/19.
//  Copyright © 2019 William Thomas. All rights reserved.
//

import UIKit

/* class for our stop cell so we can customize it easier */
class StopCell: UITableViewCell {
    @IBOutlet weak var stopName: UILabel!
    @IBOutlet weak var stopDue: UILabel!
}

class StopsViewController: UITableViewController {
    let pinky = brains()
    var shuttleSelected: shuttle?
    @IBOutlet weak var NavBar: UINavigationItem!
    @IBOutlet weak var StopsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NavBar.title = shuttleSelected?.title
        
    }
    
    /* delegates */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // size of the list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shuttleSelected?.stops.count ?? 0
    }
    
    // access cells here; indexPath.row is the index for each row, i.e. each specific stop
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopCell") as! StopCell
        let name = shuttleSelected?.stops[indexPath.row].title ?? ""
        let stop = (shuttleSelected?.stops[indexPath.row])!
        let predictions = pinky.requestPredictions(stop: stop)
        var due = "N/A"
        
        for p in predictions {
            if p.0 == stop.title {
                due = String(p.1)
                break
            }
        }
        
        cell.stopName.text = name
        cell.stopDue.text = due + " min"

        return cell
    }
}
