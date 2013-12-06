//
//  Location.m
//  BeaconFinder
//
//  Created by sanches on 12/5/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id) initWithName: (NSString *) name
           beaconId: (NSString *) beaconId
              clues: (NSArray *) clues
               next: (Location *) next
{
    
    self = [super init];
    if (self) {
        _name = [name copy];
        _beaconId = [beaconId copy];
        _clues = [clues copy];
        _next = next;
    }
    return self;
}

@end
