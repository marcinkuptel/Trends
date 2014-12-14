//
//  MKReviewPageDownloadOperation.swift
//  Trends
//
//  Created by Marcin Kuptel on 13/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class MKConcurrentOperation: NSOperation {
   
    private var _executing : Bool
    private var _finished: Bool
    private var _asynchronous: Bool
    
    override init()
    {
        _executing = false
        _finished = false
        _asynchronous = true
        super.init()
    }
    
    override func start()
    {
        if(cancelled)
        {
            self.finished = true
            return
        }
        
        self.executing = true
        self.main()
    }
    
    override var executing : Bool {
        get { return _executing }
        set {
            willChangeValueForKey("isExecuting")
            _executing = newValue
            didChangeValueForKey("isExecuting")
        }
    }
    
    override var finished : Bool {
        get { return _finished }
        set {
            willChangeValueForKey("isFinished")
            _finished = newValue
            didChangeValueForKey("isFinished")
        }
    }
    
    override var asynchronous: Bool {
        get { return _asynchronous }
        set {
            willChangeValueForKey("isAsynchronous")
            _asynchronous = newValue
            didChangeValueForKey("isAsynchronous")
        }
    }
    
    func completeOperation()
    {
        willChangeValueForKey("isFinished")
        willChangeValueForKey("isExecuting")
        
        _finished = true
        _executing = false
        
        didChangeValueForKey("isFinished")
        didChangeValueForKey("isExecuting")
    }
}
