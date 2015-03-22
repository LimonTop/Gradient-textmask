//
//  ViewController.swift
//  gradient+textmask
//
//  Created by Marin Todorov on 8/4/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var slideView: AnimatedMaskLabel!
    @IBOutlet weak var cycleView: AnimateMaskCircle!
    @IBOutlet var time: UILabel!


    override func viewDidLoad() {


        // setup gesture recognizer
        //
        let swipe = UISwipeGestureRecognizer(target: self, action: "didSlide")
        swipe.direction = .Right
        slideView.addGestureRecognizer(swipe)
    }

    func didSlide() {
        println("Did slide!")

        let image = UIImageView(image: UIImage(named: "meme"))
        image.center = view.center
        image.center.x += view.bounds.size.width
        view.addSubview(image)

        UIView.animateWithDuration(0.33, delay: 0.0, options: nil, animations: {

            self.time.center.y -= 200.0
            self.slideView.center.y += 200.0
            image.center.x -= self.view.bounds.size.width

            }, completion: nil)

        UIView.animateWithDuration(0.33, delay: 1.0, options: nil, animations: {
            self.time.center.y += 200.0
            self.slideView.center.y -= 200.0
            image.center.x += self.view.bounds.size.width
            
            }, completion: {_ in
                image.removeFromSuperview()
        })
        
    }

}

