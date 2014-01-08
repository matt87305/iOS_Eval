//
//  Business.m
//  iOS Eval
//
//  Created by Matt Rosemeier on 1/7/14.
//  Copyright (c) 2014 Matt Rosemeier. All rights reserved.
//

#import "Business.h"
#import "Function.h"


@implementation Business

@dynamic retid;
@dynamic retname;
@dynamic secondaryname;
@dynamic twitter_acc;
@dynamic desc;
@dynamic pos_redeem;
@dynamic functions;

+ (Business *)businessFromDictionary:(NSDictionary *)businessDict inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSDictionary *infoDictionary = businessDict[@"info"];
    NSNumber *retID = @([[NSString stringWithFormat:@"%@", infoDictionary[@"retid"]] integerValue]);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Business"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"retid == %@", retID];
    request.predicate = predicate;
    
    Business *business;
    NSArray *results = [context executeFetchRequest:request error:nil];
    //check to see if the business exists already, if it does not, insert, if it does, update.
    if (results.count)
    {
        business = results.firstObject;
    }
    else
    {
        business = [NSEntityDescription insertNewObjectForEntityForName:@"Business" inManagedObjectContext:context];
        NSDictionary *outerFunctionsDictionary = businessDict[@"functions"];
        [outerFunctionsDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *value, BOOL *stop) {
            
            Function *function = [NSEntityDescription insertNewObjectForEntityForName:@"Function" inManagedObjectContext:context];
            
            function.name = key;
            function.active = @([value[@"active"] boolValue]);
            function.info = value[@"info"];
            function.parentBusiness = business;
            
        }];
    }
    
    
    business.retid = @([[NSString stringWithFormat:@"%@", infoDictionary[@"retid"]] integerValue]);
    business.retname = infoDictionary[@"retname"];
    business.secondaryname = infoDictionary[@"secondaryname"];
    business.desc = infoDictionary[@"description"];
    business.twitter_acc = infoDictionary[@"twitter_acc"];
    business.pos_redeem = @([[NSString stringWithFormat:@"%@", infoDictionary[@"pos_redeem"]] integerValue]);
    
    
    
    
    return business;
}

@end
