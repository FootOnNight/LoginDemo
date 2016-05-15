//
//  KeyBoardButton.m
//  LoginDemo
//
//  Created by MaxX on 16/4/29.
//  Copyright © 2016年 szjy. All rights reserved.
//

#import "KeyBoardButton.h"

@interface KeyBoardButton ()
{
    UIColor *_borderColor;
    
    CGFloat _borderWidth;
}

@end

@implementation KeyBoardButton


-(void)addBorder:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{

    _borderColor = borderColor;

    _borderWidth = borderWidth;

    [self setNeedsDisplay];

}

//-(void)addBorder:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
//    
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    
//    if (self.frame.origin.y != 0) {
//        [path moveToPoint:CGPointMake(0, 0)];
//        [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
//    }
//    else {
//        [path moveToPoint:CGPointMake(self.bounds.size.width, 0)];
//    }
//    
//    if (self.superview.bounds.size.width != CGRectGetMaxX(self.frame)) {
//        
//        [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
//    }
//    
//    maskLayer.strokeColor = borderColor.CGColor;
//    
//    path.lineWidth = borderWidth;
//    
//    maskLayer.path = path.CGPath;
//    
//    maskLayer.fillColor = [UIColor clearColor].CGColor;
//    
//    [self.layer addSublayer:maskLayer];
//    
//    
//}

-(void)drawRect:(CGRect)rect{
        
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    
    if (self.frame.origin.y != 0) {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    }
    else {
        [path moveToPoint:CGPointMake(self.bounds.size.width, 0)];
    }

    if (self.superview.bounds.size.width != CGRectGetMaxX(self.frame)) {
        
        [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    }
    
    CGContextAddPath(context, path.CGPath);
    
    CGContextSetLineWidth(context, _borderWidth);
    
    [_borderColor set];
    
    CGContextStrokePath(context);
    
}


@end
