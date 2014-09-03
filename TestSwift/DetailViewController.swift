//
//  DetailViewController.swift
//  TestSwift
//
//  Created by retygu on 14-9-2.
//  Copyright (c) 2014年 retygu. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, DataLoadProtocol, NetCheckProtocol, ImageLoadProtocol {
    var activityId: String!
    var contentLabel:UILabel!
    
    override func viewDidLoad() {
        self.navigationItem.title = "详情"
        
        var backButton : UIButton! = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        backButton.frame = CGRectMake(0, 7, 40, 35.0)
        backButton.setImage(UIImage(named: "back.png"), forState: UIControlState.Normal)
        backButton.addTarget(self, action: "backAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var backItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backItem;
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        contentLabel = UILabel(frame: CGRectMake(0, 100, self.view.frame.size.width, 400))
        contentLabel.textColor = UIColor.redColor()
        self.view.addSubview(contentLabel)
        
        
        var eng = Engine.defaultEngine() as Engine!
        eng.netpl = self
        eng.datapl = self
        eng.imagepl = self
        
        var member_id = "F8416ED6E360B90CE040007F0100059D"
        var urlString = PRE_URL + GET_NEWS_DETAIL + "infoId=\(self.activityId)&userId=\(member_id)"
        Engine.defaultEngine().asynchronousRequestWithUrl(urlString, withTag: requestTag.requestTagActivityJoinMember)
    }
    
    func backAction(button:UIButton) {
        self.navigationController.popViewControllerAnimated(true)
    }
    
    
    //MARK - ZHYNetCheck protocol delegate
    func netcheckFail(failData: String!, withTag tag: Int) {
        
    }
    
    //MARK - BCDataLoadProtocol
    func dataLoadSuccess(dataDic: [NSObject : AnyObject]!, withTag tag: requestTag) {
//        var getDataArray = dataDic["list"] as NSArray
        var str = dataDic["talkContent"] as NSString
        contentLabel.text = str
        
    }
    
    func dataLoadFail(errMessage: String!, withTag tag: requestTag) {
        
    }
    
    func refreshImageWithTag(requestTag: Int) {
//        myTableView.reloadData()
    }
    
    deinit {
        println("delloc")
        NSNotificationCenter.defaultCenter().postNotificationName("refreshViewNotification", object: contentLabel.text)
        
        (Engine.defaultEngine() as Engine).datapl = nil;
        (Engine.defaultEngine() as Engine).netpl = nil;
        (Engine.defaultEngine() as Engine).imagepl = nil;
        Engine.defaultEngine().cancelAsynchronousRequest();
        Engine.defaultEngine().cancelDownloadImages();
        
    }
    
    
}
