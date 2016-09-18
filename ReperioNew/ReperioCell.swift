 //
//  HomeCell.swift
//  ReperioNew
//
//  Created by Jeremiah Fries on 8/24/16.
//  Copyright © 2016 Om. All rights reserved.
//

import UIKit


class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


class videoCell: BaseCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnialImage()
            
            setupProfileImage()
            
            
            if let ChannelName = video?.channel?.name, number_of_views = video?.number_of_views {
                
                let numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = .DecimalStyle
                
                let subtitleText = "\(ChannelName) • \(numberFormatter.stringFromNumber(number_of_views)!) • Tap for promotion details"
                
                subtiteTextView.text = subtitleText
                
                
                
            }
            
            
            //mesure title text 
            if let title = video?.title {
                let size = CGSizeMake(frame.width - 16 - 44 - 8 - 16, 1000)
                let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
                
                
                let estmatedRect = NSString(string: title).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
                
                if estmatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
                
                
            }
            
            
 
            
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profile_image_name {
            
            userProfileImageView.loadImageUSingUrlString(profileImageUrl)
            
        }
    
    }
    
    func setupThumbnialImage() {
        if let ThumbnialImageUrl = video?.thumbnail_image_name {
            thumbnailImageView.loadImageUSingUrlString(ThumbnialImageUrl)
      
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Chipotle")
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage (named: "")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .ScaleAspectFill
        return imageView
        
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGrayColor()
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Chipotle - Mexican Grill"
        label.textColor = UIColor.whiteColor()
        label.numberOfLines = 2
        return label
    }()
    
    let subtiteTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Latest Deal • 400 likes •  5 hours left on promo"
        textView.textContainerInset = UIEdgeInsetsMake( 0, -4, 0, 0)
        textView.textColor = UIColor.lightGrayColor()
        textView.backgroundColor = nil
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(seperatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtiteTextView)
        
        
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical constraints
        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, seperatorView)
        
        
        addConstraintsWithFormat("H:|[v0]|", views: seperatorView)
        
        //top constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Bottom, multiplier: 1, constant: 8))
        //left constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        //right constraints
        addConstraint(NSLayoutConstraint (item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        
        //height constraint
        titleLabelHeightConstraint = NSLayoutConstraint (item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 50)
        addConstraint(titleLabelHeightConstraint!)
        
        
        //top constraints
        addConstraint(NSLayoutConstraint(item: subtiteTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 4))
        //left constraints
        addConstraint(NSLayoutConstraint(item: subtiteTextView, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        //right constraints
        addConstraint(NSLayoutConstraint (item: subtiteTextView, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        //height constraints
        addConstraint(NSLayoutConstraint (item: subtiteTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 30))
        
        
    }

}









