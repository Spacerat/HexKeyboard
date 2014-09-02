//
//  ViewController.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 02/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import UIKit

class HexViewController: UIViewController, HexViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(view.frame)
        //println(view)


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        let hexes = HexView()
        self.view = hexes
        hexes.delegate = self
        
    }
    
    func hexPressed(row: Int, column: Int) {
        let note = Note(hexRow: row, column: column)
        println("\(note.index) : \(note.name)")
        
    }
    
    func hexNameForRow(row: Int, column: Int) -> String {
        return Note(hexRow: row, column: column).name
    }
    
}

