//
//  MKCoreDataWordListProvider.swift
//  Trends
//
//  Created by Marcin Kuptel on 28/12/14.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class MKCoreDataWordListProvider: NSObject {
   
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext)
    {
        self.context = context
        super.init()
    }
    
    func fetchWordList() -> [MKWord]
    {
        var fetchedObjects: [MKWord] = []
        
        self.context.performBlockAndWait { () -> Void in
            var request = NSFetchRequest(entityName: "MKWord")
            var error: NSError? = nil
            var result = self.context.executeFetchRequest(request, error:  &error)
            
            
            if let fetchError = error {
                println("Error while fetching word list: \(fetchError)")
            } else {
                fetchedObjects = result as [MKWord]
            }
        }
        
        return fetchedObjects
    }
    
}
