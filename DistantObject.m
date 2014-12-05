//
//  DistantObject.m
//  RangeFinder
//
//  Created by Chris Lamb on 12/2/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "DistantObject.h"

@implementation DistantObject

- (DistantObject *)initWithName:(NSString *)name height:(NSString *)height unit:(NSString *)units
{
    DistantObject *distantObject = [[DistantObject alloc] init];
    distantObject.objectName = name;        // @"testName";
    distantObject.height = height;      //@"24";
    distantObject.units = units;        //@"Feetskis";
    
    NSLog(@"The DistantObject is a %@ %@ %@ ", distantObject.height, distantObject.units, distantObject.objectName);
    return distantObject;
}

@end
