//
//  NSImage+ContentMode.m
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

#import "NSImage+ContentMode.h"

@implementation VSImage (ContentMode)

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
	CGContextBeginPath(context);
	CGContextSaveGState(context);
	
	if (radius == 0) {
		CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
		CGContextAddRect(context, rect);
	} else {
		CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
		CGContextScaleCTM(context, radius, radius);
		float fw = CGRectGetWidth(rect) / radius;
		float fh = CGRectGetHeight(rect) / radius;
		
		CGContextMoveToPoint(context, fw, fh/2);
		CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
		CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
		CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
		CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
	}
	
	CGContextClosePath(context);
	CGContextRestoreGState(context);
}

- (void)drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode {
	BOOL clip = NO;
	CGRect originalRect = rect;
	if (self.size.width != rect.size.width || self.size.height != rect.size.height) {
		clip = contentMode != UIViewContentModeScaleAspectFill && contentMode != UIViewContentModeScaleAspectFit && contentMode != UIViewContentModeCenter;
		if (contentMode == UIViewContentModeLeft) {
			rect = CGRectMake(rect.origin.x, rect.origin.y + floor(rect.size.height/2 - self.size.height/2), self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeRight) {
			rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width), rect.origin.y + floor(rect.size.height/2 - self.size.height/2), self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeTop) {
			rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2), rect.origin.y, self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeBottom) {
			rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2), rect.origin.y + floor(rect.size.height - self.size.height), self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeCenter) {
			rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2), rect.origin.y + floor(rect.size.height/2 - self.size.height/2), self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeBottomLeft) {
			rect = CGRectMake(rect.origin.x, rect.origin.y + floor(rect.size.height - self.size.height), self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeBottomRight) {
			rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width), rect.origin.y + (rect.size.height - self.size.height), self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeTopLeft) {
			rect = CGRectMake(rect.origin.x, rect.origin.y, self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeTopRight) {
			rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width), rect.origin.y, self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeScaleAspectFill) {
#if TARGET_OS_IPHONE
			CGSize imageSize = self.size;
#else
			CGSize imageSize = NSSizeToCGSize(self.size);
#endif
			if (imageSize.height < imageSize.width) {
				imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
				imageSize.height = rect.size.height;
			} else {
				imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
				imageSize.width = rect.size.width;
			}
			rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2), rect.origin.y + floor(rect.size.height/2 - imageSize.height/2), imageSize.width, imageSize.height);
		} else if (contentMode == UIViewContentModeScaleAspectFit) {
#if TARGET_OS_IPHONE
			CGSize imageSize = self.size;
#else
			CGSize imageSize = NSSizeToCGSize(self.size);
#endif
			if (imageSize.height < imageSize.width) {
				imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
				imageSize.width = rect.size.width;
			} else {
				imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
				imageSize.height = rect.size.height;
			}
			rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2), rect.origin.y + floor(rect.size.height/2 - imageSize.height/2), imageSize.width, imageSize.height);
		}
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	if (clip) {
		CGContextSaveGState(context);
		CGContextAddRect(context, originalRect);
		CGContextClip(context);
	}
	
#if TARGET_OS_IPHONE
	[self drawInRect:rect];
#else
	[self drawInRect:NSRectFromCGRect(rect) fromRect:NSMakeRect(0, 0, self.size.width, self.size.height) operation:NSCompositeSourceOver fraction:1.0];
#endif
	
	if (clip) {
		CGContextRestoreGState(context);
	}
}


- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius {
	[self drawInRect:rect radius:radius contentMode:UIViewContentModeScaleAspectFill];
}


- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius contentMode:(UIViewContentMode)contentMode {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	if (radius) {
		[self addRoundedRectToPath:context rect:rect radius:radius];
		CGContextClip(context);
	}
	
	[self drawInRect:rect contentMode:contentMode];
	
	CGContextRestoreGState(context);
}

- (CGRect)convertRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode {
	if (self.size.width != rect.size.width || self.size.height != rect.size.height) {
		if (contentMode == UIViewContentModeLeft) {
			return CGRectMake(rect.origin.x,
							  rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeRight) {
			return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
							  rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeTop) {
			return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
							  rect.origin.y,
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeBottom) {
			return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
							  rect.origin.y + floor(rect.size.height - self.size.height),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeCenter) {
			return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
							  rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeBottomLeft) {
			return CGRectMake(rect.origin.x,
							  rect.origin.y + floor(rect.size.height - self.size.height),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeBottomRight) {
			return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
							  rect.origin.y + (rect.size.height - self.size.height),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeTopLeft) {
			return CGRectMake(rect.origin.x,
							  rect.origin.y,
							  
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeTopRight) {
			return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
							  rect.origin.y,
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeScaleAspectFill) {
			CGSize imageSize = self.size;
			if (imageSize.height < imageSize.width) {
				imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
				imageSize.height = rect.size.height;
			} else {
				imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
				imageSize.width = rect.size.width;
			}
			return CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
							  rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
							  imageSize.width, imageSize.height);
		} else if (contentMode == UIViewContentModeScaleAspectFit) {
			CGSize imageSize = self.size;
			if (imageSize.height < imageSize.width) {
				imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
				imageSize.width = rect.size.width;
			} else {
				imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
				imageSize.height = rect.size.height;
			}
			return CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
							  rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
							  imageSize.width, imageSize.height);
		}
	}
	return rect;
}

@end
