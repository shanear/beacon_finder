//
//  LocationRepository.m
//  BeaconFinder
//
//  Created by sanches on 12/5/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import "LocationFactory.h"

@implementation LocationFactory

Location * _firstLocation;

- (id) init
{
    self = [super init];
    //Beacon Ids
    //B9407F30-F5F8-466E-AFF9-25556B57FE6D
    //
    
    Location *sixthLocation = [[Location alloc] initWithName: @"ThoughtWorks Office"
                                                    beaconId: @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
                                                       clues:@[@"No clue"]
                                                        next: Nil];
    
    Location *fifthLocation = [[Location alloc] initWithName: @"ThoughtWorks Office"
                                                    beaconId: @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
                                                       clues:@[@"No clue"]
                                                        next: sixthLocation];
    
    Location *fourthLocation = [[Location alloc] initWithName: @"ThoughtWorks Office"
                                                     beaconId: @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
                                                        clues:@[@"No clue"]
                                                         next: fifthLocation];
    
    Location *thirdLocation = [[Location alloc] initWithName: @"ThoughtWorks Office"
                                                    beaconId: @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
                                                       clues:@[@"No clue"]
                                                        next: fourthLocation];
    
    Location *secondLocation = [[Location alloc] initWithName: @"ThoughtWorks Office"
                                                     beaconId: @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
                                                        clues:@[@"No clue"]
                                                         next: thirdLocation];

    _firstLocation = [[Location alloc] initWithName: @"ThoughtWorks Office"
                                           beaconId: @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
                                              clues:@[@"No clue"]
                                               next: secondLocation];
    return self;
}



- (Location*) getFirst {
    return _firstLocation;
}

@end
