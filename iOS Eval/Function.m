//
//  Function.m
//  iOS Eval
//
//  Created by Matt Rosemeier on 1/7/14.
//  Copyright (c) 2014 Matt Rosemeier. All rights reserved.
//

#import "Function.h"
#import "Business.h"


@implementation Function

@dynamic name;
@dynamic active;
@dynamic info;
@dynamic parentBusiness;

- (NSString *)functionReadableName
{
    if ([self.name isEqualToString:@"gallery"])
    {
        return @"Photo Gallery";
    }
    else if ([self.name isEqualToString:@"locations"])
    {
        return @"Business Info";
    }
    else if ([self.name isEqualToString:@"latestNews"])
    {
        return @"Latest News";
    }
    else if ([self.name isEqualToString:@"unlockRewards"])
    {
        return @"How to Unlock Rewards Here";
    }
    else if ([self.name isEqualToString:@"directions"])
    {
        return @"Get Directions";
    }
    return self.name;
}

@end
