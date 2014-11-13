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
//    let a = (8,"999")
//    let b = ("0","0","9")
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

}
