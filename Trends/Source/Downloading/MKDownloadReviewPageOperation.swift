//
//  MKDownloadReviewPageOperation.swift
//  Trends
//
//  Created by Marcin Kuptel on 13/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

typealias MKDownloadReviewPageOperationCompletion = (response: NSData?, error: NSError?) -> ()

class MKDownloadReviewPageOperation: MKConcurrentOperation {
   
    private let _url: NSURL
    var completion: MKDownloadReviewPageOperationCompletion?
    
    init(url: NSURL)
    {
        _url = url
        super.init()
    }
 
    override func main() {
        
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: _url)
        request.HTTPMethod = "GET"
        var session: NSURLSession = NSURLSession.sharedSession()
        
        var completionHandler = {
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            
            if error == nil {
                if self.completion != nil {
                    self.completion!(response: data, error: nil)
                }
            }else{
                if self.completion != nil {
                    self.completion!(response: nil, error: error)
                }
            }
            
            self.completeOperation()
        }
        
        var task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
}
