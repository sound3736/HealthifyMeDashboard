//
//  UpDownButton.swift
//  HealthifyMeDashboard
//
//  Created by Dhwani Thaker on 3/20/16.
//  Copyright © 2016 Dhwani Thaker. All rights reserved.
//

import UIKit

class UpDownButton : UIButton
{
    // Images
    let upButtonImage = UIImage(named: "up")! as UIImage
    let downButtonImage = UIImage(named: "down")! as UIImage
    
    // Bool property
    var isClicked: Bool = false {
        didSet{
            if isClicked == true {
                self.setImage(upButtonImage, forState: .Normal)
            } else {
                self.setImage(downButtonImage, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.isClicked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            if isClicked == true {
                isClicked = false
            } else {
                isClicked = true
            }
        }
    }
    
}
