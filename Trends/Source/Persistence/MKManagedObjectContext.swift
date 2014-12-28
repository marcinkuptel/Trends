//
//  MKManagedObjectContext.swift
//  Trends
//
//  Created by Marcin Kuptel on 28/12/14.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class MKManagedObjectContext: NSObject {
   
    class func context() -> NSManagedObjectContext {
        
        struct Singleton
        {
            static var sharedInstance: NSManagedObjectContext?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Singleton.token, { () -> Void in
            
            let modelURL = NSBundle.mainBundle().URLForResource("TrendsDataModel", withExtension: "momd")
            let mom = NSManagedObjectModel(contentsOfURL: modelURL!)
            let psc = NSPersistentStoreCoordinator(managedObjectModel: mom!)
            
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let storeURL = (urls[urls.endIndex - 1]).URLByAppendingPathComponent("Trends.sqlite")
            
            var error: NSError? = nil
            
            var store = psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error)
            
            var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
            managedObjectContext.persistentStoreCoordinator = psc
            Singleton.sharedInstance = managedObjectContext
        })
        
        return Singleton.sharedInstance!
    }
}
