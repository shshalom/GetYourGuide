//
//  UIImageView+UIActivityIndicator.swift
//  GetYourGuide
//
//  Created by Shalom Shwaitzer on 13/05/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.
//

import UIKit
import Foundation
import ObjectiveC
import SDWebImage

var TAG_ACTIVITY_INDICATOR: UInt8 = 0
//typealias SDWebImageCompletionBlock = (image:UIImage, error:NSError, cacheType:NSInteger , imageURL:NSURL)->Void
//typealias SDWebImageDownloaderProgressBlock = (receivedSize:NSInteger , expectedSize:NSInteger)->Void


extension UIImageView {
    
    
    var activityIndicator:UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &TAG_ACTIVITY_INDICATOR) as? UIActivityIndicatorView
        }
    
        set {
            objc_setAssociatedObject(self, &TAG_ACTIVITY_INDICATOR, newValue , objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func addActivityIndicatorWithStyle(activityStyle:UIActivityIndicatorViewStyle) {
    
        if (self.activityIndicator == nil) {
            self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:activityStyle)
    
            self.activityIndicator?.autoresizingMask = UIViewAutoresizing.None
    
            updateActivityIndicatorFrame()
            
            dispatch_async(dispatch_get_main_queue()) {
                if self.activityIndicator != nil {
                    self.addSubview(self.activityIndicator!)
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.activityIndicator?.startAnimating()
        }
    }
    
    func updateActivityIndicatorFrame() {
        if (self.activityIndicator != nil) {
            let activityIndicatorBounds = self.activityIndicator!.bounds
            let x = (self.frame.size.width - activityIndicatorBounds.size.width) / 2.0
            let y = (self.frame.size.height - activityIndicatorBounds.size.height) / 2.0
            self.activityIndicator!.frame = CGRectMake(x, y, activityIndicatorBounds.size.width, activityIndicatorBounds.size.height)
        }
    }
    
    func removeActivityIndicator() {
        if ((self.activityIndicator) != nil) {
            self.activityIndicator!.removeFromSuperview()
            self.activityIndicator = nil
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateActivityIndicatorFrame()
    }
    
    
    //MARK: Methods
    func setImageWithURL(url:NSURL, usingActivityIndicatorStyle activityStyle:UIActivityIndicatorViewStyle) {
        setImageWithURL(url, placeholderImage:nil, options:SDWebImageOptions(rawValue: 0), progress:nil, completed:nil, usingActivityIndicatorStyle:activityStyle)
    }
    
    func setImageWithURL(url:NSURL, placeholderImage placeholder:UIImage?, usingActivityIndicatorStyle activityStye:UIActivityIndicatorViewStyle) {
        setImageWithURL(url, placeholderImage:placeholder, options:SDWebImageOptions(rawValue: 0), progress:nil ,completed:nil ,usingActivityIndicatorStyle:activityStye);
    }
    
    func setImageWithURL(url:NSURL, placeholderImage placeholder:UIImage?, options:SDWebImageOptions, usingActivityIndicatorStyle activityStyle:UIActivityIndicatorViewStyle){
        setImageWithURL(url, placeholderImage:placeholder, options:options ,progress:nil, completed:nil, usingActivityIndicatorStyle:activityStyle)
    }
    
    func setImageWithURL(url:NSURL, completed completedBlock:SDWebImageCompletionBlock?, usingActivityIndicatorStyle activityStyle:UIActivityIndicatorViewStyle) {
        setImageWithURL(url, placeholderImage:nil, options:SDWebImageOptions(rawValue: 0), progress:nil, completed:completedBlock, usingActivityIndicatorStyle:activityStyle)
    }
    
    func setImageWithURL(url:NSURL, placeholderImage placeholder:UIImage?, completed completedBlock:SDWebImageCompletionBlock?, usingActivityIndicatorStyle activityStyle:UIActivityIndicatorViewStyle) {
        setImageWithURL(url, placeholderImage:placeholder ,options:SDWebImageOptions(rawValue: 0) ,progress:nil ,completed:completedBlock, usingActivityIndicatorStyle:activityStyle)
    }
    
    func setImageWithURL(url:NSURL, placeholderImage placeholder:UIImage?, options:SDWebImageOptions, completed completedBlock:SDWebImageCompletionBlock?, usingActivityIndicatorStyle activityStyle:UIActivityIndicatorViewStyle) {
        setImageWithURL(url,placeholderImage:placeholder, options:options ,progress:nil ,completed:completedBlock ,usingActivityIndicatorStyle:activityStyle)
    }
    
    func setImageWithURL(url:NSURL, placeholderImage placeholder:UIImage?, options:SDWebImageOptions, progress progressBlock:SDWebImageDownloaderProgressBlock?, completed completedBlock:SDWebImageCompletionBlock?, usingActivityIndicatorStyle activityStyle:UIActivityIndicatorViewStyle) {
        
        addActivityIndicatorWithStyle(activityStyle)
        
        self.sd_setImageWithURL(url, placeholderImage: placeholder, options: options, progress: progressBlock, completed:{ (image, error, type, imageUrl) in
            completedBlock?(image,error, type, imageUrl )
            self.removeActivityIndicator()
        })
        
    }
    
    
}