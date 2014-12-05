//
//  DistantObject.h
//  RangeFinder
//
//  Created by Chris Lamb on 12/2/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistantObject : NSObject

@property NSString *objectName;
@property NSString *height;
@property NSString *units;

- (DistantObject *)initWithName:(NSString *)name height:(NSString *)height unit:(NSString *)units;

@end
