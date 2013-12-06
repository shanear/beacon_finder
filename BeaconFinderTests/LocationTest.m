//
//  LocationTest.m
//  BeaconFinder
//
//  Created by sanches on 12/5/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Location.h"

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
    Location *location = [[Location alloc] initWithName:@"Test" beaconId:@"AnotherTest" clues: @[@"Clue 1"] next: Nil];
    XCTAssertEqualObjects(location.name, @"Test");
    XCTAssertEqualObjects(location.beaconId, @"AnotherTest");
}

-(void)testInitSetClues
{
    Location *location = [[Location alloc] initWithName: @"TW office"
                                               beaconId: @"AB123"
                                                  clues: @[@"Where studios is", @"SF beach"]
                                                   next: Nil];
    
    NSString *firstClue = [location.clues objectAtIndex:0];
    NSString *secondClue = [location.clues objectAtIndex:1];
    XCTAssertEqualObjects(firstClue, @"Where studios is");
    XCTAssertEqualObjects(secondClue, @"SF beach");
}

-(void)testLocationShouldKnowAboutNext
{
    Location *nextLocation = [[Location alloc] initWithName: @"loc 2"
                                                   beaconId: @"124"
                                                      clues: @[@"clue 2"]
                                                       next: Nil];
    Location *currentLocation = [[Location alloc] initWithName: @"loc 1"
                                                      beaconId: @"123"
                                                         clues: @[@"clue 1"]
                                                          next: nextLocation];
    XCTAssertEqualObjects(currentLocation.next, nextLocation);
}

@end
