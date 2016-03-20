//
//  RadialProgressView.swift
//  HealthifyMeDashboard
//
//  Created by Dhwani Thaker on 3/20/16.
//  Copyright © 2016 Dhwani Thaker. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

@IBDesignable
public class RadialProgressView: UIView {
    
    @IBInspectable public var hideBackgroundPath: Bool = false
    
    @IBInspectable public var animationDuration: Double = 1.5 {
        didSet {
            updateLayoutProperties()
        }
    }
    
    @IBInspectable public var lineWidth: Float = 5 {
        didSet {
            updateLayoutProperties()
        }
    }
    
    @IBInspectable public var innerColor: UIColor = UIColor(rgb: 0x719fbb) {
        didSet {
            updateLayoutProperties()
        }
    }
    
    @IBInspectable public var outerColor: UIColor = UIColor(rgb: 0x00607E) {
        didSet {
            updateLayoutProperties()
        }
    }
    
    @IBInspectable public var progress: Float = 0.5 {
        didSet {
            animateProgress()
        }
    }
    
    public var innerView: UIView? {
        didSet {
            if let v = oldValue {
                v.removeFromSuperview()
            }
            updateLayoutProperties()
        }
    }
    
    var emptyProgressLayer: CAShapeLayer!
    var innerProgressLayer: CAShapeLayer!
    var innerFillLayer: CAShapeLayer!
    
    override public func layoutSubviews() {
        self.backgroundColor = nil
        if innerFillLayer == nil {
            innerFillLayer = createBaseShapeLayer(UIColor(red: 210/255, green: 228/255, blue: 243/255, alpha: 0.5), width: lineWidth*9.5)
            layer.addSublayer(innerFillLayer)
            
        }
        
        if !hideBackgroundPath && emptyProgressLayer == nil {
            emptyProgressLayer = createBaseShapeLayer(UIColor(red: 109/255.0, green: 153/255.0, blue: 182/255.0, alpha: 1.0), width: lineWidth * 2)
            layer.addSublayer(emptyProgressLayer)
            
        }
        
        if innerProgressLayer == nil {
            innerProgressLayer = createBaseShapeLayer(innerColor, width: lineWidth*2)
            layer.addSublayer(innerProgressLayer)
        }
        
        updateLayoutProperties()
        animateProgress()
    }
    
    func createBaseShapeLayer(color: UIColor, width: Float) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.contentsScale = UIScreen.mainScreen().scale
        layer.frame = bounds
        layer.fillColor = nil
        layer.strokeColor = color.CGColor
        layer.lineWidth = CGFloat(width)
        layer.transform = CATransform3DMakeRotation(-90.0 / 180.0 * CGFloat(M_PI), 0.0, 0.0, 1.0);
        return layer
    }
    
    func animateProgress() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = progress
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        if innerProgressLayer != nil {
            self.innerProgressLayer.strokeEnd = CGFloat(progress)
            self.innerProgressLayer.addAnimation(animation, forKey: nil)
        }
    }
    
    func updateLayoutProperties() {
        let rect = CGRectInset(bounds, CGFloat(lineWidth)/2 , CGFloat(lineWidth)/2 )
        let inset = CGFloat(lineWidth)
        
        if emptyProgressLayer != nil {
            let path = UIBezierPath(ovalInRect: CGRectInset(rect, inset, inset))
            self.emptyProgressLayer.lineDashPattern = [0,self.bounds.width / 60]
            self.emptyProgressLayer.lineJoin = kCALineJoinMiter
            self.emptyProgressLayer.lineDashPhase = 1.0
            self.emptyProgressLayer.path = path.CGPath
        }
        
        if innerProgressLayer != nil {
            let path = UIBezierPath(ovalInRect: CGRectInset(rect, inset, inset))
            innerProgressLayer.path = path.CGPath
            innerProgressLayer.strokeEnd = CGFloat(progress)
        }
        
        if innerFillLayer != nil {
            let path = UIBezierPath(ovalInRect: CGRectInset(bounds, CGFloat(lineWidth)*5.2, CGFloat(lineWidth)*5.2))
            innerFillLayer.path = path.CGPath
            
        }
        
        if let innerView = self.innerView {
            let height = (CGRectGetHeight(self.frame) - CGFloat(lineWidth * 2))/2
            let width = (CGRectGetWidth(self.frame) - CGFloat(lineWidth * 2))/2
            let edge = sqrt(2) * min(height , width)
            innerView.frame = CGRectIntegral(CGRect(x: 0, y: 0, width: edge, height: edge))
            innerView.center = CGPoint(x: CGRectGetMidX(self.bounds), y: CGRectGetMidY(self.bounds))
            
            self.addSubview(innerView)
        }
        
        
    }
}