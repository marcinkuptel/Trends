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
   
    lazy var managedObjectContext: NSManagedObjectContext = {
        
        let modelURL = NSBundle.mainBundle().URLForResource("TrendsDataModel", withExtension: "momd")
        let mom = NSManagedObjectModel(contentsOfURL: modelURL!)
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom!)
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let storeURL = (urls[urls.endIndex - 1]).URLByAppendingPathComponent("Trends.sqlite")
        
        var error: NSError? = nil
        
        var store = psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error)
        
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = psc
        
        return managedObjectContext
    }()
    
    
    func saveReviews(reviewData: [MKReviewData]) -> Bool
    {
        for data in reviewData {
            var review: MKReview = NSEntityDescription.insertNewObjectForEntityForName("MKReview", inManagedObjectContext: self.managedObjectContext) as MKReview
            
            review.title = data.title
            review.content = data.content
            review.rating = data.rating
            review.identifier = data.identifier
        }
        
        var error: NSError? = nil
        self.managedObjectContext.save(&error)
        
        if(error != nil){
            println("Error while saving reviews: \(error!)")
            return false
        }
        
        
        return true
    }
}
