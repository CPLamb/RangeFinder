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
    return singletonDistantObject;
}

@end
