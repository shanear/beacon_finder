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
         beaconName:(NSString *)beaconName
              major: (int) major
              minor: (int) minor
              clues: (NSArray *) clues
               next: (Location *) next
{
    
    self = [super init];
    if (self) {
        _name = [name copy];
        _beaconName = [beaconName copy];
        _major = major;
        _minor = minor;
        _clues = [clues copy];
        _next = next;
    }
    return self;
}

- (BOOL) hasMajor:(int)major minor:(int)minor
{
    return (major == _major && minor == _minor);
}

@end
