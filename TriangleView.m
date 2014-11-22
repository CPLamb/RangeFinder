//
//  TriangleView.m
//  RangeFinder
//
//  Created by Bart Shaughnessy on 11/18/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView{
    CGFloat adjLength;
    CGFloat hypLength;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGSize myShadowOffset = CGSizeMake(-10, 15);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShadow(context, myShadowOffset, 5);

    CGPoint topVertex = CGPointMake(25.0, 25.0);
    CGPoint rightAngleVertex = CGPointMake(25, [UIScreen mainScreen].bounds.size.width-25);
    CGPoint innerVertex = CGPointMake([UIScreen mainScreen].bounds.size.height/3, [UIScreen mainScreen].bounds.size.width-25);
    CGPoint outerRightVertex = CGPointMake([UIScreen mainScreen].bounds.size.height*0.9, [UIScreen mainScreen].bounds.size.width-25);
    
    CGMutablePathRef objectHeightPath = CGPathCreateMutable();
    CGPathMoveToPoint(objectHeightPath, NULL, topVertex.x, topVertex.y);
    CGPathAddLineToPoint(objectHeightPath, NULL, rightAngleVertex.x, rightAngleVertex.y);
    
    CAShapeLayer *objectHeightLayer = [CAShapeLayer layer];
    [objectHeightLayer setPath: objectHeightPath];
    objectHeightLayer.fillColor = nil;
    [self.layer addSublayer:objectHeightLayer];
    
    CGMutablePathRef innerTrianglePath = CGPathCreateMutable();
    CGPathMoveToPoint(innerTrianglePath, NULL, rightAngleVertex.x, rightAngleVertex.y);
    CGPathAddLineToPoint(innerTrianglePath, NULL, innerVertex.x, innerVertex.y);
    CGPathAddLineToPoint(innerTrianglePath, NULL, topVertex.x, topVertex.y);
    
    CAShapeLayer *innerTriangleLayer = [CAShapeLayer layer];
    [innerTriangleLayer setPath:innerTrianglePath];
    innerTriangleLayer.backgroundColor = [UIColor clearColor].CGColor;
    innerTriangleLayer.fillColor = nil; //makes the layer transparent. Background is black otherwise
    [self.layer addSublayer:innerTriangleLayer];
    
    AngleLayer *arcSlice = [AngleLayer layer];
    arcSlice.strokeColor = [UIColor colorWithWhite:0.25 alpha:1.0];
    arcSlice.fillColor = [UIColor greenColor];
    arcSlice.strokeWidth = 3.5;
    arcSlice.frame = self.bounds;
    arcSlice.startAngle = -M_PI;
    arcSlice.endAngle = -M_PI;
    arcSlice.center = innerVertex;
    arcSlice.strokeLength = innerVertex.x - rightAngleVertex.x/2;
    arcSlice.adjLength = innerVertex.x - rightAngleVertex.x;
    arcSlice.hypLength = sqrt(pow(rightAngleVertex.y, 2.0) + pow(topVertex.y, 2.0));
    arcSlice.innerVertexPoint = innerVertex;
    [innerTriangleLayer addSublayer:arcSlice];
    
    CGMutablePathRef outerTrianglePath = CGPathCreateMutable();
    CGPathMoveToPoint(outerTrianglePath, NULL, rightAngleVertex.x, rightAngleVertex.y);
    CGPathAddLineToPoint(outerTrianglePath, NULL, outerRightVertex.x, outerRightVertex.y);
    CGPathAddLineToPoint(outerTrianglePath, NULL, topVertex.x, topVertex.y);
    
    CAShapeLayer *outerTriangleLayer = [CAShapeLayer layer];
    [outerTriangleLayer setPath:outerTrianglePath];
    outerTriangleLayer.backgroundColor = nil;
    outerTriangleLayer.fillColor = nil;
    [self.layer addSublayer:outerTriangleLayer];
    
    
    AngleLayer *outerArcSlice = [AngleLayer layer];
    outerArcSlice.strokeColor = [UIColor colorWithWhite:0.25 alpha:1.0];
    outerArcSlice.fillColor = [UIColor greenColor];
    outerArcSlice.strokeWidth = 3.5;
    outerArcSlice.frame = self.bounds;
    outerArcSlice.startAngle = -M_PI;
    outerArcSlice.endAngle = -M_PI;
    outerArcSlice.center = outerRightVertex;
    //outerArcSlice.strokeLength = outerRightVertex.x - innerVertex.x;
    //outerArcSlice.strokeLength = outerRightVertex.x - innerVertex.x;
    outerArcSlice.strokeLength = 0.0f;
    outerArcSlice.adjLength = outerRightVertex.x - rightAngleVertex.x;
    outerArcSlice.hypLength = sqrt(pow(rightAngleVertex.y, 2.0) + pow(topVertex.y, 2.0));
    outerArcSlice.innerVertexPoint = innerVertex;
    outerArcSlice.outerVertexPoint = outerRightVertex;
    [outerTriangleLayer addSublayer:outerArcSlice];
    
    
    CGMutablePathRef baseLengthPath = CGPathCreateMutable();
    CGPathMoveToPoint(baseLengthPath, NULL, innerVertex.x, innerVertex.y);
    CGPathAddLineToPoint(baseLengthPath, NULL, outerRightVertex.x, outerRightVertex.y);
    
    CAShapeLayer *baseLengthLayer = [CAShapeLayer layer];
    [baseLengthLayer setPath:baseLengthPath];
    baseLengthLayer.backgroundColor = nil;
    baseLengthLayer.fillColor = nil;
    [self.layer addSublayer:baseLengthLayer];
    
    AngleLayer *baseSlice = [AngleLayer layer];
   // baseSlice.strokeColor = [UIColor colorWithWhite:0.25 alpha:1.0];
    baseSlice.strokeColor = [UIColor greenColor];
    baseSlice.fillColor = [UIColor greenColor];
    baseSlice.strokeWidth = 5.0;
    baseSlice.frame = self.bounds;
    //baseSlice.startAngle = M_PI;
    baseSlice.startAngle= 0.0f;
    //baseSlice.endAngle = M_PI;
    baseSlice.center = innerVertex;
    //baseSlice.strokeLength = outerRightVertex.x - innerVertex.x;
    baseSlice.strokeLength = 0.0;
    baseSlice.adjLength = outerRightVertex.x - innerVertex.x;
    //baseSlice.hypLength = sqrt(pow(rightAngleVertex.y, 2.0) + pow(topVertex.y, 2.0));
    baseSlice.hypLength = outerRightVertex.x - innerVertex.x;
    baseSlice.innerVertexPoint = innerVertex;
    baseSlice.outerVertexPoint = outerRightVertex;
    [baseLengthLayer addSublayer:baseSlice];

    CGContextAddPath(context, objectHeightPath);
    CGContextAddPath(context, innerTrianglePath);
    CGContextAddPath(context, outerTrianglePath);
    
    CGContextSetStrokeColorWithColor(context,[UIColor orangeColor].CGColor);
    CGContextSetLineWidth(context, 3.5);
    CGContextStrokePath(context);
    
    CGPathRelease(innerTrianglePath);
    //CGContextClosePath(context);
}

@end
