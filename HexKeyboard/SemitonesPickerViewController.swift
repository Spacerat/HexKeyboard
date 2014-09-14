//
//  File.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 14/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import Foundation
import UIKit

class SemitonesPickerViewController: UITableViewController {
    let minTranspose = -12
    let maxTranspose = 24
    
    var selectedCell : UITableViewCell?
    var selectedTranspose = Interval(semitones: 0)
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        selectedTranspose = Interval.transposeInterval()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("semitoneCell")! as UITableViewCell
        let interval = intervalForRowAtIndexPath(indexPath)
        cell.textLabel?.text = interval.transposeName
        cell.accessoryType = interval == selectedTranspose ? .Checkmark : .None
        if interval == selectedTranspose {
            selectedCell = cell
        }
        return cell
        
    }
    
    func intervalForRowAtIndexPath(indexPath:NSIndexPath) -> Interval {
        return Interval(semitones: indexPath.row + minTranspose)
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maxTranspose - minTranspose + 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let newCell = tableView.cellForRowAtIndexPath(indexPath) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let newTranspose = intervalForRowAtIndexPath(indexPath)
            if newTranspose != selectedTranspose {
                newCell.accessoryType = .Checkmark
                selectedCell?.accessoryType = .None
                selectedCell = newCell
                selectedTranspose = newTranspose
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setInteger(selectedTranspose.semitones, forKey: "transpose")
                defaults.synchronize()
            }
        }
    }
    
}
