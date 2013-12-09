//
//  Game.m
//  BeaconFinder
//
//  Created by srussell on 12/6/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

LocationFactory *_locationFactory;
BOOL _locationFound;
int const LOCATION_RSSI_THRESHOLD = -75;

- (id)initWithLocationFactory:(LocationFactory *)locationFactory
{
    self = [super init];
    if (self)
    {
        _locationFactory = locationFactory;
        _hotness = 0;
        _locationFound = NO;
    }
    return self;
}

- (void)start
{
    _currentLocation = _locationFactory.getFirst;
}

- (BOOL) isLocationFound
{
    return _locationFound;
}

- (void) updateLocationFound
{
    if(!_locationFound && (_hotness >= 100))
    {
        _locationFound = YES;
        _hotness = 0;
    }
}

- (NSInteger)calculateHotnessFromRssi:(int)rssi
{
    return 100 - ( -(rssi + -LOCATION_RSSI_THRESHOLD) * 4);
}

- (void)registerBeaconWithMajor:(int) major
                          Minor:(int) minor
                    withReading:(int) rssi
{
    if(self.currentLocation && [self.currentLocation hasMajor:major minor:minor])
    {
        _hotness = [self calculateHotnessFromRssi: rssi];
        [self updateLocationFound];
    }
}

- (void)advanceLocation
{
    _currentLocation = _currentLocation.next;
    _locationFound = NO;
    if(_currentLocation == NULL) { _completed = YES; }
}

- (void)registerNoBeacons
{
    _hotness = 0;
}

@end
