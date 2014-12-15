//
//  MKWordListProvider.swift
//  Trends
//
//  Created by Marcin Kuptel on 14/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class MKWordListProvider: NSObject, MKReviewDownloaderDelegate {
   
    private let _reviewDownloader: MKReviewDownloader
    private let _reviewAnalyzer: MKReviewAnalyzer
    private let _dataConverter: MKReviewDataConverter
    private let _coreDataReviewProvider: MKCoreDataReviewProvider
    var delegate: MKWordListProviderDelegate?
    var wordList: Array<(String, Int)>
    
    init(reviewDownloader: MKReviewDownloader, reviewAnalyzer: MKReviewAnalyzer, dataConverter: MKReviewDataConverter, coreDataReviewProvider: MKCoreDataReviewProvider)
    {
        _reviewDownloader = reviewDownloader
        _reviewAnalyzer = reviewAnalyzer
        _dataConverter = dataConverter
        _coreDataReviewProvider = coreDataReviewProvider
        wordList = Array()
        super.init()
    }
    
    func fetchWordList()
    {
        _reviewDownloader.downloadReviewAllReviewPages()
    }
    
    //MKReviewDownloaderDelegate
    
    func reviewsDownloaded(pages: Dictionary<Int, NSData>) {
        
        var convertedReviews: [MKReviewData] = [MKReviewData]()
        
        for (pageNumber, data) in pages {
            
            let reviews: (Array<ReviewData>?, NSError?) = _dataConverter.convertReviewData(data)
            if let reviewsArray = reviews.0 {
                for x: ReviewData in reviewsArray
                {
                    let review = MKReviewData(reviewDict: x)
                    
                    if let r = review {
                        convertedReviews.append(r)
                    }
                }
            }
        }
        
        _coreDataReviewProvider.saveReviews(convertedReviews)
        
        self.wordList = MKReviewAnalyzer.mostUsedWords(10, reviews: convertedReviews)
        self.delegate?.wordListFetched(self.wordList)
    }
}
