//
//  Business.h
//  iOS Eval
//
//  Created by Matt Rosemeier on 1/7/14.
//  Copyright (c) 2014 Matt Rosemeier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Business : NSManagedObject

@property (nonatomic, retain) NSNumber * retid;
@property (nonatomic, retain) NSString * retname;
@property (nonatomic, retain) NSString * secondaryname;
@property (nonatomic, retain) NSString * twitter_acc;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * pos_redeem;
@property (nonatomic, retain) NSSet *functions;

+ (Business *)businessFromDictionary:(NSDictionary *)buinessDict inManagedObjectContext:(NSManagedObjectContext *)context;

@end

@interface Business (CoreDataGeneratedAccessors)

- (void)addFunctionsObject:(NSManagedObject *)value;
- (void)removeFunctionsObject:(NSManagedObject *)value;
- (void)addFunctions:(NSSet *)values;
- (void)removeFunctions:(NSSet *)values;

@end
