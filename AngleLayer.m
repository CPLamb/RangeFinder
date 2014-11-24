//
//  AngleLayer.m
//  RangeFinder
//
//  Created by Bart Shaughnessy on 11/20/14.
//  Copyright (c) 2014 CPL Consulting. All rights reserved.
//

#import "AngleLayer.h"

@implementation AngleLayer

//@dynamic startAngle, endAngle, strokeLength; //add strokelength if we want to modify it here
@dynamic endAngle, strokeLength;

-(id)init{
    self = [super init];
    if (self) {
        //self.fillColor = [UIColor grayColor];
        //self.strokeColor = [UIColor blackColor];
        //self.strokeWidth = 2.0;
        [self setNeedsDisplay];
    }
    
    return self;
}

-(id<CAAction>)actionForKey:(NSString *)event{
    //if ([event isEqualToString:@"startAngle"] || [event isEqualToString:@"endAngle"])
    //if ([event isEqualToString:@"startAngle"] || [event isEqualToString:@"endAngle"] || [event isEqualToString:@"strokeLength"])
    if ([event isEqualToString:@"endAngle"] || [event isEqualToString:@"strokeLength"])
        return [self assignAnimationForKey:event];
    
    return [super actionForKey:event];
}

-(id)initWithLayer:(id)layer{
    if (self = [super initWithLayer:layer]) {
        if ([layer isKindOfClass:[AngleLayer class]]) {
            AngleLayer *nextAngle = (AngleLayer *)layer;
            self.startAngle = nextAngle.startAngle;
            self.endAngle = nextAngle.endAngle;
            self.fillColor = nextAngle.fillColor;
            self.strokeColor = nextAngle.strokeColor;
            self.strokeWidth = nextAngle.strokeWidth;
            //self.opacity = nextAngle.opacity;
            self.center = nextAngle.center;
            self.strokeLength = nextAngle.strokeLength;
            self.adjLength = nextAngle.adjLength;
            self.hypLength = nextAngle.hypLength;
        }
    }
    return self;
}

+(BOOL)needsDisplayForKey:(NSString *)key{
   // if ([key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"])
   // if ([key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"] || [key isEqualToString:@"strokeLength"])
    if ([key isEqualToString:@"endAngle"] || [key isEqualToString:@"strokeLength"])
        return YES;
    
    return [super needsDisplayForKey:key];
}

-(void)drawInContext:(CGContextRef)ctx {
    
    // Create the path
    CGSize myShadowOffset = CGSizeMake(-10, 15);
    CGContextSetShadow(ctx, myShadowOffset, 5);
    CGPoint center = _center;
    CGFloat radius = self.strokeLength/2.0;
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, center.x, center.y);
    
    CGPoint p1 = CGPointMake(center.x + radius * cosf(self.startAngle),
                             center.y + radius * sinf(self.startAngle));
    CGContextAddLineToPoint(ctx, p1.x, p1.y);
    
    if (self.startAngle != self.endAngle){
    int clockwise = self.startAngle > self.endAngle;
    CGContextAddArc(ctx, center.x, center.y, radius, self.startAngle, self.endAngle, clockwise);
    }

    
    CGContextClosePath(ctx);
    
    // Color it
    CGContextSetFillColorWithColor(ctx, self.fillColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, self.strokeColor.CGColor);
    
    CGContextSetLineWidth(ctx, self.strokeWidth);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
}

-(CABasicAnimation *)assignAnimationForKey:(NSString *)key{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:key];
    anim.fromValue = [[self presentationLayer] valueForKey:key];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.duration = 0.75;
    return anim;
}

@end
