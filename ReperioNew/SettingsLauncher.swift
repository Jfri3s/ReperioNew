//
//  SettingsLauncher.swift
//  ReperioNew
//
//  Created by Jeremiah Fries on 8/25/16.
//  Copyright © 2016 Om. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let iamgeName: String
    
    
    
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.iamgeName = imageName
    }
}

enum SettingName: String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case TermsPrivacy = "Terms & privacy policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}
    

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView (frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        
        let settingsSetting = Setting(name: .Settings, imageName: "settings")
        
        let cancelSetting = Setting(name: .Cancel, imageName: "Cancel")
        
        return [settingsSetting, Setting(name: .TermsPrivacy, imageName: "privacy"), Setting(name: .SendFeedback, imageName: "feedback"), Setting(name: .Help, imageName: "help"), Setting(name: .SwitchAccount, imageName: "switch_account"), cancelSetting]
 
    
    }()
    
    var homeController: HomeController?
    
    
    func showSettings() {
        //Show menu
        
        if let window = UIApplication .sharedApplication() .keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.44)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismess)))
            
            window.addSubview(blackView)
            
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRectMake(0 , window.frame.height, window.frame.width, height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRectMake(0, y, self.collectionView.frame.width, self.collectionView.frame.height)
                
                }, completion: nil)
 
        }
    }
    
    func handleDismess(setting: Setting) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.sharedApplication().keyWindow {
                
                self.collectionView.frame = CGRectMake(0, window.frame.height, self.collectionView.frame.width, self.collectionView.frame.height)
            }
            
        }) { (completed: Bool) in
            
            if setting.name != .Cancel {
                self.homeController?.showControllerForSetting(setting)
            }

        }
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SettingsCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting 
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width, cellHeight)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0 
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let setting = self.settings[indexPath.item]
        handleDismess(setting)
        
        
    
    
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerClass(SettingsCell.self, forCellWithReuseIdentifier: cellId)
        

        
        
        
    }
}
