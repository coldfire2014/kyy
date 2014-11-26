//
//  UserTableViewController.swift
//  journal
//
//  Created by wuyangbing on 14/11/11.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    let cellIdentifier = "CELL_ID"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: view.bounds.size.width, height: 128.0/2.0)))
        if let hv = self.tableView.tableHeaderView {
            hv.backgroundColor = UIColor.clearColor()
        }
        self.tableView.tableFooterView = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: view.bounds.size.width, height: 98.0/2.0)))
        if let fv = self.tableView.tableFooterView {
            fv.backgroundColor = UIColor.clearColor()
        }
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        view.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = .None
        self.tableView.registerClass(UserTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "back", name: MSG_BACK, object: nil)

    }
    var count_i:Int = 0
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool){
        count_i++
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        var index:Double = Double(indexPath.row)
        var th:Double = Double( UIScreen.mainScreen().bounds.size.height - 128.0/2.0 )
        var c = (cell as UserTableViewCell)
        if let bk = c.viewWithTag(502) {
            if th > index*192.0/2.0{
                let x = bk.frame.origin.x
                if true {
                    bk.frame.origin.x = 0.0
                    let moveAnim:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position.x")
                    moveAnim.values = []
                    if count_i <= Int(indexPath.row){
                        for i in 0..<Int(indexPath.row) {
                            moveAnim.values.append(-bk.frame.size.width/2.0)
                        }
                        moveAnim.values.append(-bk.frame.size.width/4.0)
                        moveAnim.values.append(bk.frame.size.width/4.0)
                        moveAnim.values.append(bk.frame.size.width/2.0+10.0)
                        moveAnim.values.append(bk.frame.size.width/2.0-3.6)
                        moveAnim.values.append(bk.frame.size.width/2.0+1.3)
                        moveAnim.values.append(bk.frame.size.width/2.0-0.4)
                        moveAnim.values.append(bk.frame.size.width/2.0+0.1)
                        moveAnim.values.append(bk.frame.size.width/2.0)
                        moveAnim.delegate = self
                    }else{
                        moveAnim.values.append(bk.frame.size.width/2.0)
                    }
                    moveAnim.removedOnCompletion = true
                    moveAnim.duration = (0.4 + index*0.1)
                    bk.layer.addAnimation(moveAnim, forKey: "s")
                    
                }else{
                    
                }
            }else{
                
            }
            bk.frame.origin.x = 0.0
        }
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MSG_BACK, object: nil)

    }
    func back(){
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_BTN_NANE_FOR_EDIT, object: nil)
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 19
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 192.0/2.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var celln : UserTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UserTableViewCell?
        if(celln == nil)
        {
            celln = UserTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL_ID")
        }
        if let cell = celln {
            
            cell.selectionStyle = .None
        }
        return celln! as UITableViewCell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
