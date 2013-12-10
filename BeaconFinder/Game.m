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
NSTimeInterval _storedTime;

- (id)initWithLocationFactory:(LocationFactory *)locationFactory
{
    self = [super init];
    if (self)
    {
        _locationFactory = locationFactory;
        _hotness = 0;
        _locationFound = NO;
        _paused = NO;
    }
    return self;
}

- (void)start
{
    _currentLocation = _locationFactory.getFirst;
    _startDate = [NSDate date];
    _skips = 0;
    _storedTime = 0;
}

- (void)pause {
    NSDate *currentTime = [NSDate date];
    NSTimeInterval elapsedTime = [currentTime timeIntervalSinceDate:_startDate];
    _storedTime += elapsedTime;
    _paused = YES;
}

- (void)resume {
    _startDate = [NSDate date];
    _paused = NO;
}

- (NSUInteger)elapsedSeconds {
    NSTimeInterval elapsedTime = 0.0;
    
    if(!self.paused) {
        NSDate *currentTime = [NSDate date];
        elapsedTime += [currentTime timeIntervalSinceDate:_startDate];
    }
    
    elapsedTime += _storedTime;
    
    return (NSUInteger)round(elapsedTime);
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

- (void)skipLocation {
    _skips++;
    [self advanceLocation];
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
