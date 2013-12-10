//
//  LocationTest.m
//  BeaconFinder
//
//  Created by sanches on 12/5/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Location.h"
#import "ESTBeacon.h"

@interface LocationTest : XCTestCase

@end

@implementation LocationTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testInitSetsValues
{
    Location *location = [[Location alloc] initWithName:@"Test"
                                             beaconName: @"Gilbert"
                                                  major: 3
                                                  minor: 1
                                                  clues: @[@"Clue 1"]
                                                funFact: @"FunFact"
                                                   next: Nil];
    XCTAssertEqualObjects(location.name, @"Test");
    XCTAssertEqual(location.major, 3);
    XCTAssertEqual(location.minor, 1);
}

-(void)testInitSetClues
{
    Location *location = [[Location alloc] initWithName: @"TW office"
                                                                       beaconName: @"Gilbert"
                                                  major: 2
                                                  minor: 1
                                                  clues: @[@"Where studios is", @"SF beach"]
                                                funFact: @"FunFact"
                                                   next: Nil];
    
    NSString *firstClue = [location.clues objectAtIndex:0];
    NSString *secondClue = [location.clues objectAtIndex:1];
    XCTAssertEqualObjects(firstClue, @"Where studios is");
    XCTAssertEqualObjects(secondClue, @"SF beach");
}

-(void)testInitSetFunFact
{
    Location *location = [[Location alloc] initWithName: @"TW office"
                                             beaconName: @"Gilbert"
                                                  major: 2
                                                  minor: 1
                                                  clues: @[@"Where studios is", @"SF beach"]
                                                funFact: @"FunFact Yay!"
                                                   next: Nil];
    
    XCTAssertEqualObjects(location.funFact, @"FunFact Yay!");
}

-(void)testLocationShouldKnowAboutNext
{
    Location *nextLocation = [[Location alloc] initWithName: @"loc 2"
                                                                           beaconName: @"Gilbert"
                                                      major: 2
                                                      minor: 1
                                                      clues: @[@"clue 2"]
                                                    funFact: @"FunFact"
                                                       next: Nil];\
    Location *currentLocation = [[Location alloc] initWithName: @"loc 1"                                                                                                     beaconName: @"Rudolph"
                                                         major: 3
                                                         minor: 1
                                                         clues: @[@"clue 1"]
                                                       funFact: @"FunFact"
                                                          next: nextLocation];
    XCTAssertEqualObjects(currentLocation.next, nextLocation);
}

-(void)testLocationSameAsBeacon
{
    Location *currentLocation = [[Location alloc] initWithName: @"loc 1"
                                                    beaconName: @"Bacon"
                                                         major: 321
                                                         minor: 123
                                                         clues: @[@"clue 1"]
                                                       funFact: @"FunFact"
                                                          next: Nil];
    XCTAssertTrue([currentLocation hasMajor:321 minor: 123]);
    XCTAssertFalse([currentLocation hasMajor:123 minor: 456]);
}

@end
