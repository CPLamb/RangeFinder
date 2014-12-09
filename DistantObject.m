//
//  DistantObject.m
//  RangeFinder
//
//  Created by Chris Lamb on 12/2/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "DistantObject.h"

@implementation DistantObject

static DistantObject *singletonDistantObject;

+ (DistantObject *)getSingeltonInstance      //singleton getter method
{
    if (singletonDistantObject == nil) {
        singletonDistantObject = [[super alloc] init];
    }
    NSLog(@"The object is a ??");
    return singletonDistantObject;
}
/*   No longer necessary DELETE
- (DistantObject *)initWithName:(NSString *)name height:(NSString *)height unit:(NSString *)units
{
    DistantObject *distantObject = [[DistantObject alloc] init];
    distantObject.objectName = name;        // @"testName";
    distantObject.height = height;      //@"24";
    distantObject.heightUnits = units;        //@"Feetskis";
    
    NSLog(@"The DistantObject is a %@ %@ %@ ", distantObject.height, distantObject.heightUnits, distantObject.objectName);
    return distantObject;
}
*/
@end
