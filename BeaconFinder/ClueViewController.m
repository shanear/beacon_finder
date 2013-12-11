//
//  ClueViewController.m
//  BeaconFinder
//
//  Created by srussell on 12/4/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "ClueViewController.h"
#import "VictoryViewController.h"
#import "Game.h"
#import "TimerFormatter.h"
#import <ESTBeaconManager.h>

@interface ClueViewController () <ESTBeaconManagerDelegate>
- (IBAction)onSkip:(id)sender;
- (IBAction)onNextClue:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *clueLabel;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UITextView *cluesText;
@property (weak, nonatomic) IBOutlet UILabel *beaconsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImage;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property int clueNumber;
@property NSArray *statusMessages;
@property (weak, nonatomic) IBOutlet UILabel *locationName;
@property (weak, nonatomic) IBOutlet UITextView *funFactText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *skipButton;
@property (nonatomic, strong) ESTBeaconManager* beaconManager;
@property (nonatomic, strong) ESTBeacon* selectedBeacon;
@end

@implementation ClueViewController

Game *_game;
LocationFactory *_locationFactory;
NSTimer *timer;
int timerCount;

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
    
    _locationFactory = [[LocationFactory alloc] init];
    _game = [[Game alloc] initWithLocationFactory:_locationFactory];
    timerCount = 0;
    [_game start];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats: YES];
    
    [self.statusButton setEnabled:NO];
    
    self.clueNumber = 0;
    [self updateLocationUI];
}

-(void) updateTimer: (NSTimer *) timer{
    NSUInteger seconds = [_game elapsedSeconds];
    [self.timerLabel setText:[TimerFormatter formatSeconds:seconds]];
}

-(BOOL) shouldAutorotate
{
    return NO;
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
    if (![_game isLocationFound])
    {
        [self registerBeacons: beacons];
        //[self testOutputForBeacons: beacons];
        [self updateStatusMessage];
        [self updateBackgroundColor];
        
        if([_game isLocationFound])
        {
            [self changeClueToFunFact];
            [_game pause];
        }
    }
}

-(void)registerBeacons: (NSArray *) beacons
{
    for(ESTBeacon* beacon in beacons)
    {
        [_game registerBeaconWithMajor: [beacon.ibeacon.major intValue]
                                 Minor: [beacon.ibeacon.minor intValue]
                           withReading: beacon.ibeacon.rssi];
    }

}



-(void)testOutputForBeacons: (NSArray *) beacons {
    if([beacons count] > 0)
    {
        ESTBeacon* beacon = [beacons firstObject];
        
        NSString* text = [NSString stringWithFormat:
                          @"Here is our beaconius. (major: %d, minor: %d, rssi %d) hotness: %d", [beacon.ibeacon.major intValue], [beacon.ibeacon.minor intValue], beacon.ibeacon.rssi, _game.hotness];
        [self.cluesText setText: text];
    }
    else {
        [self.cluesText setText: @"We have no beacons..."];
    }
}

-(void)beaconManager:(ESTBeaconManager *)manager
       didExitRegion:(ESTBeaconRegion *)region {
    [_game registerNoBeacons];

    [self updateStatusMessage];
    [self updateBackgroundColor];
}

- (IBAction)onSkip:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"If you skip, you will never be able to return to this clue." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Skip", nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex != [alertView cancelButtonIndex]) {
        [_game skipLocation];
        [self updateLocationUI];
    }
}

- (IBAction)onNextClue:(id)sender
{
    [_game resume];
    [_game advanceLocation];
    [self updateLocationUI];
}

- (void)updateLocationUI
{
    if ([_game completed])
    {
        [self performSegueWithIdentifier:@"victory" sender:NULL];
    }
    else {
        self.clueNumber += 1;
        [self.clueLabel setText: [NSString stringWithFormat:@"Clue %d", self.clueNumber]];
        [self.cluesText setText:[_game.currentLocation formattedClues]];
        
        NSString *imageName = [NSString stringWithFormat:@"%@Clue", _game.currentLocation.beaconName];
        [self.locationImage setImage:[UIImage imageNamed:imageName]];
        
        [self.statusButton setEnabled:NO];
        [self updateStatusMessage];
        [self updateBackgroundColor];
        [self.skipButton setEnabled:YES];
        [self.locationName setHidden:YES];
        [self.funFactText setHidden:YES];
        [self.cluesText setHidden:NO];
    }
}

-(void)changeClueToFunFact
{
    [self.clueLabel setText:@"Nice job!"];
    [self.cluesText setHidden:YES];
    [self.locationName setText:_game.currentLocation.name];
    [self.locationName setHidden:NO];
    [self.funFactText setText:_game.currentLocation.funFact];
    [self.funFactText setHidden:NO];
    [self.locationImage setImage:[UIImage imageNamed:_game.currentLocation.beaconName]];
    [self.statusButton setEnabled:YES];
    [self.skipButton setEnabled:NO];
    self.view.backgroundColor = [UIColor colorWithRed:0.60 green: 0.93 blue: 0.60 alpha:1];
    
    if(_game.currentLocation.next == NULL) {
        [self.statusButton setTitle:@"Finish!" forState:UIControlStateNormal];
    }
}

- (NSString *)statusMessage {
    if(_game.hotness > 75) {
        return @"You're burning up!";
    }
    else if(_game.hotness > 0) {
        return @"You're getting warmer...";
    }
    else {
        return @"You're not close.";
    }
}

- (void)updateStatusMessage {
    [self.statusButton setTitle:[self statusMessage] forState:UIControlStateDisabled];
}

- (void)updateBackgroundColor {
    [self backgroundGradientforHotness: _game.hotness];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"victory"]) {
        VictoryViewController *nextvc = (VictoryViewController *)[segue destinationViewController];
        nextvc.game = _game;
    }
}

@end








