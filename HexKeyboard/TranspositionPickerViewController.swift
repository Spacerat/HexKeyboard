//
//  ViewController.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 02/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import UIKit

class TranspositionPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let semitoneRange = 24
    let octaveRange = 4
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return octaveRange + 1
        }
        else {
            return semitoneRange + 1
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.preferredContentSize = picker.bounds.size
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        
        //return "Test"
        if component == 1 {
            let semitone = row - (semitoneRange/2)
            let symbol = semitone >= 0 ? "+" : ""
            println(symbol)
            return "\(symbol)\(semitone)"
        }
        else {
            let octave = row - (octaveRange/2)
            let plural = octave == 1 ? "" : "s"
            let symbol = octave >= 0 ? "+" : ""
            println(symbol)
            return "\(symbol)\(octave) octave\(plural)"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

