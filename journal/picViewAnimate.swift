//
//  picViewAnimate.swift
//  journal
//
//  Created by wuyangbing on 14/11/24.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class picViewAnimate:NSObject, UIViewControllerAnimatedTransitioning{
    var isPresent = true
    init(p:Bool) {
        isPresent = p
    }
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        autoreleasepool { () -> () in
            var toView:UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            var fromView:UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            var t:CATransform3D = CATransform3DIdentity
            t.m34 = -1.0/900.0;
            if self.isPresent {
                transitionContext.containerView().addSubview(toView.view)
                toView.view.layer.opacity = 0.1
                toView.view.layer.transform = CATransform3DTranslate(t, 0, 0, -600)
                UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                    toView.view.layer.transform = t
                    toView.view.layer.opacity = 1.0
                    fromView.view.layer.opacity = 0.0
                    }, completion: { (Bool) -> Void in
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                })
            }else{
                transitionContext.containerView().addSubview(fromView.view)
                toView.view.layer.transform = t
                toView.view.layer.opacity = 0.1
                UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                    fromView.view.layer.transform = CATransform3DTranslate(t, 0, 0, 600)
                    fromView.view.layer.opacity = 0.0
                    toView.view.layer.opacity = 1.0
                    }, completion: { (Bool) -> Void in
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                })
            }
        }
    }
}
