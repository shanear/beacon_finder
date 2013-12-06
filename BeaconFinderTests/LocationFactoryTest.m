//
//  LocationRepositoryTest.m
//  BeaconFinder
//
//  Created by sanches on 12/5/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LocationFactory.h"
#import "Location.h"

@interface LocationFactoryTest : XCTestCase

@end

@implementation LocationFactoryTest

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

- (void)testFirstLocation
{
    LocationFactory *repository = [[LocationFactory alloc] init];
    Location *location = [repository getFirst];
    
    XCTAssertEqualObjects(location.beaconName , @"LilTurts");
}


@end
