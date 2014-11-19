//
//  ViewController.swift
//  journal
//
//  Created by wuyangbing on 14/11/2.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var imv:UIView = UIView()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        AssetHelper.sharedAssetHelper()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.clearColor()
        view.userInteractionEnabled = true
        var (w,h) = (view.frame.size.width, view.frame.size.height)
        //var bg:myImageView = myImageView(name: "bg", scale: 2.0, frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y+7.5, width: view.frame.size.width, height: view.frame.size.height))
//        var bg:myImageView = myImageView(frame: CGRect(x: 0, y: 0, width: w, height: h), name: "bg", scale: 2.0)
        var bg:UIView = UIView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        bg.backgroundColor = UIColor.clearColor()
        bg.userInteractionEnabled = true
        view.addSubview(bg)
        
        var titleAndDes:InfoInput = InfoInput(frame: CGRect(x: 0, y: 0, width: w, height: 550.0/2.0))
        titleAndDes.tag = 401
        bg.addSubview(titleAndDes)
        var head:HeadInput = HeadInput(frame: CGRect(x: 36.0/2.0, y: 188.0/2.0, width: 120.0/2.0, height: 120.0/2.0))
        head.tag = 402
        bg.addSubview(head)
//        var pic:PicInput = PicInput(frame: CGRect(x: 0, y: 550.0/2.0, width: w, height: (80.0+120.0+24.0/2.0)/2.0))
//        bg.addSubview(pic)
//        var music:MusicInput = MusicInput(frame: CGRect(x: 0, y: 894.0/2.0, width: w, height: 140.0/2.0))
//        bg.addSubview(music)
        var music:MusicInput = MusicInput(frame: CGRect(x: 0, y: 550.0/2.0, width: w, height: 140.0/2.0))
        music.tag = 403
        bg.addSubview(music)
        var pic:PicInput = PicInput(frame: CGRect(x: 0, y: 675.0/2.0, width: w, height: (80.0+120.0+24.0/2.0)/2.0))
        pic.tag = 404
        bg.addSubview(pic)
    }
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "taphead", name: MSG_EDIT_HEAD, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tapimgs", name: MSG_EDIT_IMGS, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMy", name: MSG_MY_SHOW, object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_EDIT_IMGS, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_EDIT_HEAD, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_MY_SHOW, object: nil)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let sid = segue.identifier {
            if sid == "picSelect" {
                if let obj = (sender as? String) {
                    var imgView = segue.destinationViewController as ImgCollectionViewController
                    if obj == "head" {
                        imgView.maxCount = 1
                        let head = self.view.viewWithTag(402)!
                        imgView.delegate = head as HeadInput
                    }else if obj == "imgs" {
                        imgView.maxCount = 99
                        let imgs = self.view.viewWithTag(404)!
                        imgView.delegate = imgs as PicInput
                    }
                }
            }else{
                //mark 其他页面
            }
        }
    }
    func showMy(){
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("myShow"), userInfo: nil, repeats: false)
    }
    func myShow(){
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_BTN_NANE_FOR_LIST, object: nil)
        self.performSegueWithIdentifier("myshow", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func taphead(){
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_IMG_SELECT_SHOW, object: nil)
        self.performSegueWithIdentifier("picSelect", sender: "head")
    }
    func tapimgs(){
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_IMG_SELECT_SHOW, object: nil)
        self.performSegueWithIdentifier("picSelect", sender: "imgs")
    }
    func changeUIView4(){
        let path:UIBezierPath = UIBezierPath()
        let fromPoint = self.imv.center
        let toPoint = CGPoint(x: 280.0, y: 400.0)
        path .moveToPoint(fromPoint)
        path.addCurveToPoint(toPoint, controlPoint1: CGPoint(x: 0, y: 300), controlPoint2: CGPoint(x: 300, y: 0))
        let moveAnim:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        moveAnim.path = path.CGPath;
        moveAnim.removedOnCompletion = true
        
        let scaleAnim:CABasicAnimation = CABasicAnimation(keyPath: "transform")
        scaleAnim.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        scaleAnim.toValue = NSValue(CATransform3D: CATransform3DMakeScale(0.3,0.3,3.0))
        scaleAnim.removedOnCompletion = true
        
        let opacityAnim:CABasicAnimation = CABasicAnimation(keyPath: "alpha")
        opacityAnim.fromValue = NSNumber(float: 1.0)
        opacityAnim.toValue = NSNumber(float: 0.2)
        opacityAnim.removedOnCompletion = false
        
        let animGroup:CAAnimationGroup = CAAnimationGroup()
        animGroup.animations = [moveAnim,scaleAnim,opacityAnim]
        animGroup.duration = 1.0
        animGroup.removedOnCompletion = false
        animGroup.fillMode = kCAFillModeForwards
//        imv.layer.addAnimation(animGroup, forKey: "s")
    }
}

