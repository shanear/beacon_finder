//
//  TimerFormatter.m
//  BeaconFinder
//
//  Created by srussell on 12/10/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "TimerFormatter.h"

@interface TimerFormatter ()

@end

@implementation TimerFormatter
+ (NSString *) formatSeconds: (NSUInteger) seconds
{
    return [NSString stringWithFormat:@"%02u:%02u:%02u", seconds/3600, (seconds/60)%60, seconds%60];
}

@end
