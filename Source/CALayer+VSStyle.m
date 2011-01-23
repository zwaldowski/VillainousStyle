//
//  CALayer+VSStyle.m
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

#import "CALayer+VSStyle.h"
#import "VSStyleContext.h"
#import "VSStyle.h"

@implementation CALayer (VSStyle)

-(void)drawStyle:(VSStyle *)style inRect:(CGRect)rect{
	if (style) {
		VSStyleContext* context = [[[VSStyleContext alloc] init] autorelease];
		context.delegate = self;
		context.frame = rect;
		context.contentFrame = context.frame;
		
		[style draw:context];
//		if (!context.didDrawContent && [self respondsToSelector:@selector(drawLayer:withStyle:)]) {
//			[self drawLayer:context withStyle:style];
//		}
	}
}

@end