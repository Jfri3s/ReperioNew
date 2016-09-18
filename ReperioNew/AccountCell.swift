//
//  AccountCell.swift
//  ReperioNew
//
//  Created by Jeremiah Fries on 8/29/16.
//  Copyright © 2016 Om. All rights reserved.
//

import UIKit

class AccountCell: FeedCell {


    override func fetchVidoes() {
        ApiService.sharedInstance.fetchAccountFeed { (vidoes) in
            self.videos = vidoes
            self.collectionView.reloadData()
        }
    }

}
