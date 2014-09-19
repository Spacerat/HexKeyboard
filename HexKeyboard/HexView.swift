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
        for c in 0..<columns {
            for r in 0..<rows {
                let label = HexKey()
                self.addSubview(label)
                label.textAlignment = .Center
            }
        }
        self.accessibilityTraits = UIAccessibilityTraitAllowsDirectInteraction
        self.isAccessibilityElement = true
        self.multipleTouchEnabled = true
        self.accessibilityLabel = "Keyboard"
        backgroundColor = UIColor.whiteColor()
    }
    
    func iterateHexes(cb : (row:Int, column:Int, index:Int, hex: HexKey )->() ) {
        var i = 0;
        for c in 0..<columns {
            for r in 0..<rows {
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
                    hex.doPressAnimation()
                }
            }
        }
    }

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let t = touch as UITouch
            
            iterateHexes { (row, column, index, hex) -> () in
                if hex.pointInside(t.locationInView(hex), withEvent: nil) && !hex.pointInside(t.previousLocationInView(hex), withEvent: nil) {
                    self.delegate?.hexPressed(row, column: column)
                    hex.doPressAnimation()
                }
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
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
