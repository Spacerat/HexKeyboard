//
//  Sampler.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 04/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import Foundation
import AVFoundation
import CoreAudio

class MIDISampler : NotePlayer {
    let engine : AVAudioEngine
    let mixer : AVAudioMixerNode
    let sampler: AVAudioUnitSampler
    var instrument : InstrumentSpec!
    
    init() {
        engine  = AVAudioEngine()
        mixer = AVAudioMixerNode()
        engine.attachNode(mixer)
        engine.connect(mixer, to: engine.outputNode, format: nil)
        
        var err : NSErrorPointer = nil
        engine.startAndReturnError(err)
        if err != nil {println(err)}
        
        self.sampler = AVAudioUnitSampler()
        engine.attachNode(sampler)

        engine.connect(sampler, to: mixer, format: nil)
    }
    
    var currentInstrument : InstrumentSpec {
        get {
            return instrument
        }
    }
    
    func extForType(type: InstrumentKind) -> String? {
        if type == .MIDI {
            return "m4a"
        }
        if type == .EXS {
            return "exs"
        }
        return nil
    }
    
    required convenience init?(instrument: InstrumentSpec) {
        self.init()
        if let ext = extForType(instrument.kind) {
            if let url = NSBundle.mainBundle().URLForResource(instrument.name, withExtension: ext) {
                var err : NSErrorPointer = nil

                if instrument.kind == .MIDI {
                sampler.loadAudioFilesAtURLs([url], error: err)
                }
                if instrument.kind == .EXS {
                sampler.loadInstrumentAtURL(url, error: err)
                }
                if err != nil {
                    println(err)
                    return nil
                }
                self.instrument = instrument
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    func play(note: Note) {
        sampler.startNote(note.MIDIindex, withVelocity: 200, onChannel: 0)
    }
    
    func release(note: Note) {
        if !instrument.transient {
            sampler.stopNote(note.MIDIindex, onChannel: 0)
        }
    }
    
    deinit {
        engine.stop()
    }
}