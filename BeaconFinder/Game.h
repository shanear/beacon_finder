//
//  Game.h
//  BeaconFinder
//
//  Created by srussell on 12/6/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "LocationFactory.h"

@interface Game : NSObject 
@property (nonatomic, readonly) Location *currentLocation;
@property (nonatomic, readonly) NSInteger hotness;
@property (readonly) BOOL completed;
@property (nonatomic, readonly) NSDate *startDate;

extern const int LOCATION_RSSI_THRESHOLD;

- (id)initWithLocationFactory:(LocationFactory *) locationFactory;

- (void)start;

- (void)advanceLocation;

- (BOOL)isLocationFound;

- (NSInteger)calculateHotnessFromRssi: (int) rssi;

- (void)registerBeaconWithMajor:(int) major
                          Minor:(int) minor
                    withReading:(int) rssi;

- (void)registerNoBeacons;
@end
