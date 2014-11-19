//
//  PicInput.swift
//  journal
//
//  Created by wuyangbing on 14/11/10.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class PicInput: UIView ,ImgCollectionViewDelegate{
    var imgs:Array<ALAsset> = [];
    func didSelectAssets(items:Array<ALAsset>){
        imgs = items
        var count = imgs.count
        if count > 8 {
            count = 8
        }
        for i in 0..<count
        {
            let headAdd = self.viewWithTag(302+i)!
            (headAdd as PicView).changeimg(imgs[i])
        }
        
    }
    func ownAssets()->Array<ALAsset>{
        return imgs
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        userInteractionEnabled = true
//        self.backgroundColor = UIColor.grayColor()
        var titled:UILabel = UILabel()
        titled.frame = CGRect(x: 36.0/2.0, y: 0.0/2.0, width: frame.size.width, height: 80.0/2.0)
        titled.font = UIFont.systemFontOfSize(12)
        titled.textAlignment = .Left
        titled.textColor = UIColor(red: 188.0/255.0, green: 194.0/255.0, blue: 202.0/255.0, alpha: 1 )
        titled.backgroundColor = UIColor.clearColor()
        titled.text = "添加图片"
        self.addSubview(titled)
        for i in 0..<8
        {
            var w:CGFloat = 120.0/2.0 + (frame.size.width - 36.0 - 4.0*120.0/2.0)/3.0
            var k = i % 4
            var j = i / 4
            var headAdd:PicView = PicView(frame: CGRect(x: 36.0/2.0 + CGFloat(k) * w, y: 80.0/2.0 + CGFloat(j) * (24.0/2.0 + 120.0/2.0), width: 120.0/2.0, height: 120.0/2.0))
            headAdd.tag = 302+i
            self.addSubview(headAdd)
            var panGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapimgs")
            headAdd.addGestureRecognizer(panGesture)
        }
    }
    
    func tapimgs(){
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_EDIT_IMGS, object: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
