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
NSURLSession *_session;
BOOL _locationFound;
int const LOCATION_RSSI_THRESHOLD = -75;

NSString const *HOST_URL = @"http://shane-web.herokuapp.com/thoughtworks/";
NSString const *TOKEN = @"TW4EVA8910";

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
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    }
    return self;
}

- (void)start: (SEL)successHandler target:(id)target
{
    _currentLocation = _locationFactory.getFirst;
    _startDate = [NSDate date];
    _skips = 0;
    _storedTime = 0;
    [self sendTeamCreateRequest:successHandler target:target];
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
    [self sendTeamUpdateRequest];
    _currentLocation = _currentLocation.next;
    _locationFound = NO;
    if(_currentLocation == NULL) { _completed = YES; }
}

- (void)registerNoBeacons
{
    _hotness = 0;
}

- (void)sendTeamCreateRequest: (SEL)successHandler target:(id)target
{
    NSString *url = [NSString stringWithFormat:@"%@teams", HOST_URL];
    NSString *params = [NSString stringWithFormat: @"token=%@&team[name]=%@", TOKEN,self.teamName];
    [self sendHTTPRequestWithUrl:url params:params method:@"POST" successHandler:successHandler target:target];
    
}

- (void)sendHTTPRequestWithUrl:(NSString*)url params:(NSString*)params method:(NSString*)method successHandler:(SEL)successHandler target:(id)target
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:url]];
    [request setHTTPMethod:method];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog([NSString stringWithFormat:@"Sending request, url: %@, params: %@", url, params]);
    [[_session dataTaskWithRequest:request
                 completionHandler:^(NSData *data, NSURLResponse *response,
                                     NSError *error) {
                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&error];
                     
                     if(successHandler != NULL)
                     {
                         if([[json valueForKey:@"success"] isEqualToValue: [NSNumber numberWithBool:YES]]) {
                             NSLog(@"Success!");
                             [target performSelector:successHandler];
                         }
                         else {
                             NSLog(@"Error...");
                         }
                     }
                 }] resume];
}

- (void)sendTeamUpdateRequest
{
    NSString *url = [NSString stringWithFormat:@"%@teams/%@?%@", HOST_URL, self.teamName, [NSString stringWithFormat:@"token=%@&team[clue]=%@&team[seconds]=%d&team[skips]=%d", TOKEN, self.currentLocation.beaconName, [self elapsedSeconds], _skips]];

    [self sendHTTPRequestWithUrl:url params:@"" method:@"PUT" successHandler:NULL target:NULL];
}

@end
