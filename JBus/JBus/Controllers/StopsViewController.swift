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
    
    // access cells here; indexPath.row is the index for each row, i.e. each specific shuttle
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopCell") as! StopCell

        cell.stopName.text = shuttleSelected?.stops[indexPath.row].title ?? ""
        
        cell.stopDue.text = "4 min"
        return cell
    }
}
