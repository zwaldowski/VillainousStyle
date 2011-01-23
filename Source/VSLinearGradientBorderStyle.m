//
//  VSLinearGradientBorderStyle.m
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

#import "VSLinearGradientBorderStyle.h"

@implementation VSLinearGradientBorderStyle

@synthesize color1 = _color1, color2 = _color2, location1 = _location1, location2 = _location2, width = _width;

///////////////////////////////////////////////////////////////////////////////////////////////////
// class public

+ (VSLinearGradientBorderStyle*)styleWithColor1:(VSColor*)color1 color2:(VSColor*)color2 width:(CGFloat)width next:(VSStyle*)next {
  VSLinearGradientBorderStyle* style = [[[VSLinearGradientBorderStyle alloc] initWithNext:next] autorelease];
  style.color1 = color1;
  style.color2 = color2;
  style.width = width;
  return style;
}

+ (VSLinearGradientBorderStyle*)styleWithColor1:(VSColor*)color1 location1:(CGFloat)location1 color2:(VSColor*)color2 location2:(CGFloat)location2 width:(CGFloat)width next:(VSStyle*)next {
  VSLinearGradientBorderStyle* style = [[[VSLinearGradientBorderStyle alloc] initWithNext:next] autorelease];
  style.color1 = color1;
  style.color2 = color2;
  style.width = width;
  style.location1 = location1;
  style.location2 = location2;
  return style;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNext:(VSStyle*)next {
  if (self = [super initWithNext:next]) {
	_color1 = nil;
	_color2 = nil;
	_location1 = 0;
    _location2 = 1;
    _width = 1;
  }

  return self;
}

- (void)dealloc {
	VS_RELEASE_SAFELY(_color1);
	VS_RELEASE_SAFELY(_color2);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// VSStyle

- (void)draw:(VSStyleContext*)context {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGRect rect = context.frame;

	CGContextSaveGState(ctx);

	CGRect strokeRect = CGRectInset(context.frame, _width/2, _width/2);
	[context.shape addToPath:strokeRect];
	CGContextSetLineWidth(ctx, _width);
	CGContextReplacePathWithStrokedPath(ctx);
	CGContextClip(ctx);

	VSColor* colors[] = {_color1, _color2};
	CGFloat locations[] = {_location1, _location2};
	CGGradientRef gradient = [self newGradientWithColors:colors locations:locations count:2];
	CGContextDrawLinearGradient(ctx, gradient, CGPointMake(rect.origin.x, rect.origin.y),
                              CGPointMake(rect.origin.x, rect.origin.y+rect.size.height),
                              0);
	CGGradientRelease(gradient);
	CGContextRestoreGState(ctx);
	context.frame = CGRectInset(context.frame, _width, _width);
	return [self.next draw:context];
}


@end
