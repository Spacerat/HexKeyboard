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
        
        self.sampler = AVAudioUnitSampler()
        engine.attachNode(sampler)

        engine.connect(sampler, to: mixer, format: nil)
    }
    
    convenience init(URL url : NSURL) {
        self.init()
        var err : NSErrorPointer = nil
        sampler.loadAudioFilesAtURLs([url], error: err)
        if err != nil {println(err)}
    }
    
    convenience init(sound_name : String) {
        self.init()
        if let url = NSBundle.mainBundle().URLForResource(sound_name, withExtension: "m4a") {
            var err : NSErrorPointer = nil
            sampler.loadAudioFilesAtURLs([url], error: err)
            if err != nil {println(err)}
        }
    }
    
    convenience required init(name : String) {
        self.init(sound_name : name)
    }
    
    func play(note: Note) {
        sampler.startNote(UInt8(note.index), withVelocity: 200, onChannel: 0)
    }
    
    deinit {
        engine.stop()
    }
}