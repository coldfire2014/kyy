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
protocol ImgCollectionViewDelegate : NSObjectProtocol {
    func didSelectAssets(items:Array<ALAsset>)
    func ownAssets()->Array<ALAsset>
}
class ImgCollectionViewController: UICollectionViewController {
    var isShow = true
    weak var delegate: ImgCollectionViewDelegate?
    var m_w:Double = 0;
    var needAnimation = true
    var assert:AssetHelper = AssetHelper.sharedAssetHelper()
    var sections:Array<NSDictionary> = [];
    var cells:Array<Array<ALAsset>> = [];
    var maxCount = 1
    var selectItems:Array<ALAsset> = [];
    var selectIndexs:Array<NSIndexPath> = [];
    override func viewDidLoad() {
        super.viewDidLoad()

        var w = UIScreen.mainScreen().bounds.size.width
        var h = UIScreen.mainScreen().bounds.size.height
        m_w = (Double(w)-6.0)/4.0
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        self.view.frame = CGRect(origin: CGPointZero, size: CGSize(width: view.frame.width, height: h))
        // Register cell classes
        self.collectionView.registerClass(ImgCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.registerClass(imgGroupView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier:hIdentifier)
        self.collectionView.registerClass(imgGroupView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter, withReuseIdentifier:fIdentifier)
        self.view.backgroundColor = UIColor.clearColor()//UIColor(red: 220.0/255.0, green: 248.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.frame = CGRect(origin: CGPoint(x: 0, y: 128.0/2.0), size: CGSize(width: collectionView.frame.width, height: h - 128.0/2.0))// - 98.0/2.0
        
        initDate()
        assert.bReverse = true
        self.collectionView.allowsMultipleSelection = true
        self.collectionView.clipsToBounds = false
        // Do any additional setup after loading the view.
        
        //加了已经有的以后
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_SET_BADGE, object: collectionView.indexPathsForSelectedItems()?.count)
        
    }

    func handleEnterForeground(noc:NSNotification){
        initDate()
    }
    
