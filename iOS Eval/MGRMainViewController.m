//
//  MGRMainViewController.m
//  iOS Eval
//
//  Created by Matt Rosemeier on 1/7/14.
//  Copyright (c) 2014 Matt Rosemeier. All rights reserved.
//

#import "MGRMainViewController.h"
#import "Function.h"
#import "Business.h"
#import "MGRAppDelegate.h"
#import "MGRTitleCell.h"
#import "MGRMapCell.h"
#import "MGRFunctionCell.h"
#import "MGRFunctionDetailViewController.h"


@interface MGRMainViewController ()

@end

@implementation MGRMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    NSString *jsonURLString = @"http://loyaltree.com/business/fake_api.php?token=x0iloVx";
    NSURL *jsonURL = [NSURL URLWithString:jsonURLString];
    NSURLRequest *jsonRequest = [NSURLRequest requestWithURL:jsonURL];
    MGRMainViewController * __weak weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:jsonRequest queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *returnDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:Nil];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            MGRMainViewController *strongSelf = weakSelf;
            [strongSelf processDataWithDictionary:returnDict];
            
        }];
        
    }];

}


- (void)processDataWithDictionary:(NSDictionary *)dataDict
{
    MGRAppDelegate *delegate = (MGRAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.activeBusiness = [Business businessFromDictionary:dataDict inManagedObjectContext:delegate.managedObjectContext];
    
    NSLog(@"Active Business: %@", self.activeBusiness);

    NSError *error;
    [delegate.managedObjectContext save:&error];
    if (error)
    {
        NSLog(@"Failed to load.");
    }
    
    [self loadTableData];
    
}

- (void)loadTableData
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Business"];
    
    MGRAppDelegate *delegate = (MGRAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSArray *results = [context executeFetchRequest:request error:nil];
    NSSet *functions = [[results firstObject] valueForKeyPath:@"functions"];
    self.functionsArray = [[functions allObjects] mutableCopy];
    
    NSMutableArray *mutableFunctionsArray = self.functionsArray.mutableCopy;
    self.activeFunctionsCount = 0;
    NSInteger index = 0;
    for (Function *func in mutableFunctionsArray)
    {
        if ([func.active isEqual: @(1)])
        {
            self.activeFunctionsCount ++;
        }
        else
        {
            [self.functionsArray removeObjectAtIndex:index];
        }
        
        index++;
    }
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //start with 2 for the title and map cells
    NSInteger cellCount = 2;
    
    //add number of function cells with active = 1
    cellCount += self.activeFunctionsCount;
    return cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleCellIdentifier = @"MGRTitleCell";
    NSString *mapCellIdentifier = @"MGRMapCell";
    NSString *functionCellIdentifier = @"MGRFunctionCell";
    
    UITableViewCell *cellToReturn = [UITableViewCell new];
    if (indexPath.row == 0)
    {
        MGRTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:titleCellIdentifier];
        titleCell.titleLabel.text = self.activeBusiness.retname;
        titleCell.subtitleLabel.text = self.activeBusiness.secondaryname;
        
        cellToReturn = titleCell;
    }
    else if (indexPath.row == 1)
    {
        MGRMapCell *mapCell = [tableView dequeueReusableCellWithIdentifier:mapCellIdentifier];
        //center the map on Pittsburgh, PA (whiskey bar)
        CLLocationCoordinate2D centerCoords = CLLocationCoordinate2DMake(40.429153, -79.983059);
        [mapCell.mapView setCenterCoordinate:centerCoords];
        
        CLLocationDistance latitudinalMeters = 3000.f;
        CLLocationDistance longitudinalMeters = 6000.f;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerCoords, latitudinalMeters, longitudinalMeters);
        [mapCell.mapView setRegion:region];
        
        cellToReturn = mapCell;
    }
    else
    {
        MGRFunctionCell *functionCell = [tableView dequeueReusableCellWithIdentifier:functionCellIdentifier];
        Function *function = [self.functionsArray objectAtIndex:(indexPath.row - 2)];
        NSString *functionReadableName = @"";
        functionCell.functionAccessoryLabel.hidden = YES;
        if ([function.name isEqualToString:@"gallery"])
        {
            functionReadableName = @"Photo Gallery";
        }
        else if ([function.name isEqualToString:@"locations"])
        {
            functionReadableName = @"Business Info";
        }
        else if ([function.name isEqualToString:@"latestNews"])
        {
            functionReadableName = @"Latest News";
            functionCell.functionAccessoryLabel.hidden = NO;
        }
        else if ([function.name isEqualToString:@"unlockRewards"])
        {
            functionReadableName = @"How to Unlock Rewards Here";
        }
        else if ([function.name isEqualToString:@"directions"])
        {
            functionReadableName = @"Get Directions";
        }
        
        
        functionCell.functionTitleLabel.text = functionReadableName;
        
        cellToReturn = functionCell;
    }
    
    
    return cellToReturn;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <= 1)
    {
        return;
    }
    
    Function *activeFunction = [self.functionsArray objectAtIndex:(indexPath.row - 2)];
    self.activeSelectedFunctionTitle = activeFunction.info;
    [self performSegueWithIdentifier:@"ShowFunctionSegue" sender:Nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowFunctionSegue"])
    {
        MGRFunctionDetailViewController *detailController = [segue destinationViewController];
        [detailController setReceivedFunctionTitle:self.activeSelectedFunctionTitle];
    }
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float cellHeight = 0.f;
    switch (indexPath.row) {
        case 0:
            cellHeight = 75;
            break;
            
        case 1:
            cellHeight = 170;
            break;
            
        default:
            cellHeight = 44;
            break;
    }
    
    
    
    return cellHeight;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
