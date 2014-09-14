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
    
    var currentInstrument = InstrumentSpec.currentInstrumentSpec
    var selectedCell : UITableViewCell?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        currentInstrument = InstrumentSpec.currentInstrumentSpec
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("builtin_instrument")! as UITableViewCell
            if let instrument = instrumentForRowAtIndexPath(indexPath) {
                cell.textLabel?.text = instrument.description
                cell.accessoryType = currentInstrument == instrument ? .Checkmark : .None
                if currentInstrument == instrument {
                    selectedCell = cell
                }
            }
            return cell
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("record_button")! as UITableViewCell
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func instrumentForRowAtIndexPath(indexPath:NSIndexPath) -> InstrumentSpec? {
        if indexPath.section == 0 {
            return InstrumentSpec.getBuiltinInstruments()[indexPath.row]
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 1 && indexPath.row == 0 {
            return 88
        }
        
        return UITableViewAutomaticDimension
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Built In"
        case 1: return "Sampler"
        default: return nil
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return InstrumentSpec.getBuiltinInstruments().count
        case 1: return 2
        default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            if let instrument = instrumentForRowAtIndexPath(indexPath) {
                if instrument != currentInstrument {
                    cell.accessoryType = .Checkmark
                    selectedCell?.accessoryType = .None
                    selectedCell = cell
                    InstrumentSpec.currentInstrumentSpec = instrument
                    currentInstrument = instrument
                }
            }
        }
    }
}
