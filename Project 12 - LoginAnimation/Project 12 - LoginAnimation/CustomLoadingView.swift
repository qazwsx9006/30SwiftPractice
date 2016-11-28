//
//  CustomLoadingView.swift
//  Project 12 - LoginAnimation
//
//  Created by SHUN on 11/28/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class  CustomLoadingView  {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private let replicatorLayer = CAReplicatorLayer()
    
    private var loadingMaskView : UIView?
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    init(){
         print("\(self.dynamicType) init")
    }
    
    deinit{
        print("\(self.dynamicType) deinit")
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    func show( ) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let keyWindow = appDelegate.window!
     
        let mainScreen = UIScreen.mainScreen()
        
        let side : CGFloat  = 160
        
        let startX = ( mainScreen.bounds.size.width - side ) / 2
        let startY = ( mainScreen.bounds.size.height - side ) / 2
        
        let path = CGPathCreateMutable() // 创建转圈的动画
        CGPathAddEllipseInRect(path, nil, CGRectMake( startX  , startY  , side , side ))
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 4
        animationGroup.repeatCount = .infinity
        
        let positionformAnim = CAKeyframeAnimation(keyPath: "position")
        positionformAnim.duration = 4
        positionformAnim.repeatCount = HUGE
        positionformAnim.path = path
        positionformAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 0.5
        scaleAnimation.duration = 2
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        //        let transformAnim = CABasicAnimation(keyPath: "transform")
        //        transformAnim.duration = 2
        //        transformAnim.repeatCount = HUGE
        //        transformAnim.fromValue = NSValue.init(CATransform3D: CATransform3DMakeScale(1, 1, 1))
        //        transformAnim.toValue = NSValue.init(CATransform3D: CATransform3DMakeScale(0.7, 0.7, 0.1))

        animationGroup.animations = [ positionformAnim , scaleAnimation ]
        
        
        let animationLayer = CAShapeLayer()
        animationLayer.backgroundColor = UIColor.whiteColor().CGColor
        animationLayer.bounds = CGRectMake(0, 0, 20, 20)
        animationLayer.cornerRadius = 10
        animationLayer.addAnimation(animationGroup, forKey: nil)
        
        
        replicatorLayer.addSublayer(animationLayer);
        replicatorLayer.repeatCount = HUGE
        replicatorLayer.instanceCount = 6
        replicatorLayer.instanceDelay = 0.2
        replicatorLayer.instanceColor = UIColor.blackColor().CGColor
        replicatorLayer.instanceRedOffset = 0.0
        replicatorLayer.instanceGreenOffset = 0.0
        replicatorLayer.instanceBlueOffset = 0.0
        replicatorLayer.instanceAlphaOffset = -0.1
        
        loadingMaskView = UIView(frame: CGRectMake(0, 0, mainScreen.bounds.width, mainScreen.bounds.height))
        loadingMaskView!.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        keyWindow.addSubview(loadingMaskView!)
        keyWindow.layer.addSublayer(replicatorLayer)
        
    }
    
    func remove() {
        if let loadingView = self.loadingMaskView{
            replicatorLayer.sublayers?.forEach({
                $0.sublayers?.forEach({
                    $0.removeAllAnimations()
                    $0.removeFromSuperlayer()
                })
                
                $0.removeAllAnimations()
                $0.removeFromSuperlayer()
            })
            
            replicatorLayer.removeFromSuperlayer()
            loadingView.removeFromSuperview()
        }
        

    }
}