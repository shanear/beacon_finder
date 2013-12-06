//
//  LocationRepository.h
//  BeaconFinder
//
//  Created by sanches on 12/5/13.
//  Copyright (c) 2013 thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface LocationFactory : NSObject

- (Location*)getFirst;

@end
