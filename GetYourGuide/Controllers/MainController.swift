//
//  ViewController.swift
//  GetYourGuide
//
//  Created by Shalom Shwaitzer on 13/05/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.
//

import UIKit
import PageMenu

class MainController: UIViewController {
    
    var pageMenu:CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
            setupNavigationBar()
            setupControllers()
    }
    
    func setupNavigationBar() {
        
        self.title                                            = "GetYourGuide"
        self.navigationItem.rightBarButtonItem                = UIBarButtonItem(barButtonSystemItem: .Search,
                                                                                             target: self,
                                                                                             action: #selector(toggleSearch))
        self.navigationController?.navigationBar.barTintColor = UIColor.colorScheme.navigationBarColor()
        self.navigationController?.navigationBar.barStyle     = UIBarStyle.Black
        self.navigationController?.navigationBar.translucent  = true
        self.navigationController?.navigationBar.tintColor    = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

    }
    
    func setupControllers() {
        
        var controllerArray:[UIViewController] = []
        
        let popularVC = UIStoryboard.activityCollectionViewController()!
            popularVC.loadViewIfNeeded()
            popularVC.title = "Popular"
            popularVC.requestType = Int(0)
            popularVC.parentNavigationController = self.navigationController
            controllerArray.append(popularVC)
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor.whiteColor()),
            .ViewBackgroundColor(UIColor.colorScheme.viewBackgroundColor()),
            .BottomMenuHairlineColor(UIColor.colorScheme.bottomMenuHairlineColor()),
            .SelectionIndicatorColor(UIColor.colorScheme.selectionIndicatorColor()),
            .MenuHeight(40.0),
            .SelectedMenuItemLabelColor(UIColor.colorScheme.selectedMenuItemLabel()),
            .UnselectedMenuItemLabelColor(UIColor.colorScheme.unselectedMenuItemLabel()),
            .MenuItemFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorRoundEdges(true),
            .SelectionIndicatorHeight(2.0),
            .MenuItemSeparatorPercentageHeight(0.1)
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray,
                                          frame: CGRectMake(0.0, 60.0, self.view.frame.width, self.view.frame.height),
                                pageMenuOptions: parameters)
        
        pageMenu?.useMenuLikeSegmentedControl = true
        
        self.view.addSubview(pageMenu!.view)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
    }
    
    func toggleSearch() {
        //self.navigationController?.pushViewController(MainSearchViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

