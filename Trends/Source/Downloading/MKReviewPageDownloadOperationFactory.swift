//
//  MKReviewPageDownloadOperationFactory.swift
//  Trends
//
//  Created by Marcin Kuptel on 13/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class MKReviewPageDownloadOperationFactory: NSObject {
   
    func reviewPageDownloadOperation(url: NSURL) -> MKDownloadReviewPageOperation
    {
        let operation = MKDownloadReviewPageOperation(url: url)
        return operation
    }
    
}
