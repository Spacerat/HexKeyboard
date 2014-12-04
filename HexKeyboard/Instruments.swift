//
//  Instruments.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 14/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import Foundation

enum InstrumentKind : String {
    case MIDI = "MIDI"
    case EXS = "EXS"
}

struct InstrumentSpec : Printable {
    let name : String
    let kind : InstrumentKind
    let builtin : Bool
    
    var description : String {get { return name }}
    
    init(name:String, kind:InstrumentKind, builtin:Bool) {
        self.name = name
        self.kind = kind
        self.builtin = builtin
    }
    
    init(dict: [NSObject : AnyObject]) {
        let name = dict["name"]! as String
        let kindName = dict["kind"]! as String
        let builtin = dict["builtin"]! as Bool
        let kind = InstrumentKind(rawValue: kindName) ?? InstrumentKind.MIDI
        self.init(name: name, kind:kind, builtin: builtin)
    }
    
    var dict : NSDictionary {
        get {
            return ["name" : name, "kind": kind.rawValue, "builtin" : builtin]
        }
    }
    
    init(BuiltinMIDI name:String) {
        self.init(name: name, kind:.MIDI, builtin: true)
    }
    
    init(EXS name:String) {
        self.init(name: name, kind:.EXS, builtin: true)
    }
    
    static func getBuiltinInstruments() -> [InstrumentSpec] {
        return [InstrumentSpec(BuiltinMIDI: "Bell"),
                InstrumentSpec(BuiltinMIDI: "Swell"),
                InstrumentSpec(BuiltinMIDI: "Piano"),
                InstrumentSpec(BuiltinMIDI: "Pulse"),
                InstrumentSpec(EXS: "Full Organ")]
    }
    
    func getInstrument() -> NotePlayer? {
        if kind == .MIDI {
            return MIDISampler(name: name)
        }
        if kind == .EXS {
            return MIDISampler(instrumentName: name, withExtension: "exs")
        }
        return nil
    }
    
    static var currentInstrumentSpec : InstrumentSpec {
        get {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let dict = defaults.dictionaryForKey("instrument") {
                return InstrumentSpec(dict: dict)
            }
            else {
                self.currentInstrumentSpec = InstrumentSpec(name: "Bell", kind: .MIDI, builtin: true)
                return self.currentInstrumentSpec
            }
        }
        set {
            let defaults = NSUserDefaults.standardUserDefaults()
            let dict = newValue.dict
            defaults.setObject(dict, forKey: "instrument")
            defaults.synchronize()
        }
    }
    
    static var currentInstrument : NotePlayer? {
        get {
            return currentInstrumentSpec.getInstrument()
        }
    }
}

func == (left: InstrumentSpec, right: InstrumentSpec) -> Bool {
    return left.kind == right.kind && left.name == right.name && left.builtin == right.builtin
}
func != (left:InstrumentSpec, right:InstrumentSpec) -> Bool {
    return !(left == right)
}
