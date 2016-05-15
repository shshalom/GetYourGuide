//
//  DetailActivityViewController.swift
//  GetYourGuide
//
//  Created by Shalom Shwaitzer on 13/05/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.


import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage
import MBProgressHUD
import SCLAlertView

class DetailActivityViewController: UIViewController,FloatRatingViewDelegate {
    let CELL_TITLE_HEADER  = "titleHeader"
    let CELL_REVIEW_HEADER = "reviewsHeader"
    let ACTIVITY_INFO_CELL = "activityInfoCell"
    let CELL_IDENTIFIER    = "reviewCell"
    
    var imageView: UIImageView?
    @IBOutlet weak var tableView: UITableView!
    
    var activity: Activity!
    
    var totalReviewItems = 0
    var currentPage = 1
    var totalPages = 2
    var fetchReview = false
    
    var imageHeight:CGFloat = 0
    var reviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = activity.activityId

        setupViews()
        requestReviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func setupViews() {
        // image view & MBProgressHUD
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200))
        self.imageView?.contentMode = .ScaleAspectFill

        // table view
        //self.tableView = UITableView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        //self.tableView?.dataSource         = self
        //self.tableView?.delegate           = self
        self.tableView?.separatorStyle     = .None
        self.tableView?.estimatedRowHeight = 72
        self.tableView?.rowHeight          = UITableViewAutomaticDimension
        
        self.tableView?.tableHeaderView    = imageView
        
        self.tableView?.contentInset       = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        
        // display image
        self.imageView?.sd_setImageWithURL(NSURL(string: self.activity.thumbURL))
