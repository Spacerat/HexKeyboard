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
    let channels = 20
    var players : [AVAudioPlayerNode]
    init() {
        engine  = AVAudioEngine()
        mixer = AVAudioMixerNode()

        self.players = [AVAudioPlayerNode]()
        engine.attachNode(mixer)
        for i in 0..<channels {
            let player = AVAudioPlayerNode()
            players.append(player)
            engine.attachNode(player)
            engine.connect(player, to: mixer, format: nil)
        }

        engine.connect(mixer, to: engine.outputNode, format: nil)
        
        var err : NSErrorPointer = nil
        engine.startAndReturnError(err)
        
        if err != nil {
            println(err)
        }
    }
    
    func scheduleFirstPlayerWith(buffer buff : AVAudioPCMBuffer) {
        
        //if let player = players.filter({ p in return !p.playing }).first {
        if let player = players.last {
            player.scheduleBuffer(buff, atTime: nil, options: .Interrupts, completionHandler: nil)
            player.play()
            players.removeLast()
            players.insert(player, atIndex: 0)
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

            scheduleFirstPlayerWith(buffer: buff)
//            player.scheduleBuffer(buff, atTime: nil, options: .Interrupts, completionHandler: nil)
            
        }
        else {
            println("Missing file \(note.name).m4a")
        }
    }
}