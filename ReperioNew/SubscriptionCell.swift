//
//  SubscriptionCell.swift
//  ReperioNew
//
//  Created by Jeremiah Fries on 8/27/16.
//  Copyright © 2016 Om. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchVidoes() {
        
        ApiService.sharedInstance.fetchSubscriptionFeed { (vidoes) in
            self.videos = vidoes
            self.collectionView.reloadData()
        
        }
    
    }
    
}
