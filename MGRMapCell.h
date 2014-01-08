//
//  MGRMapCell.h
//  iOS Eval
//
//  Created by Matt Rosemeier on 1/7/14.
//  Copyright (c) 2014 Matt Rosemeier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MGRMapCell : UITableViewCell

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
