//
//  VSShape.m
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

#import "VSShape.h"

@class VSRectangleShape;

@implementation VSShape

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (void)openPath:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextBeginPath(context);
}

- (void)closePath:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClosePath(context);
	CGContextRestoreGState(context);
}

- (UIEdgeInsets)insetsForSize:(CGSize)size {
	return UIEdgeInsetsZero;
}

- (void)addTopEdgeToPath:(CGRect)rect lightSource:(NSInteger)lightSource {
}

- (void)addRightEdgeToPath:(CGRect)rect lightSource:(NSInteger)lightSource {
}

- (void)addBottomEdgeToPath:(CGRect)rect lightSource:(NSInteger)lightSource {
}

- (void)addLeftEdgeToPath:(CGRect)rect lightSource:(NSInteger)lightSource {
}

- (void)addToPath:(CGRect)rect {
}

- (void)addInverseToPath:(CGRect)rect {
}

@end
