//
//  MKWord.h
//  Trends
//
//  Created by Marcin Kuptel on 28/12/14.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MKWord : NSManagedObject

@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSSet *counts;
@end

@interface MKWord (CoreDataGeneratedAccessors)

- (void)addCountsObject:(NSManagedObject *)value;
- (void)removeCountsObject:(NSManagedObject *)value;
- (void)addCounts:(NSSet *)values;
- (void)removeCounts:(NSSet *)values;

@end
