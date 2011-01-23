//
//  VSInnerShadowStyle.m
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

#import "VSInnerShadowStyle.h"
#import "NSColor+CGColor.h"

@implementation VSInnerShadowStyle

///////////////////////////////////////////////////////////////////////////////////////////////////
// VSStyle

- (void)draw:(VSStyleContext*)context {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ctx);
	
	[context.shape addToPath:context.frame];
	CGContextClip(ctx);
	
	[context.shape addInverseToPath:context.frame];
	
	float shadowYOffset = -_offset.height;
#if TARGET_OS_IPHONE
	NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"3.2" options: NSNumericSearch];
	if (order == NSOrderedSame || order == NSOrderedDescending) {
		shadowYOffset = _offset.height;
	}
#endif
	
	CGContextSetShadowWithColor(ctx, CGSizeMake(_offset.width, shadowYOffset), _blur, _color.CGColor);
	CGContextEOFillPath(ctx);
	CGContextRestoreGState(ctx);
	
	return [self.next draw:context];
}

- (CGSize)addToSize:(CGSize)size context:(VSStyleContext*)context {
	if (_next) {
		return [self.next addToSize:size context:context];
	} else {
		return size;
	}
}

@end
