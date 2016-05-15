//
//  ImageCollectionViewController.swift
//  GetYourGuide
//
//  Created by Shalom Shwaitzer on 13/05/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.

import Alamofire
import UIKit
import SDWebImage
import Refresher
import SwiftyJSON
import MBProgressHUD

class ActivityCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let CELL_IDENTIFIER    = "activityCell"
    
    let POPULAR: Int       = 0
    let SEARCH_ACTIVITY: Int = 6
    
    var requestType: Int?
    
    var parentNavigationController: UINavigationController?
    
    var activities = [Activity]()
    
    var populatingPhotos = false
    var currentPage      = 1
    var totalPage        = 2
    
    var lastContentOffsetY: CGFloat = CGFloat(0)
    var itemWidth: CGFloat!
    
    let manager = NetworkReachabilityManager(host: "www.getyourguide.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        populateActivities()
    }
    
    func setupViews() {
        
        
        manager?.listener = { status in
            print("Network Status Changed: \(status)")
        }
        
        manager?.startListening()
        
        self.itemWidth = SCREEN_WIDTH/2.0
        
        let layout = EBCardCollectionViewLayout()
        layout.layoutType = .Horizontal
        layout.offset     = UIOffsetMake(40, 10)
        
        // UICollectionView setup
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        
        
        self.view.addSubview(collectionView)
    }
    
    func populateActivities() {
        if self.currentPage >= self.totalPage {
            return
        }
        
        let request: Router = Router.PopularActivities("berlin")
        
        if populatingPhotos {
            return
        }
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "Loading..."
        
        populatingPhotos = true
        Router.manager.request(request)
            .responseJSON { response in
                
                guard let json = response.result.value else {
                    self.populatingPhotos = false
                    return
                }
                
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                    
                    let lastItem = self.activities.count
                    
                    if let list = Activity.arrayFromRawJSON(json) {
                    
                        for match in list{
                            if let newActivity = Activity(match: match) {
                                self.activities.append(newActivity)
                            }
                        }
                    }
                    
                    let indexPaths = (lastItem..<self.activities.count).map { NSIndexPath(forItem: $0, inSection: 0)}
                    dispatch_async(dispatch_get_main_queue()) {
                        self.collectionView.insertItemsAtIndexPaths(indexPaths)
                        hud.hide(true)
                    }
                    
                    self.currentPage += 1
                    self.populatingPhotos = false
                }
                
        }
    }
    
    
    
    
    // MARK: UIScrollView
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y + view.frame.size.height > scrollView.contentSize.height {
            
            if self.currentPage >= self.totalPage {
                return
            }
            populateActivities()
        }
    }
    
    
    // MARK: UICollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.activities.count
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailVC = UIStoryboard.detailActivityViewController()!
        
        let activityInfo = self.activities[indexPath.item]
        detailVC.activity = activityInfo
        //detailVC.imageHeight = calc image height
        
        parentNavigationController!.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CELL_IDENTIFIER, forIndexPath: indexPath) as! ActivityTableViewCell
        
        let activity = self.activities[indexPath.item]
        cell.bindDataBy(activity)
    
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let photo = self.activities[indexPath.item]
//        let itemHeight = (photo.height * self.itemWidth) / photo.width
//        return CGSize(width: self.itemWidth, height: itemHeight)
//    }
}
