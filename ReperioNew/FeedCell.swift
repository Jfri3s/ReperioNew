//
//  FeedCell.swift
//  ReperioNew
//
//  Created by Jeremiah Fries on 8/26/16.
//  Copyright © 2016 Om. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.blackColor()
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var videos: [Video]? 
    
    let cellId = "cellId"
    
    func fetchVidoes() {
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
        
            self.videos = videos
            self.collectionView.reloadData()
            
        }
        
    }
    
    
    
    override func setupViews() {
        super.setupViews()
        
        fetchVidoes()
        
        backgroundColor = .brownColor()
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.registerClass(videoCell.self, forCellWithReuseIdentifier: cellId)

    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0

    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as! videoCell
        
        cell.video = videos?[indexPath.item]
        
        
        
        
            
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSizeMake(frame.width, height + 16 + 88)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
    
    


}
























