//        let sdWebImageManager = SDWebImageManager.sharedManager()
//        sdWebImageManager.downloadImageWithURL(NSURL(string: self.activity.thumbURL),
//            options: .LowPriority,
//            progress: { (receiveSize, expectSize) in
//                dispatch_async(dispatch_get_main_queue(), {
//                    //TODO: image load progress
//                })
//            },
//            completed: {[weak self] (image, error, cached, finished, url) in
//                if let wSelf = self {
//                    dispatch_async(dispatch_get_main_queue(), {
//                        wSelf.imageView!.image = image
//                        //TODO: image load finish
//                    })
//                }
//            })
        

        
    }
    
    func requestReviews() {
        if self.currentPage >= self.totalPages {
            return
        }
        
        if self.fetchReview {
            return
        }
        
        fetchReview = true
        
        Router.manager.request(Router.Reviews(self.activity, self.currentPage, 0))
            .responseSwiftyJSON { response in
                
                guard let json = response.result.value else {
                    self.fetchReview = false
                    return
                }
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if let totalReviews = json["total_reviews"].int {
                        //self.currentPage = 0
                        self.totalPages = totalReviews/Review.REVIEWS_PER_PAGE
                    }
                    
                    for (_, subJson): (String, JSON) in json["data"] {
                        
                        let review = Review(data: subJson)!
                        self.reviews.append(review)
                        
                    }
                    self.tableView?.reloadData()
                    self.currentPage += 1
                })

                self.fetchReview = false
        }
    }
    
    // MARK: ScrollView
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y + view.frame.size.height > scrollView.contentSize.height {
            requestReviews()
        }
    }
    
    func addReviewTapped() {
        if !Account.checkIsLogin() {
            let alert = UIAlertController(title: nil, message: NSLocalizedString("LOGIN_MESSAGE", comment: "loginMessage"), preferredStyle: UIAlertControllerStyle.Alert)
            
            let alertConfirm = UIAlertAction(title: NSLocalizedString("CONFIRM", comment: "confirm"), style: UIAlertActionStyle.Default) { alertConfirm in
                //self.presentViewController(UINavigationController(rootViewController: AuthViewController()), animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: NSLocalizedString("CANCEL", comment: "cancel"), style: UIAlertActionStyle.Cancel) { (cancle) -> Void in
                
            }
            
            alert.addAction(alertConfirm)
            alert.addAction(cancel)
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        showAlert()

    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert() {
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false
        )
        
        
        
        // Initialize SCLAlertView using custom Appearance
        let alert = SCLAlertView(appearance: appearance)
        
       
        // Creat the subview
        let subview = UIView(frame: CGRectMake(0,0,216,70))
        let x = (subview.frame.width/2 - 100)
        
        // Add textfield 1
        let textfield1 = UITextField(frame: CGRectMake(x,10,200,25))
        textfield1.layer.borderColor = UIColor.colorScheme.navigationBarColor().CGColor
        textfield1.layer.borderWidth = 1
        textfield1.layer.cornerRadius = 0
        textfield1.placeholder = "Write Review"
        textfield1.textAlignment = NSTextAlignment.Center
        subview.addSubview(textfield1)
        
        
        let ratingView = FloatRatingView(frame: CGRect(x: x,y: textfield1.frame.maxY + 10,width: 200,height: 25))
        
        ratingView.emptyImage = UIImage(named: "StarEmpty")
        ratingView.fullImage = UIImage(named: "StarFull")
        // Optional params
        ratingView.delegate = self
        ratingView.contentMode = UIViewContentMode.ScaleAspectFit
        ratingView.maxRating = 5
        ratingView.minRating = 1
        ratingView.rating = 2.5
        ratingView.editable = true
        ratingView.halfRatings = true
        ratingView.floatRatings = false
        
        subview.addSubview(ratingView)
        
        
        
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        alert.addButton(NSLocalizedString("Add", comment: "add"), backgroundColor:UIColor.colorScheme.navigationBarColor()) {
            if let reviewBody = textfield1.text {
                
                                Alamofire.request(Router.AddReview(self.activity, reviewBody, ratingView.rating))
                                    .responseSwiftyJSON { response in
                
                                }
            }
        }
        
        alert.addButton(NSLocalizedString("Cancel", comment: "cancel"), backgroundColor:UIColor.colorScheme.navigationBarColor()) {
            alert.hideView()
        }
        
        alert.showInfo("Write A Review", subTitle: "")
       
    }
    
    func floatRatingView(ratingView: FloatRatingView, didUpdate rating: Float) {
        //self.updatedLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    
}


extension DetailActivityViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.reviews.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        var identifier = ACTIVITY_INFO_CELL
        if indexPath.section == 1 {
            identifier = CELL_IDENTIFIER
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell
        if let infoCell = cell as? ActivityInfoTableViewCell {
            infoCell.selectionStyle = .None
            infoCell.bindDataBy(self.activity)
            
            //infoCell.likeBtn.addTarget(self, action: "votePhoto:", forControlEvents: .TouchUpInside)
            infoCell.share.addTarget(self, action: #selector(addReviewTapped), forControlEvents: .TouchUpInside)
            //infoCell.more.addTarget(self, action: "moreTapped", forControlEvents: .TouchUpInside)
            
        }
        
        if let reviewCell = cell as? ReviewTableViewCell {
            if indexPath.row % 2 == 0 {
                reviewCell.backgroundColor = UIColor(red: 251.0/255.0, green: 251.0/255.0, blue: 251.0/255.0, alpha: 1.0)
            }
            let review = self.reviews[self.reviews.startIndex.advancedBy(indexPath.row)]
            reviewCell.bindDataBy(review)
            
//            let userSingleTap = UITapGestureRecognizer(target: self, action: "userAvatarTapped:")
//            userSingleTap.numberOfTapsRequired = 1
//            commentCell.avatarImageView.addGestureRecognizer(userSingleTap)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var identifier = CELL_REVIEW_HEADER
        if section == 0 {
            identifier = CELL_TITLE_HEADER
        }
        let cell =  tableView.dequeueReusableCellWithIdentifier(identifier)
        
        if let titleHeader = cell as? TitleHeaderTableViewCell {
            titleHeader.titleView.text = self.activity.title
        }
        
        return cell

    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return CGFloat(48)
        }
        return CGFloat(36)
    }
    
    
    
    
    
}
