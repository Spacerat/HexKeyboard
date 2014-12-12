//
//  Player.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 02/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import Foundation
import AVFoundation
//import CoreAudioKit
//
//class Synth : NotePlayer {
//    let engine : AVAudioEngine
//    let mixer : AVAudioMixerNode
//    let channels = 20
//    var players : [AVAudioPlayerNode]
//    var buffs : [String : AVAudioPCMBuffer]
//    init() {
//        engine  = AVAudioEngine()
//        mixer = AVAudioMixerNode()
//
//        self.players = [AVAudioPlayerNode]()
//        engine.attachNode(mixer)
//        for i in 0..<channels {
//            let player = AVAudioPlayerNode()
//            players.append(player)
//            engine.attachNode(player)
//            engine.connect(player, to: mixer, format: nil)
//        }
//
//        engine.connect(mixer, to: engine.outputNode, format: nil)
//        
//        var err : NSErrorPointer = nil
//        engine.startAndReturnError(err)
//        
//        if err != nil {
//            println(err)
//        }
//        
//        buffs = [String:AVAudioPCMBuffer]()
//        
//        for name in map(0..<12, {Note(index: $0).name}) {
//            let bundleUrl = NSBundle.mainBundle().URLForResource("\(name)", withExtension: "m4a")
//            if let url = bundleUrl {
//                var err : NSError?
//                let file = AVAudioFile(forReading: url, error: &err)
//                
//                println(err?.description)
//                
//                if err != nil {
//                    println(err)
//                }
//                let buff = AVAudioPCMBuffer(PCMFormat: AVAudioFormat(standardFormatWithSampleRate: 44000, channels: 2), frameCapacity: 1000000)
//                
//                file.readIntoBuffer(buff, error: &err)
//                if err != nil {
//                    println(err)
//                }
//                buffs[name] = buff
//            }
//            else {
//                println("Missing file \(name).m4a")
//            }
//        }
//    }
//    
//    func scheduleFirstPlayerWith(buffer buff : AVAudioPCMBuffer) {
//        if let player = players.last {
//            player.scheduleBuffer(buff, atTime: nil, options: .Interrupts, completionHandler: nil)
//            player.play()
//            players.removeLast()
//            players.insert(player, atIndex: 0)
//        }
//    }
//    
//    func play(note: Note) {
//        if let buff = self.buffs[note.name] {
//            scheduleFirstPlayerWith(buffer: buff)
//        }
//    }
//    
//    func release(note: Note) {
//        // Unimplimented
//    }
//    
//    convenience required init(name:String) {
//        self.init()
//    }
//}


