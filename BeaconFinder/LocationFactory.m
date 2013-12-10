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
    
    Location *sixthLocation = [[Location alloc] initWithName: @"SFMOMA"
                                                  beaconName: @"Gilbert"
                                                       major: 57068
                                                       minor: 56361
                                                       clues:@[@"Mikey's Favorite museum", @"Sucks that it's closed", @"Who needs NY?"]
                                                     funFact: @"Even though the main branch is closed, you can still check out SFMOMA exhibitions and events around the Bay Area!"
                                                        next: Nil];
    
    Location *fifthLocation = [[Location alloc] initWithName: @""
                                                  beaconName: @"KevinBeacon"
                                                       major: 16768
                                                       minor: 53642
                                                       clues:@[@"One of Shane and Alexandra's favorite POPOS", @"It's a freaking Statue", @"Water"]
                                                     funFact: @""
                                                        next: sixthLocation];
    
    Location *fourthLocation = [[Location alloc] initWithName: @"House of Shields"
                                                   beaconName: @"Rudolph"
                                                        major: 60647
                                                        minor: 54514
                                                        clues:@[@"One of Badri's favorite bars", @"Over a century old", @"Defensive"]
                                                      funFact: @"There are no clocks or TVs on the premise."
                                                         next: fifthLocation];
    
    Location *thirdLocation = [[Location alloc] initWithName: @"Hops & Hominy"
                                                  beaconName: @"Whatever"
                                                       major: 65415
                                                       minor: 17595
                                                       clues:@[@"One of Dean's favorite watering holes", @"Snack on some grits alongside your homebrew"]
                                                     funFact: @"So the timer is paused.\n\nTake a minute and go ask the bartender for a Dean Machine, named after the Dean Machine himself."
                                                        next: fourthLocation];
    
    Location *secondLocation = [[Location alloc] initWithName: @"Z&Y"
                                                   beaconName: @"Stumpy"
                                                        major: 44495
                                                        minor: 19404
                                                        clues:@[@"The Studios team loves to get lunch here", @"Late in the alphabet", @"HELLA SPICY!"]
                                                      funFact: @"President Obama stopped by in 2012!"
                                                         next: thirdLocation];

    _firstLocation = [[Location alloc] initWithName: @"Office Coffee Machine"
                                         beaconName: @"LilTurts"
                                              major: 37678
                                              minor: 62097
                                              clues:@[@"Let's start on the 16th",@"Lungo Forte", @"Main source of TWer energy"]
                                            funFact: @"Nice. You figured out your first clue! They get harder from here on out. We’re using estimote beacons to notify your iDevice when you approach the clue location--the Estimotes were kindly provided by Dean Bosche."
                                               next: secondLocation];
    return self;
}



- (Location*) getFirst {
    return _firstLocation;
}

@end
