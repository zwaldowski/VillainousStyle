//
//  VSTextStyle.m
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

#import <VillainousStyle/VSTextStyle.h>
#import <VillainousStyle/VSStyleContext.h>

@implementation VSTextStyle

@synthesize font = _font, color = _color, shadowColor = _shadowColor, shadowOffset = _shadowOffset, minimumFontSize = _minimumFontSize, textAlignment = _textAlignment, verticalAlignment = _verticalAlignment, lineBreakMode = _lineBreakMode, numberOfLines = _numberOfLines;

///////////////////////////////////////////////////////////////////////////////////////////////////
// class public

+ (VSTextStyle *)styleWithFont:(VSFont*)aFont next:(VSStyle*)nextStyle {
	VSTextStyle* style = [[[self alloc] initWithNext:nextStyle] autorelease];
	style.font = aFont;
	return style;
}

+ (VSTextStyle *)styleWithColor:(VSColor*)aColor next:(VSStyle*)nextStyle {
	VSTextStyle* style = [[[self alloc] initWithNext:nextStyle] autorelease];
	style.color = aColor;
	return style;
}

+ (VSTextStyle *)styleWithFont:(VSFont*)aFont color:(VSColor*)aColor next:(VSStyle*)nextStyle {
	VSTextStyle* style = [[[self alloc] initWithNext:nextStyle] autorelease];
	style.font = aFont;
	style.color = aColor;
	return style;
}

+ (VSTextStyle *)styleWithFont:(VSFont*)aFont color:(VSColor*)aColor textAlignment:(UITextAlignment)aTextAlignment next:(VSStyle*)nextStyle {
	VSTextStyle* style = [[[self alloc] initWithNext:nextStyle] autorelease];
	style.font = aFont;
	style.color = aColor;
	style.textAlignment = aTextAlignment;
	return style;
}

+ (VSTextStyle*)styleWithFont:(VSFont*)aFont color:(VSColor*)aColor shadowColor:(VSColor*)aShadowColor shadowOffset:(CGSize)aShadowOffset next:(VSStyle*)nextStyle {
	VSTextStyle* style = [[[self alloc] initWithNext:nextStyle] autorelease];
	style.font = aFont;
	style.color = aColor;
	style.shadowColor = aShadowColor;
	style.shadowOffset = aShadowOffset;
	return style;
}

+ (VSTextStyle*)styleWithFont:(VSFont*)aFont color:(VSColor*)aColor minimumFontSize:(CGFloat)aMinimumFontSize shadowColor:(VSColor*)aShadowColor shadowOffset:(CGSize)aShadowOffset next:(VSStyle*)nextStyle {
	VSTextStyle* style = [[[self alloc] initWithNext:nextStyle] autorelease];
	style.font = aFont;
	style.color = aColor;
	style.minimumFontSize = aMinimumFontSize;
	style.shadowColor = aShadowColor;
	style.shadowOffset = aShadowOffset;
	return style;
}

