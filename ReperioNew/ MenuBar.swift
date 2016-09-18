//
//   MenuBar.swift
//  ReperioNew
//
//  Created by Jeremiah Fries on 8/24/16.
//  Copyright © 2016 Om. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(12, green: 170, blue: 220)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    let imageNames = ["Home","Fire", "activity_feed", "User"]
    
    var homeController: HomeController?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        collectionView.registerClass(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|" , views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = NSIndexPath(forItem: 0, inSection: 0)
        collectionView.selectItemAtIndexPath(selectedIndexPath, animated: false, scrollPosition: .None)
        
        setupHorizontalBar()

    }
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 1, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        
        
        
        //old school way of doing things
//        horizontalBarView.frame = CGRectMake(CGFloat, <#T##y: CGFloat##CGFloat#>, <#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>)
        
        //new school way of laying out our views 
        //in iOS 9 
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraintEqualToAnchor(self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.active = true
        
        horizontalBarView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true 
        
        horizontalBarView.widthAnchor.constraintEqualToAnchor(self.widthAnchor, multiplier: 1/4).active = true
        
        horizontalBarView.heightAnchor.constraintEqualToConstant(4).active = true
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
//        print(indexPath.item)
//        let x = CGFloat(indexPath.item) * frame.width / 4
//        horizontalBarLeftAnchorConstraint?.constant = x
//        
//        UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { 
//            self.layoutIfNeeded()
//            }, completion: nil)
        
        homeController?.scrolltoMenuIndex(indexPath.item)
        
        

    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! MenuCell
        
        cell.iamgeView.image = UIImage(named: imageNames[indexPath.item])?.imageWithRenderingMode(.AlwaysTemplate)
        
        //Icon tint color
        cell.tintColor = UIColor.rgb(3, green: 85, blue: 107)
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(frame.width / 4, frame.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MenuCell: BaseCell {
    
    let iamgeView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Home")?.imageWithRenderingMode(.AlwaysTemplate)
        
        //Icon tint color
        iv.tintColor = UIColor.rgb(3, green: 85, blue: 107)
        return iv
    }()
    

    override var highlighted: Bool {
        didSet {
        iamgeView.tintColor = highlighted ? UIColor.whiteColor() : UIColor.rgb(3, green: 85, blue: 107)
        }
    }
    
    override var selected: Bool {
        didSet {
        iamgeView.tintColor = selected ? UIColor.whiteColor() : UIColor.rgb(3, green: 85, blue: 107)
        }
    }
    
    
    override func setupViews() {
        super.setupViews()
        
            addSubview(iamgeView)
        addConstraintsWithFormat("H:[v0(28)]", views: iamgeView)
        addConstraintsWithFormat("V:[v0(28)]", views: iamgeView)
        
        addConstraint(NSLayoutConstraint(item: iamgeView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: iamgeView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))

        
        

    }
    

}





