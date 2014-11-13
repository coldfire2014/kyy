//
//  ImgCollectionViewController.swift
//  journal
//
//  Created by wuyangbing on 14/11/12.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

let reuseIdentifier = "imgcell"
let hIdentifier = "imgcellh"
let fIdentifier = "imgcellf"
class ImgCollectionViewController: UICollectionViewController {
    var m_w:Double = 0;
    var assert:AssetHelper = AssetHelper.sharedAssetHelper()
    var sections:Array<NSDictionary> = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        var w = UIScreen.mainScreen().bounds.size.width;
        m_w = (Double(w)-3.0)/4.0
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true

        // Register cell classes
        self.collectionView.registerClass(ImgCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.registerClass(imgGroupView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier:hIdentifier)
        self.collectionView.registerClass(imgGroupView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter, withReuseIdentifier:fIdentifier)
        self.view.backgroundColor = UIColor(white: 0.7, alpha: 1.0)
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.frame = CGRect(origin: CGPoint(x: 0, y: 128.0/2.0), size: CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 128.0/2.0))// - 98.0/2.0
        
        initDate()
        assert.bReverse = true;
        // Do any additional setup after loading the view.
    }

    func handleEnterForeground(noc:NSNotification){
        initDate()
    }
    
    func initDate(){
        assert.getGroupList { (aGroups: [AnyObject]!) -> Void in
            var g_count = aGroups.count
            NSLog("%@",aGroups as NSArray)

            self.reloadData()

        }
    }
    func reloadData(){
        var gc = assert.getGroupCount()
        for i in 0..<gc {
            var group = assert.getGroupInfo(i) as NSDictionary
            var groupCount = group["count"] as Int
            if groupCount > 0 {
                sections.append(group)
            }
        }
        self.collectionView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "back", name: MSG_BACK, object: nil)
        
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_BACK, object: nil)
//        if (_nResultType == DO_PICKER_RESULT_UIIMAGE)
        assert.clearData()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    func back(){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

//     MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return sections.count as Int
    }

//    override func collectionView(collectionView: UICollectionView, v

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return sections[section]["count"] as Int
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,layout:UICollectionViewLayout,referenceSizeForFooterInSection:Int) ->CGSize{
        var f = UIScreen.mainScreen().bounds.size;
        return CGSize(width:f.width,height:36.0/2.0)
        
    }
    override func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
            
            if kind == UICollectionElementKindSectionHeader{
                let headerView:imgGroupView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader,
                    withReuseIdentifier:hIdentifier,
                    forIndexPath: indexPath) as imgGroupView
                var s = sections[indexPath.section]["name"] as String
                headerView.title.text = s
                return headerView
            }else{
                let footerView:imgGroupView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter,
                    withReuseIdentifier:fIdentifier,
                    forIndexPath: indexPath) as imgGroupView
                var s = sections[indexPath.section]["count"] as Int
                footerView.title.text = "共 \(s) 张照片"
                footerView.title.textAlignment = .Center
                return footerView
            }
    }
    func collectionView(collectionView: UICollectionView,layout:UICollectionViewLayout,referenceSizeForHeaderInSection:Int) ->CGSize{
        var f = UIScreen.mainScreen().bounds.size;
        return CGSize(width:f.width,height:48.0/2.0)
        
    }
    func collectionView(collectionView: UICollectionView,layout:UICollectionViewLayout,minimumInteritemSpacingForSectionAtIndex:NSIndexPath) ->CGFloat{
        
        return 0
        
    }
    func collectionView(collectionView: UICollectionView,layout:UICollectionViewLayout,minimumLineSpacingForSectionAtIndex:NSIndexPath) ->CGFloat{
        
        return 1.0
        
    }
    func collectionView(collectionView: UICollectionView,layout:UICollectionViewLayout,sizeForItemAtIndexPath:NSIndexPath) ->CGSize{
        
        return CGSize(width:m_w,height:m_w)
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
