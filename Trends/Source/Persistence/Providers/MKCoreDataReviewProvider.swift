//
//  MKCoreDataReviewProvider.swift
//  Trends
//
//  Created by Marcin Kuptel on 14/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit
import CoreData

class MKCoreDataReviewProvider: NSObject {
   
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext)
    {
        self.context = context
        super.init()
    }
    
    func saveReviews(reviewData: [MKReviewData]) -> Void
    {
        for data in reviewData {
            var review: MKReview = NSEntityDescription.insertNewObjectForEntityForName("MKReview", inManagedObjectContext: context) as MKReview
            
            review.title = data.title
            review.content = data.content
            review.rating = data.rating
            review.identifier = data.identifier
            review.date = NSDate()
        }
        
        var error: NSError? = nil
        self.context.performBlock { () -> Void in
            self.context.save(&error)
            
            if(error != nil){
                println("Error while saving reviews: \(error!)")
            }
            
            return
        }
    }
}
