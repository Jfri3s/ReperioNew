//
//  ViewController.swift
//  ReperioNew
//
//  Created by Jeremiah Fries on 8/24/16.
//  Copyright © 2016 Om. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let trendingCellId = "trendingCell"
    let subscriptionCellId = "subscriptionCellId"
    let AccountCellId = "AccountCellId"
    
    let titles = ["Home", "Popular", "Categories", "Social"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.translucent = false
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(18)
        navigationItem.titleView = titleLabel
        
        setUpCollectionView()
        setupMenuBar()
        setupNavBarButtons()
        
    }
    
    func setUpCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .Horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.blackColor()
        collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.registerClass(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.registerClass(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        collectionView?.registerClass(AccountCell.self, forCellWithReuseIdentifier: AccountCellId)
        
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.pagingEnabled = true
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.memory.x / view.frame.width
        
        let indexPath = NSIndexPath(forItem: Int(index), inSection: 0)
        menuBar.collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        
        setTitleForIndex(Int(index))
        
    }
    
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_filled")?.imageWithRenderingMode(.AlwaysOriginal)
        
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .Plain, target: self, action: #selector(handleSearch))
        
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "Dots")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(handleMore))
        
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    
    
    
    
    func handleMore() {
        //Show memu
        settingsLauncher.showSettings() 
        
        
        
    }
    
    func showControllerForSetting(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.whiteColor()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
        
    }

    
    
    func handleSearch() {
        
    }
    
    func scrolltoMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(forItem: menuIndex, inSection: 0)
        collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
        
        setTitleForIndex(menuIndex)
    }
    
    private func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
     
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let blueView = UIView()
        blueView.backgroundColor = UIColor.rgb(12, green: 170, blue: 220)
        view.addSubview(blueView)
        view.addConstraintsWithFormat("H:|[v0]|", views: blueView)
        view.addConstraintsWithFormat("V:[v0(50)]", views: blueView)
        
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    
    }
    

    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let identifier: String
        if indexPath.item == 1 {
            identifier = trendingCellId
        } else if indexPath.item == 2 {
            identifier = subscriptionCellId
        } else if indexPath.item == 3 {
            identifier = AccountCellId
        } else {
            identifier = cellId
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)

        return cell 
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, view.frame.height - 50)
        
    }
    
    
    
    
    

}






    
    

























