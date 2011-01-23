//
//  NSColor+CGColor.h
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

#import "VSGlobal.h"

#if !TARGET_OS_IPHONE
#import <AppKit/AppKit.h>
@interface NSColor (CGColorRef)

@property (readonly) CGColorRef CGColor;
+ (NSColor *)colorWithCGColor:(CGColorRef)aColor;
+ (NSColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
+ (NSColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
+ (NSColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end
#endif