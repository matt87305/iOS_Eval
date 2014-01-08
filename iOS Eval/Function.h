//
//  Function.h
//  iOS Eval
//
//  Created by Matt Rosemeier on 1/7/14.
//  Copyright (c) 2014 Matt Rosemeier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Business;

@interface Function : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * readableName;
@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) Business *parentBusiness;


@end
