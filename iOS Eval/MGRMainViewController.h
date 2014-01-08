//
//  MGRMainViewController.h
//  iOS Eval
//
//  Created by Matt Rosemeier on 1/7/14.
//  Copyright (c) 2014 Matt Rosemeier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Business.h"

@interface MGRMainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Business *activeBusiness;
@property (strong, nonatomic) NSMutableArray *functionsArray;
@property (nonatomic) NSInteger activeFunctionsCount;
@property (nonatomic) NSString *activeSelectedFunctionTitle;

@end
