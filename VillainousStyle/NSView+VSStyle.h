//
//  NSView+VSStyle.h
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

#import <VillainousStyle/VSGlobal.h>
#import <VillainousStyle/VSStyle.h>

@interface VSIView (VSStyleAdditions)

-(void)drawStyle:(VSStyle *)style inRect:(CGRect)rect;
-(void)drawStyle:(VSStyle *)style;

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic, readonly) CGFloat screenX;
@property (nonatomic, readonly) CGFloat screenY;
@property (nonatomic, readonly) CGRect screenFrame;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
- (VSIView*)descendantOrSelfWithClass:(Class)cls;
- (VSIView*)ancestorOrSelfWithClass:(Class)cls;
- (void)removeAllSubviews;
- (CGPoint)offsetFromView:(VSIView*)otherView;

#if !TARGET_OS_IPHONE
- (void)setNeedsDisplay;
#endif

@end

#if !TARGET_OS_IPHONE
@interface NSScrollView (VSStyleAdditions)
@property (nonatomic) CGPoint contentOffset;
@end
#endif