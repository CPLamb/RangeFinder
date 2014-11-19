//
//  TriangleView.m
//  RangeFinder
//
//  Created by Bart Shaughnessy on 11/18/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView


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
    
    CGMutablePathRef trianglePaths = CGPathCreateMutable();
   
    CGPathMoveToPoint(trianglePaths, NULL, innerVertex.x, innerVertex.y);
    CGPathAddLineToPoint(trianglePaths, NULL, topVertex.x, topVertex.y);
    CGPathAddLineToPoint(trianglePaths, NULL, rightAngleVertex.x, rightAngleVertex.y);
    CGPathAddLineToPoint(trianglePaths, NULL, innerVertex.x, innerVertex.y);
    CGPathAddLineToPoint(trianglePaths, NULL, outerRightVertex.x, outerRightVertex.y);
    CGPathAddLineToPoint(trianglePaths, NULL, topVertex.x, topVertex.y);

    CGContextAddPath(context, trianglePaths);
    
    CGContextSetStrokeColorWithColor(context,[UIColor orangeColor].CGColor);
    CGContextSetLineWidth(context, 3.0);
    CGContextStrokePath(context);
    CGPathRelease(trianglePaths);
    CGContextClosePath(context);
    
    /*
    CAShapeLayer *triangleMaskLayer = [CAShapeLayer layer];
    [triangleMaskLayer setPath:trianglePaths];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.backgroundColor = [UIColor colorWithWhite:0.25 alpha:0.5];
    view.layer.mask = triangleMaskLayer;
    */
    
  //  UIBezierPath *trianglePath = [UIBezierPath bezierPathWithCGPath:trianglePaths];
}


@end
