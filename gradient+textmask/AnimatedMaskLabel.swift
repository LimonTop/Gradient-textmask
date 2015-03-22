//
//  AnimatedMaskLabel.swift
//  gradient+textmask
//
//  Created by Marin Todorov on 8/4/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit
import QuartzCore
import CoreText

class AnimatedMaskLabel: UIView {
  
  var gradientLayer: CAGradientLayer = CAGradientLayer()
  var text = "Slide to reveal"
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    //set the background color
    backgroundColor = UIColor.clearColor()
    clipsToBounds = true

    gradientLayer.frame = CGRect(x: -bounds.size.width, y: bounds.origin.y, width: 3 * bounds.size.width, height: bounds.size.height)
    // 子区域
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0,y: 0.5)

    var colors = [
        UIColor.blackColor().CGColor, // 背景颜色
        UIColor.whiteColor().CGColor,
        UIColor.blackColor().CGColor // 背景颜色
    ]

    // 而locations并不是表示颜色值所在位置,它表示的是颜色在Layer坐标系相对位置处要开始进行渐变颜色了
    var locations = [0.25,0.5,0.75] // 这里关系不大，重要的是toValue,不过设置成这样，到此，就可看出gradientLayer的渐变效果


    gradientLayer.colors = colors
    gradientLayer.locations = locations
    layer.addSublayer(gradientLayer)

    // CAGradientLayer的四个属性 colors locations startPoint endPoint 都可以动画
    let gradientAnimation = CABasicAnimation(keyPath: "locations")
    gradientAnimation.fromValue = [0,0,0.25] // 注意是滑动location,此处的意思是从0.25开始
    gradientAnimation.toValue = [0.65,1.0,1.0]  // 0->0.65, 0->1, 0.25->1
    gradientAnimation.duration = 3.0
    gradientAnimation.repeatCount = 1_000
    gradientAnimation.removedOnCompletion = false
    gradientAnimation.fillMode = kCAFillModeForwards

    gradientLayer.addAnimation(gradientAnimation, forKey: nil)

    let actualFont = UIFont(name: "HelveticaNeue-Thin", size: 28.0)
    let textStyle =  NSMutableParagraphStyle()
    textStyle.alignment = .Center

    let textFontAttributes = NSMutableDictionary()
    textFontAttributes[NSFontAttributeName] = actualFont
    textFontAttributes[NSParagraphStyleAttributeName] = textStyle

    // 创建画布Mask
    UIGraphicsBeginImageContext(frame.size)

    // 绘画
    text.drawInRect(bounds, withAttributes: textFontAttributes as [NSObject : AnyObject])

    // 取出作品
    let image = UIGraphicsGetImageFromCurrentImageContext()

    // 销毁画布
    UIGraphicsEndImageContext()

    let maskLayer = CALayer()
    maskLayer.backgroundColor = UIColor.clearColor().CGColor
    maskLayer.frame = CGRectOffset(bounds, bounds.size.width, 0)
    maskLayer.contents = image.CGImage

    // 在mask上挖文字的洞
    gradientLayer.mask = maskLayer


  }
  
}
