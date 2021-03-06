//
//  Notes.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 02/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import Foundation

let NoteNames = ["A", "Bb", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]

protocol NotePlayer : class {
    func play(note: Note)
    func release(note: Note)
    init?(instrument:InstrumentSpec)
    var currentInstrument : InstrumentSpec {get}
}


struct Interval : Printable, Comparable {
    let semitones:Int
    
    init(semitones:Int) {
        self.semitones = semitones
    }
    
    var transposeName:String {
        get {
            let plus = semitones > 0 ? "+" : ""
            let plural = semitones*semitones != 1 ? "s" : ""
            return "\(plus)\(semitones) semitone\(plural)"
        }
    }
    
    static func transposeInterval() -> Interval {
        return Interval(semitones: NSUserDefaults.standardUserDefaults().integerForKey("transpose"))
    }
    
    var description :String {
        get { return transposeName }
    }
}

struct Note : Printable, Comparable {
    let index:Int
    
    init(index: Int ) {
        self.index = index
    }
    
    init(hexRow: Int, column: Int) {
        let co = Int(floor(Double(column)/2.0))
        let note = -hexRow * 7 + co + abs((column%2))*(-3) + 70
        let transposed = note + Interval.transposeInterval()
        
        self.init(index: transposed)
    }
    
    var name : String {
        get {
            let i = self.index < 0 ? self.index + 48 : self.index
            return NoteNames[(i+3) % 12]
        }
    }
    
    var MIDIindex :UInt8 {
        get {
            return UInt8(self.index)
        }
    }
    
    var description : String {
        get { return name }
    }
}

func == (left:Note, right:Note) -> Bool { return left.index == right.index}
func < (left: Note, right:Note) -> Bool { return left.index < right.index}

func == (left:Interval, right:Interval) -> Bool {return left.semitones == right.semitones}
func < (left:Interval, right:Interval) -> Bool { return left.semitones < right.semitones}

func + (left:Note, right:Interval) -> Note { return Note(index: left.index+right.semitones)}
func - (left:Note, right:Interval) -> Note { return Note(index: left.index-right.semitones)}
func + (left:Int, right:Interval) -> Int {return right.semitones + left}