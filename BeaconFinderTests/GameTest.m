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
    NSLog(@"Setting Up woo!!!!!!!!!!!!!!!!!!!!!!!");
    
}

- (void)tearDown
{
    NSLog(@"Tearning down boo......................");
   [super tearDown];
}

- (void)buildGame
{
    LocationFactory* locationFactory = [[LocationFactory alloc] init];
    game = [[Game alloc] initWithLocationFactory:locationFactory];
}

- (void) testStart
{
    XCTAssertNil(game.currentLocation);
    [game start];
    XCTAssertNotNil(game.currentLocation);
}

- (void) testHotnessCalculation
{
    XCTAssertEqual(100, [game calculateHotnessFromRssi:-75]);
    XCTAssertEqual(0, [game calculateHotnessFromRssi:-100]);
    XCTAssertEqual(48, [game calculateHotnessFromRssi:-88]);
}

- (void)testRegisterBeaconFindABeacon
{
    [game start];
    
    int oldHotness = game.hotness;
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: -85];
    int newHotness = game.hotness;
    
    XCTAssertNotEqual(oldHotness, newHotness);
}

- (void)testRegisterNonCurrentBeacon
{
    [game start];

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
    [game start];
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: -85];
    
    [game registerNoBeacons];
    XCTAssertEqual(0, game.hotness);
}

- (void)testIsLocationFoundNo
{
    [game start];
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: LOCATION_RSSI_THRESHOLD - 1];
    XCTAssert(![game isLocationFound]);
}


- (void)testRegisterBeaconFindsLocation
{
    [game start];
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: LOCATION_RSSI_THRESHOLD];
    XCTAssert([game isLocationFound]);
}

- (void)testRegisterBeaconFindingLocationSetsHotnessToZero
{
    [game start];
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: LOCATION_RSSI_THRESHOLD];
    XCTAssertEqual(0, [game hotness]);
}

- (void)testAdvanceLocation
{
    [game start];
    Location * currentLocation = [game currentLocation];
    [game advanceLocation];
    XCTAssertEqual(currentLocation.next, [game currentLocation]);
}

- (void)testAdvanceLocationSetsLocationNotFound
{
    [game start];
    [game registerBeaconWithMajor: game.currentLocation.major
                            Minor: game.currentLocation.minor
                      withReading: LOCATION_RSSI_THRESHOLD];
    [game advanceLocation];
    XCTAssert(![game isLocationFound]);
}

- (void)testAdvanceLocationCompletesGameAfterLastLocation
{
    [game start];
    
    while([game currentLocation].next != NULL)
    {
        [game advanceLocation];
    }
    
    XCTAssert(![game completed]);
    [game advanceLocation];
    XCTAssert([game completed]);
}

@end
