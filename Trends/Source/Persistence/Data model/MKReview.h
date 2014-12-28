//
//  MKReview.h
//  Trends
//
//  Created by Marcin Kuptel on 14/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MKReview : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * rating;

@end
