//
//  MKWordListProviderFactory.swift
//  Trends
//
//  Created by Marcin Kuptel on 14/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class MKWordListProviderFactory: NSObject {
   
    class var wordListProvider: MKWordListProvider {
        
        struct Singleton {
            static var instance: MKWordListProvider?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Singleton.token, { () -> Void in
            Singleton.instance = MKWordListProviderFactory.createWordProvider()
            return
        })
        
        return Singleton.instance!
    }
    
    private class func createWordProvider() -> MKWordListProvider
    {
        let operationQueue: NSOperationQueue = NSOperationQueue()
        let operationFactory: MKReviewPageDownloadOperationFactory = MKReviewPageDownloadOperationFactory()
        let downloader: MKReviewDownloader = MKReviewDownloader(queue: operationQueue, operationFactory: operationFactory, store: "us", appID: "911813648")
        let analyzer: MKReviewAnalyzer = MKReviewAnalyzer()
        let dataConverter: MKReviewDataConverter = MKReviewDataConverter()
        
        let coreDataWordListProvider: MKCoreDataWordListProvider = MKCoreDataWordListProvider(context: MKManagedObjectContext.context())
        let provider = MKWordListProvider(reviewDownloader: downloader, reviewAnalyzer: analyzer, dataConverter: dataConverter, coreDataWordListProvider: coreDataWordListProvider)
        downloader.delegate = provider
        return provider
    }
    
}
