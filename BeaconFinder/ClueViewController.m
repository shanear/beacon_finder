//
//  ClueViewController.m
//  BeaconFinder
//
//  Created by srussell on 12/4/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "ClueViewController.h"
#import <ESTBeaconManager.h>

@interface ClueViewController () <ESTBeaconManagerDelegate>
- (IBAction)onSkip:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *clueLabel;
@property (weak, nonatomic) IBOutlet UITextView *cluesText;
@property (weak, nonatomic) IBOutlet UILabel *beaconsLabel;
@property int clueNumber;
@property (weak, nonatomic) IBOutlet UINavigationBar *clueStatus;
@property NSArray *statusMessages;
@property int currentStatus;
@property (nonatomic, strong) ESTBeaconManager* beaconManager;
@property (nonatomic, strong) ESTBeacon* selectedBeacon;
@end

@implementation ClueViewController

int _hotness = 0;

float HOT_RED = 0.9;
float HOT_GREEN = 0.32;
float HOT_BLUE = 0.32;
float COLD_RED = 1.0;
float COLD_GREEN = 0.97;
float COLD_BLUE = 0.79;

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
    
    // craete manager instance
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconManager.avoidUnknownStateBeacons = YES;
    
    // create sample region object (you can additionaly pass major / minor values)
    ESTBeaconRegion* region = [[ESTBeaconRegion alloc] initRegionWithIdentifier:@"EstimoteSampleRegion"];
    
    // start looking for estimote beacons in region
    // when beacon ranged beaconManager:didRangeBeacons:inRegion: invoked
    [self.beaconManager startRangingBeaconsInRegion:region];
    
    [self.view bringSubviewToFront: self.clueLabel];
    
    self.statusMessages = @[
                            @"You're not close.",
                            @"You're getting warmer...",
                            @"You've found it!"
                            ];
    self.currentStatus = 0;
    self.clueNumber = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)beaconManager:(ESTBeaconManager *)manager
     didRangeBeacons:(NSArray *)beacons
            inRegion:(ESTBeaconRegion *)region
{
    if([beacons count] > 0)
    {
        [self.beaconsLabel setText: [NSString stringWithFormat:@"We got beacons: #%d", [beacons count]]];
    }
    else {
        [self.beaconsLabel setText: @"We have no beacons..."];
    }
}

- (IBAction)onSkip:(id)sender {
    self.clueNumber += 1;
    [self.clueLabel setText: [NSString stringWithFormat:@"Clue %d", self.clueNumber]];
    [self changeStatus];
}


- (int)changeStatus {
    self.currentStatus += 1;
    self.currentStatus = self.currentStatus % 3;
    self.clueStatus.topItem.title = self.statusMessages[self.currentStatus];
    
    [self.cluesText setText: self.view.backgroundColor.description];
    [self backgroundGradientforHotness: _hotness];
    _hotness += 5;
    
    return self.currentStatus;
}

- (void)backgroundGradientforHotness:(int)hotness {
    self.view.backgroundColor = [UIColor colorWithRed: [self mergeColorValue: COLD_RED
                                    withNewColor: HOT_RED
                                    byPercentage: hotness]
                    green: [self mergeColorValue: COLD_GREEN
                                    withNewColor: HOT_GREEN
                                    byPercentage: hotness]
                     blue:[self mergeColorValue: COLD_BLUE
                                   withNewColor: HOT_BLUE
                                   byPercentage: hotness]
                    alpha:1];
}

- (float)mergeColorValue:(float) oldColor
            withNewColor: (float) newColor
            byPercentage: (int) percentage {
    float stepAmount = (newColor - oldColor) / 100.0;
    return oldColor + (stepAmount * percentage);
}

@end








