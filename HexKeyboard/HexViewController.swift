//
//  ViewController.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 02/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import UIKit
import Foundation
import CoreAudio
import AVFoundation

class HexViewController: UIViewController, HexViewDelegate {
    
    var player : NotePlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(view.frame)
        //println(view)
        
        let k = AVAudioEngine()
        println("viewDidLoad")
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
    
    override func viewWillAppear(animated: Bool) {
        if let hexes = self.view as? HexView {
            hexes.refreshLabels()
        }
        if let instrument = InstrumentSpec.currentInstrument {
            player = instrument
        }
        else {
            player = InstrumentSpec.defaultInstrumentSpec.getInstrument()
        }
    }
    
    func hexPressed(row: Int, column: Int) {
        let note = Note(hexRow: row, column: column)
        //println("\(note.index) : \(note.name)")
        player.play(note)
    }
    
    func hexReleased(row: Int, column: Int) {
        let note = Note(hexRow: row, column: column)
        player.release(note)
    }
    
    func hexNameForRow(row: Int, column: Int) -> String {
        let name = Note(hexRow: row, column: column).name
        return "\(name)"
    }
    
    func shouldHoldKeys() -> Bool {
        return player.currentInstrument.transient == false
    }
    
}

