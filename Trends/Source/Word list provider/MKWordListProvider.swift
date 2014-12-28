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
    private let _coreDataWordListProvider: MKCoreDataWordListProvider
    private var _wordDictionary: [String: Int]
    
    var delegate: MKWordListProviderDelegate?
    var wordList: [(String, Int)]
    
    init(reviewDownloader: MKReviewDownloader, reviewAnalyzer: MKReviewAnalyzer, dataConverter: MKReviewDataConverter, coreDataWordListProvider: MKCoreDataWordListProvider)
    {
        _reviewDownloader = reviewDownloader
        _reviewAnalyzer = reviewAnalyzer
        _dataConverter = dataConverter
        _coreDataWordListProvider = coreDataWordListProvider
        _wordDictionary = Dictionary<String, Int>()
        wordList = [(String, Int)]()
        super.init()
    }
    
    func fetchWordList() -> [MKWord]
    {
        let words: [MKWord] = self._coreDataWordListProvider.fetchWordList()
        _reviewDownloader.downloadAllReviewPages()
        
        return words
    }
    
    //MKReviewDownloaderDelegate
    
    func reviewsDownloaded(pages: Dictionary<Int, NSData>) {
    }
    
    func reviewPageDownloaded(pageNumber: Int, data: NSData) {
        
        var convertedReviews: [MKReviewData] = [MKReviewData]()
        
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
        
        //_coreDataReviewProvider.saveReviews(convertedReviews)
        
        let page: [String:Int] = MKReviewAnalyzer.mostUsedWords(10, reviews: convertedReviews)
        
        for (key, value) in page {
            var existing: Int? = self._wordDictionary[key]
            if let exists = existing {
                self._wordDictionary[key] = exists + value
            } else {
                self._wordDictionary[key] = value
            }
        }
        
        self.wordList = self.convertDictionaryToArrayOfTuples(self._wordDictionary)
        self.delegate?.wordListFetched(self.wordList)
    }
    
    func reviewPageDownloadFailed(pageNumber: Int, error: NSError) {
        println("Oh shoot ...")
    }
    
    
    //Helper methods
    func convertDictionaryToArrayOfTuples(dict: [String:Int]) -> [(String, Int)]
    {
        var tuples: Array<(String, Int)> = Array<(String, Int)>()
        
        for (key, value) in dict {
            tuples += [(key, value)]
        }
        
        tuples.sort { $0.1 > $1.1 }
        
        return tuples
    }
}