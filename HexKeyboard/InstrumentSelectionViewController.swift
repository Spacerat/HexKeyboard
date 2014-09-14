//
//  InstrumentSelectionViewController.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 14/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//


import Foundation
import UIKit

class InstrumentSelectionViewController: UITableViewController {

    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("instrumentCell")! as UITableViewCell
        
        // Configure cell
        
        return UITableViewCell()
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            // Do some stuff when things are clicked
        }
    }
}
