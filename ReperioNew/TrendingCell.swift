//
//  TrendingCell.swift
//  ReperioNew
//
//  Created by Jeremiah Fries on 8/27/16.
//  Copyright © 2016 Om. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    
    override func fetchVidoes() {
        ApiService.sharedInstance.fetchTrendingFeed { (vidoes) in
            self.videos = vidoes
            self.collectionView.reloadData()
            
    
           
            
        }
        
    }
    

}
