//
//  ApiService.swift
//  ReperioNew
//
//  Created by Jeremiah Fries on 8/27/16.
//  Copyright © 2016 Om. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3.amazonaws.com/resourcesreperio/USE+ME/JSON"
    
    func fetchVideos(completion: ([Video]) -> ()) {
        fetchFeedForURLString("\(baseUrl)/ReperioData.json", completion: completion)

    }
    
    func fetchTrendingFeed(completion: ([Video]) -> ()) {
        fetchFeedForURLString("\(baseUrl)/Popular.json", completion: completion)
        
    }
    
    func fetchSubscriptionFeed(completion: ([Video]) -> ()) {
        fetchFeedForURLString("\(baseUrl)/Categories.json", completion: completion)

    }
    
    func fetchAccountFeed(completion: ([Video]) -> ()) {
        fetchFeedForURLString("\(baseUrl)/Social.json", completion: completion)
    }
    
    
    func fetchFeedForURLString(urlString: String, completion: ([Video]) -> ()) {
        let url = NSURL(string: urlString)
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                
                if let unwrappedData = data, jsonDictionaries = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: .MutableContainers) as? [[String: AnyObject]] {
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                    })
                }
                
                
            }   catch let jsonError {
                print(jsonError)
            }
            }.resume()
    
    }
}

//let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
//
//var vidoes = [Video]()
//
//for dictionary in json as! [[String: AnyObject]] {
//    
//    
//    let video = Video()
//    video.title = dictionary["title"] as? String
//    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//    
//    let channelDictionaty = dictionary["channel"] as! [String: AnyObject]
//    
//    let channel = Channel()
//    channel.name = channelDictionaty["name"] as? String
//    channel.profileImageName = channelDictionaty["profile_image_name"]as? String
//    
//    video.numberOfLikes = dictionary ["number_of_views"] as? NSNumber
//    
//    video.channel = channel
//    
//    
//    vidoes.append(video)
//    
//}
//dispatch_async(dispatch_get_main_queue(), {
//    completion(vidoes)
//})




//                    let numbersArray = [1, 2 ,3]
////                    let doubleNumbersArray = numbersArray.map({return $0 * 2})
//                    let stringsArray = numbersArray.map({return "\($0 * 2)"})
//                    print(stringsArray)

//                    var vidoes = [Video]()
//
//                    for dictionary in jsonDictionaries {
//                        let video = Video(dictionary: dictionary)
//                        vidoes.append(video)
//
//                    }

