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
        return 0.3
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        autoreleasepool { () -> () in
            var toView:UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            var fromView:UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            if self.isPresent {
                transitionContext.containerView().addSubview(toView.view)
                toView.view.alpha = 0.1
                toView.view.transform = CGAffineTransformMakeScale(0.5, 0.5)
                UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                    toView.view.transform = CGAffineTransformIdentity
                    toView.view.alpha = 1.0
                    fromView.view.alpha = 0.0
                    }, completion: { (Bool) -> Void in
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                })
            }else{
                transitionContext.containerView().addSubview(fromView.view)
                toView.view.transform = CGAffineTransformIdentity
                toView.view.alpha = 0.1
                UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                    fromView.view.transform = CGAffineTransformMakeScale(0.5, 0.5)
                    fromView.view.alpha = 0.0
                    toView.view.alpha = 1.0
                    }, completion: { (Bool) -> Void in
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                })
            }
        }
    }
}
