//
//  HexKey.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 02/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import UIKit

class HexKey : UILabel {
    
    let shape = CAShapeLayer()
    
    var baseColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.4).CGColor
    
    override init() {
        super.init()
        self.opaque = false
        self.layer.addSublayer(shape)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override var frame : CGRect {
        get {
            return super.frame
        }
        set {
            super.frame = newValue
            let rect = CGRect(origin: CGPointZero, size: newValue.size)
            shape.path = UIBezierPath(hexagonWithSize: rect.size).CGPath
            let newbounds = CGPathGetBoundingBox(shape.path)
            shape.fillColor = baseColor
        }
    }
    
    override var text : String? {
        didSet {
            if text?.rangeOfString("#") != nil || text?.rangeOfString("b") != nil {
                baseColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).CGColor
                shape.fillColor = baseColor
            }
        }
    }

    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return CGPathContainsPoint(shape.path, nil, point, true)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func doPressAnimation() {
        let animation = CABasicAnimation(keyPath: "fillColor")
        animation.duration = 0.5
        animation.fromValue = UIColor(red: 255, green: 255, blue: 0, alpha: 0.4).CGColor
        animation.toValue = baseColor
        animation.repeatCount = 1
        animation.autoreverses = false
        shape.addAnimation(animation, forKey: "fillColor")
    }
}
