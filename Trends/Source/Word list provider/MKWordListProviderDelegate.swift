//
//  MKWordListProviderDelegate.swift
//  Trends
//
//  Created by Marcin Kuptel on 14/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import Foundation

protocol MKWordListProviderDelegate
{
    func wordListFetched(Array<(String, Int)>)
}