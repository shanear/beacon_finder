//
//  Location.h
//  BeaconFinder
//
//  Created by sanches on 12/5/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject


@property NSString *name;
@property NSString *beaconName;
@property int major;
@property int minor;
@property NSArray *clues;
@property NSString *funFact;

@property Location *next;

- (id) initWithName: (NSString *) name
         beaconName: (NSString *) beaconName
              major: (int) major
              minor: (int) minor
              clues: (NSArray *) clues
            funFact: (NSString *) funFact
               next: (Location *) next;

- (BOOL) hasMajor: (int) major
            minor: (int) minor;

- (NSString *) formattedClues;

@end
