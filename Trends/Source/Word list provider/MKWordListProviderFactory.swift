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
            static let instance = MKWordListProviderFactory.createWordProvider()
        }
        return Singleton.instance
    }
    
    private class func createWordProvider() -> MKWordListProvider
    {
        let operationQueue: NSOperationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        let operationFactory: MKReviewPageDownloadOperationFactory = MKReviewPageDownloadOperationFactory()
        let downloader: MKReviewDownloader = MKReviewDownloader(queue: operationQueue, operationFactory: operationFactory, store: "us", appID: "911813648")
        let analyzer: MKReviewAnalyzer = MKReviewAnalyzer()
        let dataConverter: MKReviewDataConverter = MKReviewDataConverter()
        let provider = MKWordListProvider(reviewDownloader: downloader, reviewAnalyzer: analyzer, dataConverter: dataConverter)
        downloader.delegate = provider
        return provider
    }
    
}
