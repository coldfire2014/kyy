//
//  UserTableViewCell.swift
//  journal
//
//  Created by wuyangbing on 14/11/11.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    var title = UILabel()
    var des = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        var f = UIScreen.mainScreen().bounds.size;
        var mark = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 36.0/2.0), size: CGSize(width: f.width, height: 156.0/2.0)))
        mark.tag = 501
        mark.backgroundColor = UIColor(white: 0, alpha: 0.2)
        mark.alpha = 0
        self.addSubview(mark)
        var bk = UIView(frame: mark.frame)
        bk.tag = 502
        bk.backgroundColor = UIColor(white: 1, alpha: 0.5)
        var icon = myImageView(frame: CGRect(x: 24.0/2.0, y: 18.0/2.0, width: 120.0/2.0, height: 120.0/2.0), name: "180@2x", scale: 2.0)
        bk.addSubview(icon)
        self.addSubview(bk)
        
        title.frame = CGRect(x: 168.0/2.0, y: 32.0/2.0, width: frame.size.width-200.0/2.0, height: 20.0)
        title.font = UIFont.systemFontOfSize(15)
        title.textAlignment = .Left
        title.textColor = UIColor(white: 0, alpha: 0.5)
        title.backgroundColor = UIColor.clearColor()
        title.text = "何为神话"
        bk.addSubview(title)
        
        des.frame = CGRect(x: 168.0/2.0, y: 66.0/2.0, width: frame.size.width-200.0/2.0, height: bk.frame.size.height - 66.0/2.0)
        des.font = UIFont.systemFontOfSize(12)
        des.textAlignment = .Left
        des.textColor = UIColor(white: 0, alpha: 0.5)
        des.backgroundColor = UIColor.clearColor()
        des.numberOfLines = 3
        des.text = "生活就是在平淡中寻求人生热情哦,生活就是在平淡中寻求人生热情哦"
        bk.addSubview(des)
        bk.frame.offset(dx: 10, dy: 0)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func set
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if let mark = self.viewWithTag(501) {
            if selected {
                self.bringSubviewToFront(mark)
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    mark.alpha = 1
                })
            }else{
                if let bk = self.viewWithTag(502) {
                    self.bringSubviewToFront(bk)
                }
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    mark.alpha = 0
                })
                
            }
        }
        // Configure the view for the selected state
    }

}
