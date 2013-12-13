//
//  ClueViewController.h
//  BeaconFinder
//
//  Created by srussell on 12/4/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface ClueViewController : UIViewController <UIAlertViewDelegate>
@property (nonatomic) Game *game;
- (int)changeStatus;
- (float)mergeColorValue:(float) oldColor
            withNewColor: (float) newColor
            byPercentage: (int) percentage;
-(void) updateTimer: (NSTimer *) timer;
@end
