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
//    Gilbert (Blueberry Pie)
//    B9407F30-F5F8-466E-AFF9-25556B57FE6D  - M 57068 - m 56361
//    
//    Kevin Beacon (Icy Marshmallow)
//    B9407F30-F5F8-466E-AFF9-25556B57FE6D - M 16768 - m 53642
//    
//    Rudolph (Icy Marshmallow)
//    B9407F30-F5F8-466E-AFF9-25556B57FE6D - M 60647 - m 54414
//    
//    Whatever (Blueberry Pie)
//    B9407F30-F5F8-466E-AFF9-25556B57FE6D - M 65415 - m 17595
//    
//    Stumpy (Mint Cocktail)
//    B9407F30-F5F8-466E-AFF9-25556B57FE6D - M 44495 - m 19404
//    
//    Lil’ Turts (int Cocktail)
//    B9407F30-F5F8-466E-AFF9-25556B57FE6D - M 37678 - m 62097
    
    Location *sixthLocation = [[Location alloc] initWithName: @""
                                                  beaconName: @"Gilbert"
                                                       major: 57068
                                                       minor: 56361
                                                       clues:@[@""]
                                                     funFact: @""
                                                        next: Nil];
    
    Location *fifthLocation = [[Location alloc] initWithName: @""
                                                  beaconName: @"KevinBeacon"
                                                       major: 16768
                                                       minor: 53642
                                                       clues:@[@""]
                                                     funFact: @""
                                                        next: sixthLocation];
    
    Location *fourthLocation = [[Location alloc] initWithName: @""
                                                   beaconName: @"Rudolph"
                                                        major: 60647
                                                        minor: 54514
                                                        clues:@[@""]
                                                      funFact: @""
                                                         next: fifthLocation];
    
    Location *thirdLocation = [[Location alloc] initWithName: @""
                                                  beaconName: @"Whatever"
                                                       major: 65415
                                                       minor: 17595
                                                       clues:@[@""]
                                                     funFact: @""
                                                        next: fourthLocation];
    
    Location *secondLocation = [[Location alloc] initWithName: @""
                                                   beaconName: @"Stumpy"
                                                        major: 44495
                                                        minor: 19404
                                                        clues:@[@""]
                                                      funFact: @""
                                                         next: thirdLocation];

    _firstLocation = [[Location alloc] initWithName: @""
                                         beaconName: @"LilTurts"
                                              major: 37678
                                              minor: 62097
                                              clues:@[@""]
                                            funFact: @""
                                               next: secondLocation];
    return self;
}



- (Location*) getFirst {
    return _firstLocation;
}

@end
