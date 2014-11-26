//
//  AppDelegate.swift
//  journal
//
//  Created by wuyangbing on 14/11/2.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit
/*弹性阻尼参数*/
let springDampPars:[Double] = [1,-0.36,0.13,-0.04,0.01,0]

enum BarShowType : Int {
    case OnlyNav
    case OnlyTool
    case All
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate{
    var scene: WXScene = WXSceneSession
    var window: UIWindow?
    var bottom: BottomView?
    var top: NavView?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        var path = NSBundle.mainBundle().pathForResource("Info", ofType:"plist")
////        path = [[NSBundle mainBundle] pathForResource:@"info" ofType:"plist"];
//        if let resources = NSDictionary(contentsOfFile:path!) {
//            NSLog("%@",resources["CFBundleIdentifier"]! as String )
//        }
//        NSLog("%@",NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleIdentifier") as String )
        // Override point for customization after application launch.
        // ========================testRealm========================
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        self.window!.rootViewController = UINavigationController(rootViewController: TableViewController(style: .Plain))
//        self.window!.makeKeyAndVisible()
        // ========================testRealm========================
        
        // ========================AFNetworking========================
//        var h:httpManager = httpManager();
//        h.testPost()
        // ========================AFNetworking========================
        
        // ========================BaiduMobStat========================
        let statTracker:BaiduMobStat = BaiduMobStat.defaultStat()
        statTracker.enableExceptionLog = true // 是否允许截获并发送崩溃信息，请设置YES或者NO
        statTracker.channelId = "inhouse"//设置您的app的发布渠道
        //    statTracker.channelId = @"appstore";
        statTracker.logStrategy = BaiduMobStatLogStrategyDay//根据开发者设定的发送策略,发送日志
        statTracker.logSendInterval = 1  //为1时表示发送日志的时间间隔为1小时,当logStrategy设置为BaiduMobStatLogStrategyCustom时生效
        statTracker.logSendWifiOnly = true //是否仅在WIfi情况下发送日志数据
        statTracker.sessionResumeInterval = 30//设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s
        statTracker.shortAppVersion = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion") as String
        //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
        statTracker.enableDebugOn = false //调试的时候打开，会有log打印，发布时候关闭
        statTracker.startWithAppId("93df1a4dcc")
        // ========================BaiduMobStat========================
        var f = UIScreen.mainScreen().bounds.size;
        bottom = BottomView(frame: CGRect(x: 0, y: f.height-98.0/2.0, width: f.width, height: 98.0/2.0));
        if let bn = bottom {
            bn.changeTitle("新建杂志")
        }
        
        top = NavView(frame: CGRect(x: 0, y: 0, width: f.width, height: 128.0/2.0));
        if let wn = window {
            let bg = UIView(frame: CGRect(origin: CGPointZero, size: f))
            bg.backgroundColor = UIColor.clearColor()
            let layer:CAGradientLayer = CAGradientLayer()
            layer.frame = bg.frame
            layer.colors = [UIColor(red: 209.0/255.0, green: 231.0/255.0, blue: 227.0/255.0, alpha: 1).CGColor,
                            UIColor(red: 204.0/255.0, green: 224.0/255.0, blue: 245.0/255.0, alpha: 1).CGColor]
            layer.startPoint = CGPoint(x: 1, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
            bg.layer.addSublayer(layer)
            wn.addSubview(bg)
//            wn.rootViewController = ViewController()
        }
        WXApi.registerApp(WX_APPID, withDescription: "kyy")
        return true
    }
    
    func imgsShow(){
        if let bn = bottom {
            bn.show(false)
        }
        if let tn = top {
            tn.change2img()
        }
    }
    func imgsHide(){
        if let bn = bottom {
            bn.show(true)
        }
    }
    func bottomNametolist(){
        if let bn = bottom {
            bn.changeTitle("编辑杂志")
        }
    }
    func bottomNametoedit(){
        if let bn = bottom {
            bn.changeTitle("新建杂志")
        }
    }
    func bottomNameClean(){
        if let bn = bottom {
            bn.changeTitle("")
        }
    }
    func tapSetup(noc:NSNotification){
        var s = noc.object as String
        if let tn = top {
            tn.doSetupBy(s)
        }
    }
    func hideBar(noc:NSNotification){
        var only:BarShowType = BarShowType(rawValue: noc.object as Int)!
        switch only {
        case .OnlyNav:
            if let tn = top {
                tn.show(false)
            }
        case .OnlyTool:
            if let bn = bottom {
                bn.show(false)
            }
        default:
            if let bn = bottom {
                bn.show(false)
            }
            if let tn = top {
                tn.show(false)
            }
        }
    }
    func showBar(noc:NSNotification){
        var only:BarShowType = BarShowType(rawValue: noc.object as Int)!
        switch only {
        case .OnlyNav:
            if let tn = top {
                tn.show(true)
            }
        case .OnlyTool:
            if let bn = bottom {
                bn.show(true)
            }
        default:
            if let bn = bottom {
                bn.show(true)
            }
            if let tn = top {
                tn.show(true)
            }
        }
    }
    func setGadge(noc:NSNotification){
        var i:Int = noc.object as Int
        if let tn = top {
            tn.imgCount(i)
        }
    }
    func gobackall(){
        var v = UIStoryboard(name: "Main", bundle: nil)
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        if let wn = window {
            wn.makeKeyAndVisible()
            wn.backgroundColor = UIColor.blackColor()
            wn.rootViewController = nil
            wn.rootViewController = v.instantiateInitialViewController() as ViewController
        }
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_BAR_SHOW, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_BAR_HIDE, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_IMG_SELECT_SHOW, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_IMG_SELECT_HIDE, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_SETUP_DESELECT, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_BTN_NANE_FOR_LIST, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_BTN_NANE_FOR_EDIT, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_ALERT, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_SET_BADGE, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_GOBACK_ALL, object: nil)
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gobackall", name: MSG_GOBACK_ALL, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "alert:", name: MSG_ALERT, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showBar:", name: MSG_BAR_SHOW, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideBar:", name: MSG_BAR_HIDE, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setGadge:", name: MSG_SET_BADGE, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "imgsShow", name: MSG_IMG_SELECT_SHOW, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "imgsHide", name: MSG_IMG_SELECT_HIDE, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tapSetup:", name: MSG_SETUP_DESELECT, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "bottomNametolist", name: MSG_BTN_NANE_FOR_LIST, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "bottomNametoedit", name: MSG_BTN_NANE_FOR_EDIT, object: nil)
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func alert(noc:NSNotification){
        var s = noc.object as String
        StatusBar.shareInstance().talkMsg(s, time: 0.8)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        var isSuc = WXApi.handleOpenURL(url, delegate: self)
        NSLog("url=%@", url)
        return isSuc
    }
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        var isSuc = WXApi.handleOpenURL(url, delegate: self)
        NSLog("url=%@", url)
        return isSuc
    }
    func onReq(req: BaseReq!) {
        var str = req.classForCoder.description()
        if let range = str.rangeOfString("GetMessageFromWXReq")   {
            NSLog("微信请求App提供内容=%@", req)
        }else if let range = str.rangeOfString("ShowMessageFromWXReq")   {
            NSLog("微信请求App显示内容=%@", (req as ShowMessageFromWXReq).message)
        }else if let range = str.rangeOfString("LaunchFromWXReq")   {
            NSLog("微信请求App启动内容=%@", req)
        }
    }
    func onResp(resp: BaseResp!) {
        var str = resp.classForCoder.description()
        if let range = str.rangeOfString("SendMessageToWXResp")   {
            if 0 == resp.errCode {
                
                NSLog("分享成功，%@", (resp as SendMessageToWXResp).lang)
                StatusBar.shareInstance().talkMsg("分享成功", time: 0.5)
            }else{
                StatusBar.shareInstance().talkMsg(resp.errStr, time: 0.8)
            }
        }else{
            if 0 == resp.errCode {
                //开始登陆微信《提示等待》
                getOpenIDfromWX((resp as SendAuthResp).code)
            }else{
                StatusBar.shareInstance().talkMsg(resp.errStr, time: 0.8)
            }
        }
    }
    
    func getOpenIDfromWX(code:String){
        var h:httpManager = httpManager();
        h.loginWX(code)
    }
}

