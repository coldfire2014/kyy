//
//  picSelectSegue.swift
//  journal
//
//  Created by wuyangbing on 14/11/24.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class picSelectSegue: UIStoryboardSegue{
    override func perform() {
        var svc = self.sourceViewController as ViewController
        var dvc = self.destinationViewController as UIViewController
        dvc.modalPresentationStyle = .Custom
        dvc.transitioningDelegate = svc
        svc .presentViewController(dvc, animated: true) { () -> Void in
            
        }
    }
}
