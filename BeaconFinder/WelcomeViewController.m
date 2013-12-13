//
//  WelcomeViewController.m
//  BeaconFinder
//
//  Created by aprice on 12/9/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "WelcomeViewController.h"
#import "ClueViewController.h"
#import "Game.h"

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@end

@implementation WelcomeViewController

Game *_game;
LocationFactory *_locationFactory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)teamNameEntered:(UITextField *)sender {
    [self.view endEditing:YES];
    [self.startButton setEnabled:YES];
    _game.teamName = [sender text];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.startButton setEnabled:NO];
    _locationFactory = [[LocationFactory alloc] init];
    _game = [[Game alloc] initWithLocationFactory:_locationFactory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) shouldAutorotate
{
    return NO;
}

- (IBAction)startButtonClicked:(id)sender {
    [self.startButton setEnabled:NO];
    [_game start: @selector(startSegue) target:self];
}

- (void) startSegue
{
    [self performSegueWithIdentifier:@"start" sender:NULL];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"start"]) {
        ClueViewController *nextvc = (ClueViewController *)[segue destinationViewController];
        nextvc.game = _game;
    }
}
@end
