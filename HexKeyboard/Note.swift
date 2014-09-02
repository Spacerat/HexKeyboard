//
//  Notes.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 02/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import Foundation

let NoteNames = ["A ", "Bb", "B ", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]

struct Note {
    let index:Int
    
    init(index: Int ) {
        self.index = index
    }
    
    init(hexRow: Int, column: Int) {
        let co = Int(floor(Double(column/2.0)))
        let note = hexRow * 5 + co + (column%2)*9 + 30
        self.init(index: note)
    }
    
    var name : String {
        get {
            return NoteNames[(self.index+3) % 12]
        }
    }
}