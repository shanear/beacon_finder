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
@property NSString *beaconId;
@property NSArray *clues;
@property Location *next;

- (id) initWithName: (NSString *) name
           beaconId: (NSString *) beaconId
              clues: (NSArray *) clues
               next: (Location *) next;


@end
