//
//  MKReviewDataConverter.swift
//  Trends
//
//  Created by Marcin Kuptel on 12/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

typealias ReviewData = Dictionary<String, AnyObject>

class MKReviewDataConverter: NSObject {
   
    func convertReviewData(reviewData: NSData) -> (Array<ReviewData>?, NSError?)
    {
        var error: NSError?
        let result: AnyObject? = NSJSONSerialization.JSONObjectWithData(reviewData, options: NSJSONReadingOptions.MutableContainers, error: &error)
        
        if let dict = result as? Dictionary<String, AnyObject>
        {
            let reviews = dict["feed"] as Dictionary<String, AnyObject>
            return (reviews["entry"] as Array<Dictionary<String, AnyObject>>?, nil)
        }
        else
        {
            if error != nil {
                println(error)
            }
            return (nil, NSError(domain: "", code: 0, userInfo: [:]))
        }
    }
    
}
