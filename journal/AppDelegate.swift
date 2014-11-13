//
//  AppDelegate.swift
//  journal
//
//  Created by wuyangbing on 14/11/2.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var bottom: BottomView?
    var top: NavView?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
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
        top = NavView(frame: CGRect(x: 0, y: 0, width: f.width, height: 128.0/2.0));
        bottom?.changeTitle(true)
        var bg:myImageView = myImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: f), name: "bg", scale: 2.0)
        window?.addSubview(bg)
        
        return true
    }
    func imgsShow(){
        bottom?.show(false)
        top?.change2img()
    }
    func imgsHide(){
        bottom?.show(true)
        top?.change2edit()
    }
    func bottomNametolist(){
        bottom?.changeTitle(false)
    }
    func bottomNametoedit(){
        bottom?.changeTitle(true)
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_IMG_SELECT_SHOW, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_IMG_SELECT_HIDE, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_BTN_NANE_FOR_LIST, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_BTN_NANE_FOR_EDIT, object: nil)
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "imgsShow", name: MSG_IMG_SELECT_SHOW, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "imgsHide", name: MSG_IMG_SELECT_HIDE, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "bottomNametolist", name: MSG_BTN_NANE_FOR_LIST, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "bottomNametoedit", name: MSG_BTN_NANE_FOR_EDIT, object: nil)
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