+ (VSTextStyle*)styleWithFont:(VSFont*)aFont color:(VSColor*)aColor minimumFontSize:(CGFloat)aMinimumFontSize shadowColor:(VSColor*)aShadowColor shadowOffset:(CGSize)aShadowOffset textAlignment:(UITextAlignment)aTextAlignment verticalAlignment:(UIControlContentVerticalAlignment)aVerticalAlignment lineBreakMode:(UILineBreakMode)aLineBreakMode numberOfLines:(NSInteger)aNumberOfLines next:(VSStyle*)nextStyle {
	VSTextStyle* style = [[[self alloc] initWithNext:nextStyle] autorelease];
	style.font = aFont;
	style.color = aColor;
	style.minimumFontSize = aMinimumFontSize;
	style.shadowColor = aShadowColor;
	style.shadowOffset = aShadowOffset;
	style.textAlignment = aTextAlignment;
	style.verticalAlignment = aVerticalAlignment;
	style.lineBreakMode = aLineBreakMode;
	style.numberOfLines = aNumberOfLines;
	return style;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNext:(VSStyle*)next {  
	if ((self = [super initWithNext:next])) {
		_font = nil;
		_color = nil;
		_shadowColor = nil;
		_shadowOffset = CGSizeZero;
#if TARGET_OS_MAC
		_minimumFontSize = 0;
#endif
		_numberOfLines = 1;
		_textAlignment = UITextAlignmentCenter;
		_verticalAlignment = UIControlContentVerticalAlignmentCenter;
		_lineBreakMode = UILineBreakModeTailTruncation;
	}
	return self;
}

- (void)dealloc {
	VS_RELEASE_SAFELY(_font);
	VS_RELEASE_SAFELY(_color);
	VS_RELEASE_SAFELY(_shadowColor);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

#if !TARGET_OS_IPHONE
-(NSDictionary *)textAttributes{
	NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	switch (_textAlignment) {
		case UITextAlignmentLeft: [style setAlignment:NSLeftTextAlignment]; break;
		case UITextAlignmentRight: [style setAlignment:NSRightTextAlignment]; break;
		case UITextAlignmentCenter: [style setAlignment:NSCenterTextAlignment]; break;
		default: [style setAlignment:NSNaturalTextAlignment]; break;		
	}
	switch (_lineBreakMode) {
		default:
		case UILineBreakModeWordWrap: [style setLineBreakMode:NSLineBreakByWordWrapping]; break;
		case UILineBreakModeCharacterWrap: [style setLineBreakMode:NSLineBreakByCharWrapping]; break;
		case UILineBreakModeClip: [style setLineBreakMode:NSLineBreakByClipping]; break;
		case UILineBreakModeHeadTruncation: [style setLineBreakMode:NSLineBreakByTruncatingHead]; break;
		case UILineBreakModeTailTruncation: [style setLineBreakMode:NSLineBreakByTruncatingTail]; break;
		case UILineBreakModeMiddleTruncation: [style setLineBreakMode:NSLineBreakByTruncatingMiddle]; break;
	}
	NSShadow *shadow = [[NSShadow alloc] init];
	[shadow setShadowColor:_shadowColor];
	[shadow setShadowOffset:_shadowOffset];
	return [NSDictionary dictionaryWithObjectsAndKeys:
							_font, NSFontAttributeName,
							_color, NSForegroundColorAttributeName,
							[style autorelease], NSParagraphStyleAttributeName,
							[shadow autorelease], NSShadowAttributeName,
							nil];
}
#endif

- (CGSize)sizeOfText:(NSString*)text withFont:(VSFont*)aFont size:(CGSize)size {
#if TARGET_OS_IPHONE
	if (_numberOfLines == 1) {
		return [text sizeWithFont:aFont];
	} else {
		CGSize maxSize = CGSizeMake(size.width, CGFLOAT_MAX);
		CGSize textSize = [text sizeWithFont:aFont constrainedToSize:maxSize lineBreakMode:_lineBreakMode];
		if (_numberOfLines) {
			CGFloat lineHeight = (aFont.ascender - aFont.descender) + 1;
			CGFloat maxHeight = lineHeight * _numberOfLines;
			if (textSize.height > maxHeight) {
				textSize.height = maxHeight;
			}
		}
		return textSize;
	}
#else
	if (_numberOfLines == 1) {
		return NSSizeToCGSize([text sizeWithAttributes:[self textAttributes]]);
	} else {
		CGSize textSize = NSRectToCGRect([text boundingRectWithSize:size options:(NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingOneShot) attributes:[self textAttributes]]).size;
		if (_numberOfLines) {
			CGFloat lineHeight = (aFont.ascender - aFont.descender) + 1;
			CGFloat maxHeight = lineHeight * _numberOfLines;
			if (textSize.height > maxHeight) {
				textSize.height = maxHeight;
			}
		}
		return textSize;
	}
#endif
}

- (CGRect)rectForText:(NSString*)text forSize:(CGSize)size withFont:(VSFont*)font {
	CGRect rect = CGRectZero;
	if (_textAlignment == UITextAlignmentLeft && _verticalAlignment == UIControlContentVerticalAlignmentTop) {
		rect.size = size;
	} else {
		CGSize textSize = [self sizeOfText:text withFont:font size:size];
		
		if (size.width < textSize.width) {
			size.width = textSize.width;
		}
		
		rect.size = textSize;
		
		if (_textAlignment == UITextAlignmentCenter) {
			rect.origin.x = round(size.width/2 - textSize.width/2);
		} else if (_textAlignment == UITextAlignmentRight) {
			rect.origin.x = size.width - textSize.width;
		}
		
		if (_verticalAlignment == UIControlContentVerticalAlignmentCenter) {
			rect.origin.y = round(size.height/2 - textSize.height/2);
		} else if (_verticalAlignment == UIControlContentVerticalAlignmentBottom) {
			rect.origin.y = size.height - textSize.height;
		}
	}
	return rect;
}

- (void)drawText:(NSString*)text context:(VSStyleContext*)context {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ctx);
	
	VSFont* font = _font ? _font : context.font;
	
	if (!font) {
		font = [VSFont systemFontOfSize:[VSFont systemFontSize]];
	}
	
	if (_shadowColor) {
		CGSize offset = CGSizeMake(_shadowOffset.width, -_shadowOffset.height);
		CGContextSetShadowWithColor(ctx, offset, 0, _shadowColor.CGColor);
	}
	
	if (_color) {
		[_color setFill];
	}
	
	CGRect rect = context.contentFrame;
	CGRect titleRect = [self rectForText:text forSize:rect.size withFont:font];
	
#if TARGET_OS_IPHONE
	if (_numberOfLines == 1) {
		titleRect.size = [text drawAtPoint:
						  CGPointMake(titleRect.origin.x+rect.origin.x, titleRect.origin.y+rect.origin.y)
								  forWidth:rect.size.width withFont:font
							   minFontSize:_minimumFontSize ? _minimumFontSize : font.pointSize
							actualFontSize:nil lineBreakMode:_lineBreakMode
						baselineAdjustment:UIBaselineAdjustmentAlignCenters];
	} else {
		titleRect = CGRectOffset(titleRect, rect.origin.x, rect.origin.y);
		rect.size = [text drawInRect:titleRect withFont:font lineBreakMode:_lineBreakMode alignment:_textAlignment];
	}	
#else
	if (_numberOfLines == 1) {
		[text drawAtPoint:CGPointMake(titleRect.origin.x+rect.origin.x, titleRect.origin.y+rect.origin.y) withAttributes:[self textAttributes]];
	} else {
		[text drawInRect:NSRectFromCGRect(titleRect) withAttributes:[self textAttributes]];			
	}
#endif
	
	context.contentFrame = titleRect;
	
	CGContextRestoreGState(ctx);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// VSStyle

- (void)draw:(VSStyleContext*)context {
	if ([context.delegate respondsToSelector:@selector(textForLayerWithStyle:)]) {
		NSString* text = [context.delegate textForLayerWithStyle:self];
		if (text) {
			context.didDrawContent = YES;
			[self drawText:text context:context];
		}
	}
	
	if (!context.didDrawContent && [context.delegate respondsToSelector:@selector(drawLayer:withStyle:)]) {
		[context.delegate drawLayer:context withStyle:self];
		context.didDrawContent = YES;
	}
	
	[self.next draw:context];
}

- (CGSize)addToSize:(CGSize)size context:(VSStyleContext*)context {
	if ([context.delegate respondsToSelector:@selector(textForLayerWithStyle:)]) {
		NSString* text = [context.delegate textForLayerWithStyle:self];
		VSFont* font = _font ? _font : context.font;
		
		CGFloat maxWidth = context.contentFrame.size.width;
		if (!maxWidth) {
			maxWidth = CGFLOAT_MAX;
		}
		CGFloat lineHeight = (font.ascender - font.descender) + 1;
		CGFloat maxHeight = _numberOfLines ? _numberOfLines * lineHeight : CGFLOAT_MAX;
		CGSize maxSize = CGSizeMake(maxWidth, maxHeight);
		
		CGSize textSize = [self sizeOfText:text withFont:font size:maxSize];
		
		size.width += textSize.width;
		size.height += textSize.height;
	}
	
	if (_next) {
		return [self.next addToSize:size context:context];
	} else {
		return size;
	}
}

@end
