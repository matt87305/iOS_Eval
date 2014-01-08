//
//  MGRAppDelegate.h
//  iOS Eval
//
//  Created by Matt Rosemeier on 1/7/14.
//  Copyright (c) 2014 Matt Rosemeier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
