//
//  Sampler.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 04/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import Foundation
import AVFoundation

class MIDISampler : NotePlayer {
    let engine : AVAudioEngine
    let mixer : AVAudioMixerNode
    let sampler: AVAudioUnitSampler
    init() {
        engine  = AVAudioEngine()
        mixer = AVAudioMixerNode()
        engine.attachNode(mixer)
        engine.connect(mixer, to: engine.outputNode, format: nil)
        
        var err : NSErrorPointer = nil
        engine.startAndReturnError(err)
        if err != nil {println(err)}
        
        sampler = AVAudioUnitSampler()
        engine.attachNode(sampler)
        let try_url = NSBundle.mainBundle().URLForResource("C", withExtension: "m4a")
        if let url = try_url {
            sampler.loadAudioFilesAtURLs([url], error: err)
            if err != nil {println(err)}
        }
        engine.connect(sampler, to: mixer, format: nil)
        
    }
    
    func play(note: Note) {
        sampler.startNote(UInt8(note.index), withVelocity: 200, onChannel: 0)
    }
}