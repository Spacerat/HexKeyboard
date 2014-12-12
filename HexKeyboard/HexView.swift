//
//  HexView.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 02/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import UIKit

protocol HexViewDelegate : class {
    func hexNameForRow(row: Int, column: Int) -> String
    func hexPressed(row:Int, column: Int)
    func hexReleased(row:Int, column: Int)
    func shouldHoldKeys() -> Bool
}

class HexView: UIView {
    var columns = 9;
    var rows = 4;
    weak var delegate : HexViewDelegate? {
        didSet {
            self.refreshLabels()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init() {
        super.init()
        self.accessibilityTraits = UIAccessibilityTraitAllowsDirectInteraction
        self.isAccessibilityElement = true
        self.multipleTouchEnabled = true
        self.accessibilityLabel = "Keyboard"
        backgroundColor = UIColor.whiteColor()
        createKeys()
    }
    
    func createKeys() {

        for hex in self.subviews {
            hex.removeFromSuperview()
        }

        for c in -1..<columns+1 {
            for r in -1..<rows+1 {
                let label = HexKey()
                self.addSubview(label)
                label.textAlignment = .Center
            }
        }
    }

    func iterateHexes(cb : (row:Int, column:Int, index:Int, hex: HexKey )->() ) {
        var i = 0;
        for c in -1..<columns+1 {
            for r in -1..<rows+1 {
                let hex = hexes[i]
                cb(row: r, column: c, index: i, hex: hex)
                i++;
            }
        }
    }
    
    var hexes : [HexKey] {
        get { return self.subviews as [HexKey] }
    }
    
    func refreshLabels() {
        var i = 0
        if let del = delegate {
            self.iterateHexes { (row, column, index, hex) -> () in
                hex.text = del.hexNameForRow(row, column: column)
                i+=1
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let t = touch as UITouch
            iterateHexes { (row, column, index, hex) -> () in
                if hex.pointInside(t.locationInView(hex), withEvent: nil) {
                    self.delegate?.hexPressed(row, column: column)
                    hex.doPressAnimation(hold: self.delegate?.shouldHoldKeys() ?? false)
                }
            }
        }
    }

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let t = touch as UITouch
            
            iterateHexes { (row, column, index, hex) -> () in
                
                let in_now = hex.pointInside(t.locationInView(hex), withEvent: nil)
                let in_pre = hex.pointInside(t.previousLocationInView(hex), withEvent: nil)
                
                if in_now && !in_pre {
                    self.delegate?.hexPressed(row, column: column)
                    hex.doPressAnimation(hold: self.delegate?.shouldHoldKeys() ?? false)
                }
                if in_pre && !in_now {
                    self.delegate?.hexReleased(row, column: column)
                    hex.releaseAnimation()
                }
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let t = touch as UITouch
            iterateHexes { (row, column, index, hex) -> () in
                if hex.pointInside(t.locationInView(hex), withEvent: nil) {
                    self.delegate?.hexReleased(row, column: column)
                    hex.releaseAnimation()
                }
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.rows = Int((floor(frame.height / 66)))
        self.columns = Int(floor(frame.width / 55))
        createKeys()
        refreshLabels()
        
        let hexHeight = frame.height / (0.5+CGFloat(self.rows));
        let hexWidth = (frame.width / (CGFloat(self.columns)*3.0+1))*4.0
        
        let overlap :CGFloat = 18.0
        let offset : CGFloat = overlap / 2.0
        var i = 0
        
        self.iterateHexes { (r, c, i, hex) -> () in
            let x = CGFloat(c) * hexWidth*0.75 - offset;
            let y = CGFloat(r) * hexHeight + CGFloat(c%2)*hexHeight/2.0 - offset;
            let w = hexWidth + overlap
            let h = hexHeight + overlap
            hex.frame = CGRect(x: x, y: y, width: w, height: h)
        }
    }
}
