//
//  GameTest.m
//  BeaconFinder
//
//  Created by srussell on 12/6/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Game.h"
#import "LocationFactory.h"

@interface GameTest : XCTestCase

@end

@implementation GameTest
Game *game;

- (void)setUp
{
    [self buildGame];
    [super setUp];
    
}

- (void)tearDown
{
   [super tearDown];
}

- (void)buildGame
{
    LocationFactory* locationFactory = [[LocationFactory alloc] init];
    game = [[Game alloc] initWithLocationFactory:locationFactory];
    [game start: NULL target: NULL];
}

- (void) testStart
{
    XCTAssertNotNil(game.currentLocation);
}

- (void) testStartSetsSkipsToZero {
    XCTAssertEqual(0, game.skips);
}

- (void) testStartDate
{
    XCTAssertNotNil(game.startDate);
}

- (void) testHotnessCalculation
{
    XCTAssertEqual(100, [game calculateHotnessFromRssi:-75]);
    XCTAssertEqual(0, [game calculateHotnessFromRssi:-100]);
    XCTAssertEqual(48, [game calculateHotnessFromRssi:-88]);
}

- (void)testRegisterBeaconFindABeacon
{
    int oldHotness = game.hotness;
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: -85];
    int newHotness = game.hotness;
    
    XCTAssertNotEqual(oldHotness, newHotness);
}

- (void)testRegisterNonCurrentBeacon
{
    int fakeMajorId = 7777;
    int oldHotness = game.hotness;
    [game registerBeaconWithMajor: fakeMajorId
                            Minor: game.currentLocation.minor
                      withReading: -77];
    int newHotness = game.hotness;
 
    XCTAssertEqual(oldHotness, newHotness);
}

- (void)testRegisterNoBeacons
{
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: -85];
    
    [game registerNoBeacons];
    XCTAssertEqual(0, game.hotness);
}

- (void)testIsLocationFoundNo
{
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: LOCATION_RSSI_THRESHOLD - 1];
    XCTAssert(![game isLocationFound]);
}


- (void)testRegisterBeaconFindsLocation
{
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: LOCATION_RSSI_THRESHOLD];
    XCTAssert([game isLocationFound]);
}

- (void)testRegisterBeaconFindingLocationSetsHotnessToZero
{
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: LOCATION_RSSI_THRESHOLD];
    XCTAssertEqual(0, [game hotness]);
}

- (void)testAdvanceLocation
{
    Location * currentLocation = [game currentLocation];
    [game advanceLocation];
    XCTAssertEqual(currentLocation.next, [game currentLocation]);
}

- (void)testAdvanceLocationSetsLocationNotFound
{
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: LOCATION_RSSI_THRESHOLD];
    [game advanceLocation];
    XCTAssert(![game isLocationFound]);
}

- (void)testAdvanceLocationCompletesGameAfterLastLocation
{
    while([game currentLocation].next != NULL)
    {
        [game advanceLocation];
    }
    
    XCTAssert(![game completed]);
    [game advanceLocation];
    XCTAssert([game completed]);
}

- (void)testSkipLocationIncreasesSkips {
    NSInteger oldSkips = game.skips;
    [game skipLocation];
    XCTAssertEqual(oldSkips + 1, game.skips);
}

@end
