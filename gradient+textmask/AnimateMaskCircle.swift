//
//  AnimateMaskCycle.swift
//  Slide to reveal
//
//  Created by catch on 15/3/22.
//  Copyright (c) 2015年 Underplot ltd. All rights reserved.
//

import UIKit
import QuartzCore

class AnimateMaskCircle: UIView {

    private let gradientLayer = CAGradientLayer()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        backgroundColor = UIColor.clearColor()
        clipsToBounds = true

        setupGradientLayer()

    }

    private func setupGradientLayer() {
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: bounds.origin.y, width: 3 * bounds.size.width, height: bounds.size.height)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0,y: 0.5)

        let colors = [
            UIColor.darkGrayColor().CGColor, // 背景色
            UIColor.whiteColor().CGColor,
            UIColor.darkGrayColor().CGColor
        ]
        let locations = [0.25,0.5,0.75]
        
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        layer.addSublayer(gradientLayer)

        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0,0,0.25] // 注意是滑动location,此处的意思是从0.25开始
        gradientAnimation.toValue = [0.65,1.0,1.0]  // 0->0.65, 0->1, 0.25->1
        gradientAnimation.duration = 3.0
        gradientAnimation.repeatCount = 1_000
        gradientAnimation.removedOnCompletion = false
        gradientAnimation.fillMode = kCAFillModeForwards
        gradientLayer.addAnimation(gradientAnimation, forKey: nil)


        let circleMaskLayer = CAShapeLayer()
        let circleRect = CGRectInset(bounds, 10, 10)
        circleMaskLayer.path = UIBezierPath(ovalInRect: circleRect).CGPath // path决定形状, UIBezierPath的ovalInRect创建圆形path
        circleMaskLayer.strokeColor = UIColor.redColor().CGColor // 此处颜色无用
        circleMaskLayer.fillColor = UIColor.clearColor().CGColor
        circleMaskLayer.lineWidth = 2.0
        circleMaskLayer.frame = CGRectOffset(bounds, bounds.size.width, 0) // 需frame
        gradientLayer.mask = circleMaskLayer

        // 不需要添加到layer
//        layer.addSublayer(circleMaskLayer)




    }

}