    func initDate(){
        if let sels = self.delegate?.ownAssets() {
            var c=sels.count
            selectItems = sels
        }
        
        assert.getGroupList { (aGroups: [AnyObject]!) -> Void in
            var g_count = aGroups.count
            NSLog("%@",aGroups as NSArray)
            
            self.reloadData()

        }
//        assert.getSavedPhotoList({ (imgs:[AnyObject]!) -> Void in
//            NSLog("%@",imgs as NSArray)
//            self.cells = (imgs as NSArray)
//            self.reloadData()
//            }, error: { (err:NSError!) -> Void in
//            
//        })
    }
    func reloadData(){
        var gc = assert.getGroupCount()
        sections.removeAll(keepCapacity: true)
        cells.removeAll(keepCapacity: true)
        for i in 0..<gc {
            var group = assert.getGroupInfo(i) as NSDictionary
            var groupCount = group["count"] as Int
            if groupCount > 0 {
                sections.append(group)
                assert.getPhotoListOfGroupByIndex(i, result: { (imgs:[AnyObject]!) -> Void in
                    self.cells.append(imgs as Array<ALAsset>)
                })
            }
        }
        self.collectionView.reloadData()
        if needAnimation {
            isShow = true
            var t:CATransform3D = CATransform3DIdentity
            t.m34 = -1.0/900.0;
            let moveAnim:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
            moveAnim.values = [NSValue(CATransform3D: CATransform3DTranslate(t, 0, 0, -600)),NSValue(CATransform3D: CATransform3DTranslate(t, 0, 0, 216)),NSValue(CATransform3D: CATransform3DTranslate(t, 0, 0, -78)),NSValue(CATransform3D: CATransform3DTranslate(t, 0, 0, 24)),NSValue(CATransform3D: CATransform3DTranslate(t, 0, 0, -6)),NSValue(CATransform3D: t)];
            moveAnim.removedOnCompletion = false
            let opacityAnim:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnim.fromValue = NSNumber(float: 0.0)
            opacityAnim.toValue = NSNumber(float: 1.0)
            opacityAnim.removedOnCompletion = false
            
            let animGroup:CAAnimationGroup = CAAnimationGroup()
            animGroup.animations = [moveAnim,opacityAnim]
            animGroup.duration = 0.5
            animGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animGroup.removedOnCompletion = false
            animGroup.fillMode = kCAFillModeForwards
            animGroup.delegate = self
            collectionView.layer.addAnimation(animGroup, forKey: "s")
        }
    }
    override func animationDidStop(anim:CAAnimation ,finished flag:Bool){
        if isShow {
            for index in selectIndexs {
                self.collectionView.selectItemAtIndexPath(index,animated:false, scrollPosition:UICollectionViewScrollPosition.None)
            }
            if let ips = self.collectionView.indexPathsForSelectedItems() {
                selectItems.removeAll(keepCapacity: false)
                selectIndexs.removeAll(keepCapacity: false)
                NSNotificationCenter.defaultCenter().postNotificationName(MSG_SET_BADGE, object: ips.count)
            }
        }else{
            NSNotificationCenter.defaultCenter().postNotificationName(MSG_SET_BADGE, object: 0)
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                if self.isOK {
                    if let ips = self.collectionView.indexPathsForSelectedItems(){
                        var als:Array<ALAsset> = []
                        for indexPath in ips {
                            var ar = self.cells[indexPath.section] as Array<ALAsset>
                            var al = ar[indexPath.row] as ALAsset
                            als.append(al)
                        }
                        if als.count > 0 {
                            self.delegate?.didSelectAssets(als)
                        }
                    }
                }
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "back", name: MSG_BACK, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "backWithOK", name: MSG_IMGS_OK, object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_BACK, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_IMGS_OK, object: nil)
//        if (_nResultType == DO_PICKER_RESULT_UIIMAGE)
        assert.clearData()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    func backWithOK(){
        isOK = true
    }
    var isOK = false
    func back(){
        isShow = false
        if needAnimation {
            var t:CATransform3D = CATransform3DIdentity
            t.m34 = -1.0/900.0;
            let moveAnim:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
            moveAnim.values = [NSValue(CATransform3D: CATransform3DTranslate(t, 0, 0, 0)),NSValue(CATransform3D: CATransform3DTranslate(t, 0, 0, 600))];
            moveAnim.removedOnCompletion = false
            let opacityAnim:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnim.fromValue = NSNumber(float: 1.0)
            opacityAnim.toValue = NSNumber(float: 0.0)
            opacityAnim.removedOnCompletion = false
            
            let animGroup:CAAnimationGroup = CAAnimationGroup()
            animGroup.animations = [opacityAnim,moveAnim]
            animGroup.duration = 0.5
            animGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animGroup.removedOnCompletion = false
            animGroup.fillMode = kCAFillModeForwards
            animGroup.delegate = self
            collectionView.layer.addAnimation(animGroup, forKey: "stop")
        }else{
            NSNotificationCenter.defaultCenter().postNotificationName(MSG_SET_BADGE, object: 0)
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                if self.isOK {
                    if let ips = self.collectionView.indexPathsForSelectedItems(){
                        var als:Array<ALAsset> = []
                        for indexPath in ips {
                            var ar = self.cells[indexPath.section] as Array<ALAsset>
                            var al = ar[indexPath.row] as ALAsset
                            als.append(al)
                        }
                        if als.count > 0 {
                            self.delegate?.didSelectAssets(als)
                        }
                    }
                }
            })
        }
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
        NSLog("sections=%d" ,sections.count as Int)
        return sections.count as Int
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return sections[section]["count"] as Int
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as ImgCollectionViewCell
        var ar = self.cells[indexPath.section] as Array<ALAsset>
        var al = ar[indexPath.row] as ALAsset
        var img = assert.getImageFromAsset( al, type:Int(ASSET_PHOTO_THUMBNAIL) )
        if let imgv = cell.viewWithTag(202) {
            (imgv as myImageView).image = img
        }
        cell.index = indexPath
        cell.asset = al
        cell.maxCount = self.maxCount
        cell.checkSelect()
        if selectItems.count > 0{
            for item in selectItems {
                if al.description == item.description {
                    selectIndexs.append(indexPath)
                    cell.setSelect()
                }
            }
        }
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) -> Void {
//        var ar = self.cells[indexPath.section] as Array<ALAsset>
//        var al = ar[indexPath.row] as ALAsset
//        
//        var cell = collectionView.cellForItemAtIndexPath(indexPath)!
//        var local = cell.center
//        var width = cell.frame.width
//        var img = assert.getImageFromAsset( al, type:Int(ASSET_PHOTO_SCREEN_SIZE) )
//        var iwidth = img.size.width
//        var iheight = img.size.height
//        if let imgv = cell.viewWithTag(875) {
//            (imgv as myImageView).image = img
//        }
    }
    
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    override func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
            
            if kind == UICollectionElementKindSectionHeader{
                let headerView:imgGroupView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader,
                    withReuseIdentifier:hIdentifier,
                    forIndexPath: indexPath) as imgGroupView
                var upgView:UIImageView = UIImageView(frame: CGRect(origin: CGPointZero, size: headerView.frame.size))
                //        upgView.backgroundColor = UIColor.blackColor()
                upgView.image = myImageView.getShadowImage(CGRect(origin: CGPointZero, size: headerView.frame.size))
                headerView.addSubview(upgView)
                var s = sections[indexPath.section]["name"] as String
                var c = sections[indexPath.section]["count"] as Int
                headerView.title.text = ""+s+" 共 \(c) 张照片"
                headerView.bringSubviewToFront(headerView.title)
                return headerView
            }else{
                let footerView:imgGroupView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter,
                    withReuseIdentifier:fIdentifier,
                    forIndexPath: indexPath) as imgGroupView
                var s = sections[indexPath.section]["name"] as String
                var c = sections[indexPath.section]["count"] as Int
                footerView.title.text = ""+s+" 共 \(c) 张照片"
                footerView.title.textAlignment = .Center
                var upgView:UIImageView = UIImageView(frame: CGRect(origin: CGPointZero, size: footerView.frame.size))
                //        upgView.backgroundColor = UIColor.blackColor()
                upgView.image = myImageView.getShadowImage(CGRect(origin: CGPointZero, size: footerView.frame.size))
                footerView.addSubview(upgView)
                footerView.bringSubviewToFront(footerView.title)
                return footerView
            }
    }
    func collectionView(collectionView: UICollectionView,layout:UICollectionViewLayout,referenceSizeForHeaderInSection:Int) ->CGSize{
        var f = UIScreen.mainScreen().bounds.size;
        return CGSizeZero//CGSize(width:f.width,height:48.0/2.0)
        
    }
    func collectionView(collectionView: UICollectionView,layout:UICollectionViewLayout,referenceSizeForFooterInSection:Int) ->CGSize{
        var f = UIScreen.mainScreen().bounds.size;
        return CGSize(width:f.width,height:80.0/2.0)
        
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
