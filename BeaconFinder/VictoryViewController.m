//
//  VictoryViewController.m
//  BeaconFinder
//
//  Created by srussell on 12/9/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "VictoryViewController.h"
#import "TimerFormatter.h"

@interface VictoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *skipLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@end

@implementation VictoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL) shouldAutorotate
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.skipLabel setText: [NSString stringWithFormat:@"%d", self.game.skips]];
    [self.timerLabel setText: [TimerFormatter formatSeconds: self.game.elapsedSeconds]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
