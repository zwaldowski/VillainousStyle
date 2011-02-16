//
//  NSView+VSStyle.m
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

#import <VillainousStyle/NSView+VSStyle.h>
#import <VillainousStyle/VSStyleContext.h>

@implementation VSIView (VSStyleAdditions)

-(void)drawStyle:(VSStyle *)style inRect:(CGRect)rect{
	if (style) {
		VSStyleContext* context = [[[VSStyleContext alloc] init] autorelease];
		context.delegate = self;
		context.frame = rect;
		context.contentFrame = context.frame;
		
		[style draw:context];
	}
}

-(void)drawStyle:(VSStyle *)style {
	[self drawStyle:style inRect:self.bounds];
}

- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)top {
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
	CGRect frame = self.frame;
	frame.origin.x = right - frame.size.width;
	self.frame = frame;
}

- (CGFloat)bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
	CGRect frame = self.frame;
	frame.origin.y = bottom - frame.size.height;
	self.frame = frame;
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGFloat)screenX {
	CGFloat x = 0;
	for (VSIView* view = self; view; view = view.superview) {
		x += view.left;
		
		if ([view isKindOfClass:[VSIScrollView class]]) {
			VSIScrollView* scrollView = (VSIScrollView*)view;
			x -= scrollView.contentOffset.x;
		}
	}
	
	return x;
}

- (CGFloat)screenY {
	CGFloat y = 0;
	for (VSIView* view = self; view; view = view.superview) {
		y += view.top;
		
		if ([view isKindOfClass:[VSIScrollView class]]) {
			VSIScrollView* scrollView = (VSIScrollView*)view;
			y -= scrollView.contentOffset.y;
		}
	}
	return y;
}

- (CGRect)screenFrame {
	return CGRectMake(self.screenX, self.screenY, self.width, self.height);
}

- (CGPoint)origin {
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}

- (CGSize)size {
	return self.frame.size;
}

- (void)setSize:(CGSize)size {
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

- (VSIView*)descendantOrSelfWithClass:(Class)cls {
	if ([self isKindOfClass:cls])
		return self;
	
	for (VSIView* child in self.subviews) {
		VSIView* it = [child descendantOrSelfWithClass:cls];
		if (it)
			return it;
	}
	
	return nil;
}

- (VSIView*)ancestorOrSelfWithClass:(Class)cls {
	if ([self isKindOfClass:cls]) {
		return self;
	} else if (self.superview) {
		return [self.superview ancestorOrSelfWithClass:cls];
	} else {
		return nil;
	}
}

- (void)removeAllSubviews {
	while (self.subviews.count) {
		VSIView* child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (CGPoint)offsetFromView:(VSIView*)otherView {
	CGFloat x = 0, y = 0;
	for (VSIView* view = self; view && view != otherView; view = view.superview) {
		x += view.left;
		y += view.top;
	}
	return CGPointMake(x, y);
}

#if !TARGET_OS_IPHONE
- (void)setNeedsDisplay {
	[self setNeedsDisplay:YES];
}
#endif

@end

#if !TARGET_OS_IPHONE
@implementation NSScrollView (VSStyleAdditions)
- (CGPoint)contentOffset {
	CGRect visibleRect = NSRectToCGRect([self documentVisibleRect]);
	return visibleRect.origin;
}

- (void)setContentOffset:(CGPoint)anOffset {
	[self scrollPoint:NSPointFromCGPoint(anOffset)];
}
@end
#endif
