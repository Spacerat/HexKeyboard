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
    let transient : Bool
    static let defaultInstrumentSpec = InstrumentSpec.getBuiltinInstruments()[0]
    
    var description : String {get { return name }}
    init(name:String, kind:InstrumentKind, builtin:Bool, transient: Bool) {
        self.name = name
        self.kind = kind
        self.builtin = builtin
        self.transient = transient
    }
    
    init(name:String, kind:InstrumentKind, builtin:Bool) {
        self.init(name:name, kind:kind, builtin:builtin, transient: true)
    }
    
    init(dict: [NSObject : AnyObject]) {
        let name = dict["name"]! as String
        let kindName = dict["kind"]! as String
        let builtin = dict["builtin"]! as Bool
        let transient = (dict["transient"] as Bool?) ?? true
        let kind = InstrumentKind(rawValue: kindName) ?? InstrumentKind.MIDI
        self.init(name: name, kind:kind, builtin: builtin, transient: transient)
    }
    
    var dict : NSDictionary {
        get {
            return [
                "name" : name,
                "kind": kind.rawValue,
                "builtin" : builtin,
                "transient" : transient
            ]
        }
    }
    
    init(BuiltinMIDI name:String) {
        self.init(name: name, kind:.MIDI, builtin: true)
    }
    
    init(EXS name:String, isTransient transient:Bool) {
        self.init(name: name, kind:.EXS, builtin: true, transient: transient)
    }
    
    static func getBuiltinInstruments() -> [InstrumentSpec] {
        return [InstrumentSpec(BuiltinMIDI: "Bell"),
                InstrumentSpec(BuiltinMIDI: "Swell"),
                InstrumentSpec(BuiltinMIDI: "Piano"),
                InstrumentSpec(BuiltinMIDI: "Pulse"),
                InstrumentSpec(EXS: "Full Organ", isTransient: false)
        ]
    }
    
    func getInstrument() -> NotePlayer? {
        return MIDISampler(instrument: self)
    }
    
    static var currentInstrumentSpec : InstrumentSpec {
        get {
            let defaults = NSUserDefaults.standardUserDefaults()
            let defaultInstrument = InstrumentSpec(name: "Bell", kind: .MIDI, builtin: true)
        
            if let dict = defaults.dictionaryForKey("instrument") {
                let instrument = InstrumentSpec(dict: dict)
                self.currentInstrumentSpec = instrument
                return instrument
            }

            self.currentInstrumentSpec = defaultInstrument
            return self.currentInstrumentSpec
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
