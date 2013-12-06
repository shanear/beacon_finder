//
//  ClueViewControllerTests.m
//  BeaconFinder
//
//  Created by aprice on 12/5/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ClueViewController.h"

@interface ClueViewControllerTests : XCTestCase

@end

@implementation ClueViewControllerTests
ClueViewController * clueViewController;

- (void)setUp
{
    [super setUp];
    clueViewController = [[ClueViewController alloc] init];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testChangeStatusShouldChangeCurrentStatus
{
    int result = [clueViewController changeStatus];
    XCTAssertEqual(1, result, @"test test");
}

- (void) testMergeColors {
    float result = [clueViewController mergeColorValue: 0.0
                                      withNewColor: 1.0
                                      byPercentage: 100
                    ];
    XCTAssertEqualWithAccuracy(1.0, result, 0.0001,@"color was WRONG!");
}




@end
