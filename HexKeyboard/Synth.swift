//
//  Player.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 02/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import Foundation
import AVFoundation

protocol NotePlayer : class {
    func play(note: Note);
}

class Synth : NotePlayer {
    let engine : AVAudioEngine
    let mixer : AVAudioMixerNode
    let player : AVAudioPlayerNode
    let players : [AVAudioPlayerNode]
    init() {
        engine  = AVAudioEngine()
        mixer = AVAudioMixerNode()
        player = AVAudioPlayerNode()
        
//        for i in 0..<10 {
//            players.append(<#newElement: T#>)
//        }
        engine.attachNode(mixer)
        engine.attachNode(player)
        engine.connect(mixer, to: engine.outputNode, format: nil)
        engine.connect(player, to: mixer, format: nil)
        var err : NSErrorPointer = nil
        engine.startAndReturnError(err)
        
        if err != nil {
            println(err)
        }
    }
    
    
    
    func play(note: Note) {
//        NSURL *pdfURL = [[NSBundle mainBundle] URLForResource:@"sampleLayout.pdf" withExtension:nil];
        
        let bundleUrl = NSBundle.mainBundle().URLForResource("\(note.name)", withExtension: "m4a")
        if let url = bundleUrl {
            var err : NSError?
            let file = AVAudioFile(forReading: url, error: &err)
            if err != nil {
                println(err)
            }
            let buff = AVAudioPCMBuffer(PCMFormat: AVAudioFormat(standardFormatWithSampleRate: 44000, channels: 2), frameCapacity: 1000000)
            
            file.readIntoBuffer(buff, error: &err)
            if err != nil {
                println(err)
            }
            player.scheduleBuffer(buff, atTime: nil, options: .Interrupts, completionHandler: nil)
            player.play()
        }
        else {
            println("Missing file \(note.name).m4a")
        }
    }
}