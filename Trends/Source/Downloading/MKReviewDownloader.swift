//
//  MKReviewDownloader.swift
//  Trends
//
//  Created by Marcin Kuptel on 13/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class MKReviewDownloader: NSObject {
   
    private let queue: NSOperationQueue
    private let operationFactory: MKReviewPageDownloadOperationFactory
    private let store: String
    private let appID: String
    private let numberOfPages: Int = 10
    private var responses: Dictionary<Int, NSData>
    var delegate: MKReviewDownloaderDelegate?
    
    init(queue: NSOperationQueue, operationFactory: MKReviewPageDownloadOperationFactory, store: String, appID: String)
    {
        self.queue = queue
        self.operationFactory = operationFactory
        self.store = store
        self.appID = appID
        self.responses = Dictionary<Int, NSData>()
        super.init()
    }
    
    func downloadAllReviewPages()
    {
        let completion = {
            () -> () in
            if let delegate = self.delegate {
                delegate.reviewsDownloaded(self.responses)
            }
        }
        let blockOperation = NSBlockOperation(block: completion)
        
        for x in 1...numberOfPages
        {
            let url: NSURL = MKReviewURL.reviewURL(self.appID, page: x, store: self.store)
            let operation = self.operationFactory.reviewPageDownloadOperation(url)
            operation.completion = {
                (response: NSData?, error: NSError?) -> (Void) in
                if let downloadError = error {
                    println("Error while downloading reviews: \(downloadError)")
                    self.delegate?.reviewPageDownloadFailed(x, error: downloadError)
                } else {
                    self.responses[x] = response
                    if let unwrappedResponse = response {
                        self.delegate?.reviewPageDownloaded(x, data: unwrappedResponse)
                    }
                }
            }
            self.queue.addOperation(operation)
            blockOperation.addDependency(operation)
        }
        
        self.queue.addOperation(blockOperation)
    }
}
