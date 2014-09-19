//
//  UIBezierPath+Hexagon.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 19/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import UIKit

extension UIBezierPath {
    convenience init(hexagonWithSize size: CGSize) {
        self.init()
        let w = size.width
        let h = size.height
        
        moveToPoint(CGPoint(x: 0, y: h*0.5))
        addLineToPoint(CGPoint(x: 0.25*w, y: h))
        addLineToPoint(CGPoint(x: 0.75*w, y: h))
        addLineToPoint(CGPoint(x: w, y: 0.5*h))
        addLineToPoint(CGPoint(x: 0.75*w, y: 0))
        addLineToPoint(CGPoint(x: 0.25 * w, y: 0))
        closePath()
    }
}

