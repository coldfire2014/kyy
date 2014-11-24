//
//  httpManager.swift
//  journal
//
//  Created by wuyangbing on 14/11/3.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import Foundation

class httpManager: NSObject {

    let APIBaseURLString:String = "http://115.29.228.218/invitation/nozzle/"
    let WX_URL:String = "https://api.weixin.qq.com/sns/"
    func apiClient()->AFHTTPRequestOperationManager{
        var client = AFHTTPRequestOperationManager(baseURL: NSURL(string: APIBaseURLString))
        client.requestSerializer = AFJSONRequestSerializer() as AFHTTPRequestSerializer
        client.securityPolicy = AFSecurityPolicy(pinningMode: AFSSLPinningMode.None)
        return client
    }
    
    func testPostimg(){
        let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager(baseURL: NSURL(string: APIBaseURLString))
        manager.POST("NefImages/uploads.aspx", parameters: nil, constructingBodyWithBlock: { (fromData:AFMultipartFormData!) -> Void in
            let fileUrl:UIImage = UIImage(named: "1.jpg")!
            let jtdata:NSData = UIImageJPEGRepresentation(fileUrl, 0.3)
            fromData.appendPartWithFileData(jtdata, name: "files", fileName: "one.jpg", mimeType: "image/jpeg")
            }, success: { (opt:AFHTTPRequestOperation!, obj:AnyObject!) -> Void in
            println("\(obj)")
            }) { (opt:AFHTTPRequestOperation!, err:NSError!) -> Void in
            println("\(err.localizedDescription)")
        }
    }
    func testPost(){
        var dic = ["timestamp":"-1","size":"-1",]
        apiClient().POST("NefTemplate/template.aspx", parameters: dic, success: { (opt:AFHTTPRequestOperation!, json:AnyObject!) -> Void in
            println("\(json)")
            }, failure: { (opt:AFHTTPRequestOperation!, err:NSError!) -> Void in
                println("\(err.localizedDescription)")
        })
    }
    func loginWX(code:String){
        var url_s = "\(WX_URL)oauth2/access_token?appid=\(WX_APPID)&secret=\(WX_SECRET)&code=\(code)&grant_type=authorization_code"
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            var err:NSError?
            var data_s = NSString(contentsOfURL: NSURL(string: url_s)!, encoding: NSUTF8StringEncoding, error: &err)
            if let e = err {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    StatusBar.shareInstance().talkMsg("登录失败了，再试试吧。", time: 0.8)
                })
            }else{
                var data = data_s?.dataUsingEncoding(NSUTF8StringEncoding)
                var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                var h:httpManager = httpManager()
                h.getWXInfo(jsonResult.objectForKey("access_token") as String, openid: jsonResult.objectForKey("openid") as String)
            }
        })
    }
    func getWXInfo(token:String,openid:String){
        var url_s = "\(WX_URL)userinfo?access_token=\(token)&openid=\(openid)"
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            var err:NSError?
            var data_s = NSString(contentsOfURL: NSURL(string: url_s)!, encoding: NSUTF8StringEncoding, error: &err)
            if let e = err {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    StatusBar.shareInstance().talkMsg("获取信息失败了，再试试吧。", time: 0.8)
                })
            }else{
                var data = data_s?.dataUsingEncoding(NSUTF8StringEncoding)
                var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                  关闭登陆微信《提示等待》
                    StatusBar.shareInstance().talkMsg("成功登录微信。", time: 0.5)
                })
//                存储信息
                NSLog("微信信息=%@", jsonResult)
            }
        })
    }
}
