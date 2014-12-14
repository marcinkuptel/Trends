//
//  MKReviewAnalyzer.swift
//  Trends
//
//  Created by Marcin Kuptel on 13/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class MKReviewAnalyzer: NSObject {
   
    class func mostUsedWords(count: Int, reviews: [MKReview]) -> [(String, Int)]
    {
        let res = reviews.reduce(Dictionary<String, Int>(), combine: { (var dict: Dictionary<String, Int>, review) in
            
            let characterset = NSCharacterSet.punctuationCharacterSet()
            let lowerCase = review.content.lowercaseString
            let content = lowerCase.componentsSeparatedByCharactersInSet(characterset)
            let joined = "".join(content)
            let words = joined.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            let counted = words.reduce(Dictionary<String, Int>(), combine: { (var result, word) in
                if let currentCount = result[word] {
                    result[word] = currentCount + 1
                } else {
                    result[word] = 1
                }
                return result
            })
            
            for (key, value) in counted {
                if let existing = dict[key] {
                    dict[key] = existing + value
                } else {
                    dict[key] = value
                }
            }
            
            return dict
        })
        
        var tuples: Array<(String, Int)> = Array<(String, Int)>()

        for (key, value) in res {
            tuples += [(key, value)]
        }
        
        tuples.sort { $0.1 > $1.1 }
        
        return tuples
    }
}
