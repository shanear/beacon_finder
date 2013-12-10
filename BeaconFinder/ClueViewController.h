//
//  ClueViewController.h
//  BeaconFinder
//
//  Created by srussell on 12/4/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClueViewController : UIViewController
- (int)changeStatus;
- (float)mergeColorValue:(float) oldColor
            withNewColor: (float) newColor
            byPercentage: (int) percentage;
-(void) updateTimer: (NSTimer *) timer;
@end
