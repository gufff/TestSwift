//
//  ViewController.swift
//  TestSwift
//
//  Created by retygu on 14-9-1.
//  Copyright (c) 2014年 retygu. All rights reserved.
//

import UIKit

let PRE_URL = "http://192.168.1.253:8088/yahinterface/"
let PRE_IMAGE_URL = "http://192.168.1.253:8809/"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetCheckProtocol, DataLoadProtocol, ImageLoadProtocol {
    
    var myTableView: UITableView!
    var dataArray : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var button:UIButton! = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(100, 100, 100, 100)
        button.backgroundColor = UIColor.redColor()
        self.view!.addSubview(button)
        
        var dataddArray = ["a", "b" , "c", "d", "e"]
        for i in 0..<dataddArray.count {
            println(dataddArray[i])
        }
        
        var emptyString = String()
        if emptyString.isEmpty {
            println("is empty")
        }
        
        var shoppingList: [String] = ["nana", "gaga"]
        shoppingList.append("haha")
        shoppingList.append("gege")
        
        for element in shoppingList {
            println(element)
            
        }
        
        for (index, element) in enumerate(shoppingList) {
            println(index, element)
        }
        
        // 数组
        var emptyList = Array<String>()
        emptyList += shoppingList
        println(emptyList)
        
        // 字典
        var emptyDictionary = Dictionary<String, String>()
        emptyDictionary["a"] = "12"
        let value = emptyDictionary["a"]
        println(value)

        var eng = Engine.defaultEngine() as Engine!
        eng.netpl = self
        eng.datapl = self
        eng.imagepl = self
        
        var urlString = PRE_URL + "app/noticeAdvertisementInterface/getIndexTjList?" + "1" + ""
        
        Engine.defaultEngine().asynchronousRequestWithUrl(urlString, withTag:requestTag.requestTagActivityDetail )

        dataArray = NSMutableArray()
        
        myTableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        myTableView.backgroundColor = UIColor.clearColor()
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.registerClass(ActivityTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(myTableView)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshViewNotification:", name: "refreshViewNotification", object: nil)
    }
    
    func refreshViewNotification(notification: NSNotification) {
        if notification.name == "refreshViewNotification" {
            var id = notification.object as String
            var alert = UIAlertView(title: "我返回啦", message: id, delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: === table view delegate
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if dataArray?.count > 0 {
            return dataArray!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 87
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {

        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as ActivityTableViewCell
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            if self.dataArray?.count > 0 {
                cell.typeLabel.text = "活动"
                var model = self.dataArray![indexPath.row] as ActivityModel
                cell.titleLabel.text = model.activityTitle
                var imageName = model.dynamicImg
                var image : UIImage! = UIImage(named: "activityDefault.png")
                if !model.dynamicImg!.isEmpty {
                    imageName = Common.getSmallImagePathWithPath(imageName);    //@"dynamicImg"
                    let localPath = NSHomeDirectory().stringByAppendingPathComponent("Library/Caches").stringByAppendingPathComponent(imageName!)
                    var img = UIImage(contentsOfFile: localPath)
                    
                    image = img
                }
                //图片处理
                var scaleImage = Common.handleImageForTableViewCell(image);
//                dispatch_sync(dispatch_get_main_queue(), {
                    cell.albumImageView.image = scaleImage
//                })
        }
            cell.albumImageView.frame = CGRectMake(cell.albumImageView.frame.origin.x, cell.albumImageView.frame.origin.y, cell.albumImageView.frame.size.width, 60);
//        })
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var detailViewController = DetailViewController()
        var model = dataArray![indexPath.row] as ActivityModel
        detailViewController.activityId = model.activityId
        self.navigationController .pushViewController(detailViewController, animated: true)
    }
    

    //MARK - ZHYNetCheck protocol delegate
    func netcheckFail(failData: String!, withTag tag: Int) {
        
    }
    
    //MARK - BCDataLoadProtocol
    func dataLoadSuccess(dataDic: [NSObject : AnyObject]!, withTag tag: requestTag) {
        if tag == requestTag.requestTagActivityDetail {
            var getDataArray = dataDic["list"] as NSArray
            
            if (getDataArray.count > 0) {
                for i in 0..<getDataArray.count {
                    var model = ActivityModel()
                    model.activityTitle = getDataArray[i]["dynamicTitle"] as? String
                    model.activityId = getDataArray[i]["dynamicId"] as? String
                    var imgNa = getDataArray[i]["dynamicImg"] as String
                    model.dynamicImg = getDataArray[i]["dynamicImg"] as? String
                    // 设置图片名
                    var imageName = getDataArray[i]["dynamicImg"] as String
                    if (!imageName.isEmpty) {
                        imageName = Common.getSmallImagePathWithPath(imageName);
                        let localPath = NSHomeDirectory().stringByAppendingPathComponent("Library/Caches").stringByAppendingPathComponent(imageName)
                        var img = UIImage(contentsOfFile: localPath)
                        if (!img.isKindOfClass(UIImage)) {
                            let imagePath = PRE_IMAGE_URL + Common.getSmallImagePathWithPath(getDataArray[i]["dynamicPath"] as String);
                            Engine.defaultEngine().downloadImage(imagePath, withLocalName: imageName, withRequestTag: 1 )
                        }
                    }
                    dataArray?.addObject(model)
                }
                myTableView.reloadData()
            }
        }
        
    }
    
    func dataLoadFail(errMessage: String!, withTag tag: requestTag) {
    
    }
    
    func refreshImageWithTag(requestTag: Int) {
        myTableView.reloadData()
    }
    
    deinit {
        (Engine.defaultEngine() as Engine).datapl = nil;
        (Engine.defaultEngine() as Engine).netpl = nil;
        (Engine.defaultEngine() as Engine).imagepl = nil;
        Engine.defaultEngine().cancelAsynchronousRequest();
        Engine.defaultEngine().cancelDownloadImages();

    }

}

