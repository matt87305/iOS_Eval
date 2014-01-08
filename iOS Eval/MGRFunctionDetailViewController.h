//
//  MGRFunctionDetailViewController.h
//  iOS Eval
//
//  Created by Matt Rosemeier on 1/7/14.
//  Copyright (c) 2014 Matt Rosemeier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGRFunctionDetailViewController : UIViewController

@property (nonatomic) NSString *receivedFunctionTitle;
@property (strong, nonatomic) IBOutlet UILabel *functionTitleLabel;

- (IBAction)popOff:(id)sender;

@end
