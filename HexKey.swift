//
//  HexKey.swift
//  HexKeyboard
//
//  Created by Joseph Atkins-Turkish on 02/09/2014.
//  Copyright (c) 2014 Joseph Atkins-Turkish. All rights reserved.
//

import UIKit

class HexKey : UILabel {

    override init() {
        super.init()
        self.layer.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.4).CGColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func doPressAnimation() {
        self.layer.backgroundColor = UIColor(red: 100, green: 0, blue: 255, alpha: 0.4).CGColor
        UIView.animateWithDuration(0.5, animations: {
            self.layer.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.4).CGColor
        })

    }
}
