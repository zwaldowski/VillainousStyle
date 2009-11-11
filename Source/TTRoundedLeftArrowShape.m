//
//  TTRoundedLeftArrowShape.m
//  TTStyleMacTest
//
//  Created by Steve Streza on 7/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TTRoundedLeftArrowShape.h"


@implementation TTRoundedLeftArrowShape

@synthesize radius = _radius;

///////////////////////////////////////////////////////////////////////////////////////////////////
// class public

+ (TTRoundedLeftArrowShape*)shapeWithRadius:(CGFloat)radius {
	TTRoundedLeftArrowShape* shape = [[[TTRoundedLeftArrowShape alloc] init] autorelease];
	shape.radius = radius;
	return shape;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (void)addToPath:(CGRect)rect {
	[self openPath:rect];
	
	CGFloat fw = rect.size.width;
	CGFloat fh = rect.size.height;
	CGFloat point = floor(fh/kArrowPointWidth);
	CGFloat radius = TTRadius(_radius);
	CGFloat radius2 = radius*kArrowRadius;
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextMoveToPoint(context, 0, floor(fh/2));
	CGContextAddArcToPoint(context, point, 0, floor(fw-radius), 0, radius2);
	CGContextAddArcToPoint(context, fw, 0, fw, floor(radius), radius);
	CGContextAddArcToPoint(context, fw, fh, floor(point+radius2), fh, radius);
	CGContextAddArcToPoint(context, point, fh, 0, floor(fh/2), radius2);
	
	[self closePath:rect];
}

- (void)addInverseToPath:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat fw = rect.size.width;
	CGFloat fh = rect.size.height;
	CGFloat point = floor(fh/kArrowPointWidth);
	CGFloat radius = TTRadius(_radius);
	CGFloat radius2 = radius*kArrowRadius;
	
	CGFloat width = 5;
	CGRect shadowRect = CGRectMake(-width, -width, fw+width*2, fh+width*2);
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, nil, shadowRect);
	CGPathCloseSubpath(path);
	
	CGPathMoveToPoint(path, nil, 0, floor(fh/2));
	CGPathAddArcToPoint(path, nil, point, 0, floor(fw-radius), 0, radius2);
	CGPathAddArcToPoint(path, nil, fw, 0, fw, floor(radius), radius);
	CGPathAddArcToPoint(path, nil, fw, fh, floor(point+radius2), fh, radius);
	CGPathAddArcToPoint(path, nil, point, fh, 0, floor(fh/2), radius2);
	
	[self openPath:rect];
	CGContextAddPath(context, path);
	[self closePath:rect];
	
	CGPathRelease(path);
}

- (void)addTopEdgeToPath:(CGRect)rect lightSource:(NSInteger)lightSource {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat fw = rect.size.width;
	CGFloat fh = rect.size.height;
	CGFloat point = floor(fh/kArrowPointWidth);
	CGFloat radius = TTRadius(_radius);
	CGFloat radius2 = radius*kArrowRadius;
	
	CGContextMoveToPoint(context, 0, floor(fh/2));
	CGContextAddArcToPoint(context, point, 0, floor(fw-radius), 0, radius2);
	
	if (lightSource >= 0 && lightSource <= 90) {
		CGContextAddLineToPoint(context, floor(fw-radius), 0);
	} else {
		CGContextAddArcToPoint(context, fw, 0, fw, floor(radius), radius);
	}
}

- (void)addRightEdgeToPath:(CGRect)rect lightSource:(NSInteger)lightSource {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat fw = rect.size.width;
	CGFloat fh = rect.size.height;
	CGFloat radius = TTRadius(_radius);
	
	if (lightSource >= 0 && lightSource <= 90) {
		CGContextMoveToPoint(context, floor(fw-radius), 0);
		CGContextAddArcToPoint(context, fw, 0, fw, floor(radius), radius);
	} else {
		CGContextMoveToPoint(context, fw, radius);
		CGContextAddLineToPoint(context, fw, fh-radius);
	}
}

- (void)addBottomEdgeToPath:(CGRect)rect lightSource:(NSInteger)lightSource {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat fw = rect.size.width;
	CGFloat fh = rect.size.height;
	CGFloat point = floor(fh/kArrowPointWidth);
	CGFloat radius = TTRadius(_radius);
	CGFloat radius2 = _radius*kArrowRadius;
	
	CGContextMoveToPoint(context, fw, floor(fh-radius));
	CGContextAddArcToPoint(context, fw, fh, floor(point+radius2), fh, radius);
	CGContextAddLineToPoint(context, floor(point+radius2)-1, fh);
}

- (void)addLeftEdgeToPath:(CGRect)rect lightSource:(NSInteger)lightSource {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat fh = rect.size.height;
	CGFloat point = floor(fh/kArrowPointWidth);
	CGFloat radius = TTRadius(_radius);
	CGFloat radius2 = radius*kArrowRadius;
	
	CGContextMoveToPoint(context, floor(point+radius2), fh);
	CGContextAddArcToPoint(context, point, fh, 0, floor(fh/2), radius2);
	CGContextAddLineToPoint(context, 0, floor(fh/2));
}

- (UIEdgeInsets)insetsForSize:(CGSize)size {
	CGFloat fh = size.height/3;
	return UIEdgeInsetsMake(0, floor(TTRadius(_radius)), 0, 0);
	//  CGFloat fh = size.height/3;
	//  return UIEdgeInsetsMake(floor(TTRadius(_radius)), floor(TTRadius(_radius))*2,
	//                          floor(TTRadius(_radius)), floor(TTRadius(_radius)));
}


@end