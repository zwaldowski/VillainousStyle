//
//  VSReflectiveFillStyle.m
//  VillainousStyle
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "VSReflectiveFillStyle.h"
#import "NSColor+CGColor.h"
#import "NSColor+VSStyle.h"

@implementation VSReflectiveFillStyle

@synthesize color = _color, withBottomHighlight = _withBottomHighlight;

///////////////////////////////////////////////////////////////////////////////////////////////////
// class public

+ (VSReflectiveFillStyle*)styleWithColor:(VSColor*)color next:(VSStyle*)next {
	VSReflectiveFillStyle* style = [[[self alloc] initWithNext:next] autorelease];
	style.color = color;
	style.withBottomHighlight = NO;
	return style;
}

+ (VSReflectiveFillStyle*)styleWithColor:(VSColor*)color withBottomHighlight:(BOOL)withBottomHighlight next:(VSStyle*)next {
	VSReflectiveFillStyle* style = [[[self alloc] initWithNext:next] autorelease];
	style.color = color;
	style.withBottomHighlight = withBottomHighlight;
	return style;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNext:(VSStyle*)next {  
	if (self = [super initWithNext:next]) {
		_color = nil;
	}
	return self;
}

- (void)dealloc {
	VS_RELEASE_SAFELY(_color);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// VSStyle

- (void)draw:(VSStyleContext*)context {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGRect rect = context.frame;
	
	CGContextSaveGState(ctx);
	[context.shape addToPath:rect];
	CGContextClip(ctx);
	
	[_color setFill];
	CGContextFillRect(ctx, rect);
	
	VSColor* topStartHighlight = [VSColor colorWithWhite:1.0 alpha:0.52];
	VSColor* topEndHighlight = [VSColor colorWithWhite:1.0 alpha:0.12];
	VSColor* clearColor = [VSColor colorWithWhite:1.0 alpha:0.0];
	
	VSColor* botEndHighlight;
	if( _withBottomHighlight ) {
		botEndHighlight = [VSColor colorWithWhite:1.0 alpha:0.27];
	} else {
		botEndHighlight = clearColor;
	}
	
	VSColor* colors[] = {
		topStartHighlight, topEndHighlight,
		clearColor,
		clearColor, botEndHighlight};
	CGFloat locations[] = {0, 0.5, 0.5, 0.6, 1.0};
	
#if TARGET_OS_IPHONE
	CGPoint topPoint = CGPointMake(rect.origin.x, rect.origin.y);
	CGPoint bottomPoint = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
#else
	CGPoint bottomPoint = CGPointMake(rect.origin.x, rect.origin.y);
	CGPoint topPoint = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
	
#endif
	
	CGGradientRef gradient = [self newGradientWithColors:colors locations:locations count:5];
	
	CGContextDrawLinearGradient(ctx, gradient,  topPoint, bottomPoint, kCGGradientDrawsAfterEndLocation );
	CGGradientRelease(gradient);
	CGContextRestoreGState(ctx);
	
	return [self.next draw:context];
}

@end
