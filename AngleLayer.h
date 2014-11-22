//
//  AngleLayer.h
//  RangeFinder
//
//  Created by Bart Shaughnessy on 11/20/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface AngleLayer : CALayer

@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;

@property (strong, nonatomic) UIColor *fillColor;
@property (nonatomic) CGFloat strokeWidth; //this will probably be fixed
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic) CGPoint center; //I don't know why but this won't work. Value doesn't hold.
//@property (nonatomic) CGFloat centerX;  //brute force for now. Research for later.
//@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat strokeLength;
@property (nonatomic) CGFloat hypLength;
@property (nonatomic) CGFloat adjLength;
@property (nonatomic) CGPoint innerVertexPoint;
@property (nonatomic) CGPoint rightAngleVertexPoint;
@property (nonatomic) CGPoint outerVertexPoint;

@end
