//
//  VSButton.m
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

 
#if TARGET_OS_IPHONE
#import "VSButton_iOS.h"
#else
#import "VSButton_Mac.h"
#endif

#import "VSStyles.h"

@implementation VSButton

@synthesize font        = _font;
@synthesize isVertical  = _isVertical;

- (void)dealloc {
	[_font release]; _font = nil;
	[super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor clearColor];
		self.contentMode = UIViewContentModeRedraw;
	}
	return self;
}

+ (VSButton*)buttonWithStyle:(NSString*)selector {
	VSButton* button = [[[self alloc] init] autorelease];
	[button setStylesWithSelector:selector];
	return button;
}

+ (VSButton*)buttonWithStyle:(NSString*)selector title:(NSString*)title {
	VSButton* button = [[[self alloc] init] autorelease];
	[button setTitle:title forState:UIControlStateNormal];
	[button setStylesWithSelector:selector];
	return button;
}

- (id)keyForState:(UIControlState)state {
	static NSString* normalKey = @"normal";
	static NSString* highlighted = @"highlighted";
	static NSString* selected = @"selected";
	static NSString* disabled = @"disabled";
	if (state & UIControlStateHighlighted) {
		return highlighted;
	} else if (state & UIControlStateSelected) {
		return selected;
	} else if (state & UIControlStateDisabled) {
		return disabled;
	} else {
		return normalKey;
	}
}



- (NSString*)titleForState:(UIControlState)state {
	return nil;	
}

- (void)setTitle:(NSString*)title forState:(UIControlState)state {
	return;	
}

- (NSString*)imageForState:(UIControlState)state {
	return nil;	
}

- (void)setImage:(NSString*)title forState:(UIControlState)state {
	return;	
}

- (VSStyle*)styleForState:(UIControlState)state {
	return nil;	
}

- (void)setStyle:(VSStyle*)style forState:(UIControlState)state {
	return;	
}



- (VSFont*)font {
	if (!_font) {
		_font = [[VSFont boldSystemFontOfSize:12] retain];
	}
	return _font;
}

- (void)setFont:(VSFont*)font {
	if (![font isEqual:_font]) {
		[_font release];
		_font = [font retain];
		[self setNeedsDisplay];
	}
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	[self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled {
	[super setEnabled:enabled];
	[self setNeedsDisplay];
}

- (BOOL)isAccessibilityElement {
	return YES;
}

- (NSString *)accessibilityLabel {
	//return [self titleForCurrentState];
	return nil;
}

- (UIAccessibilityTraits)accessibilityTraits {
	return [super accessibilityTraits] | UIAccessibilityTraitButton;
}

- (NSString*)textForLayerWithStyle:(VSStyle*)style {
	//return [self titleForCurrentState];
	return @"";
}

- (void)setStylesWithSelector:(NSString*)selector {
	
}

@end


/*



///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForCurrentState {
  TTButtonContent* content = [self contentForCurrentState];
  return content.title ? content.title : [self contentForState:UIControlStateNormal].title;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (VSStyle*)styleForCurrentState {
  TTButtonContent* content = [self contentForCurrentState];
  return content.style ? content.style : [self contentForState:UIControlStateNormal].style;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (VSFont*)fontForCurrentState {
  if (_font) {
    return _font;
  } else {
    TTStyle* style = [self styleForCurrentState];
    TTTextStyle* textStyle = (VSTextStyle*)[style firstStyleOfClass:[VSTextStyle class]];
    if (textStyle.font) {
      return textStyle.font;
    } else {
      return self.font;
    }
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect {
  TTStyle* style = [self styleForCurrentState];
  if (style) {
    CGRect textFrame = self.bounds;

    TTStyleContext* context = [[[TTStyleContext alloc] init] autorelease];
    context.delegate = self;

    TTPartStyle* imageStyle = [style styleForPart:@"image"];
    TTBoxStyle* imageBoxStyle = nil;
    CGSize imageSize = CGSizeZero;
    if (imageStyle) {
      imageBoxStyle = [imageStyle.style firstStyleOfClass:[TTBoxStyle class]];
      imageSize = [imageStyle.style addToSize:CGSizeZero context:context];
      if (_isVertical) {
        CGFloat height = imageSize.height + imageBoxStyle.margin.top + imageBoxStyle.margin.bottom;
        textFrame.origin.y += height;
        textFrame.size.height -= height;
      } else {
        textFrame.origin.x += imageSize.width + imageBoxStyle.margin.right;
        textFrame.size.width -= imageSize.width + imageBoxStyle.margin.right;
      }
    }

    context.delegate = self;
    context.frame = self.bounds;
    context.contentFrame = textFrame;
    context.font = [self fontForCurrentState];

    [style draw:context];

    if (imageStyle) {
      CGRect frame = context.contentFrame;
      if (_isVertical) {
        frame = self.bounds;
        frame.origin.x += imageBoxStyle.margin.left;
        frame.origin.y += imageBoxStyle.margin.top;
      } else {
        frame.size = imageSize;
        frame.origin.x += imageBoxStyle.margin.left;
        frame.origin.y += imageBoxStyle.margin.top;
      }

      context.frame = frame;
      context.contentFrame = context.frame;
      context.shape = nil;

      [imageStyle drawPart:context];
    }
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)sizeThatFits:(CGSize)size {
  TTStyleContext* context = [[[TTStyleContext alloc] init] autorelease];
  context.delegate = self;
  context.font = [self fontForCurrentState];

  TTStyle* style = [self styleForCurrentState];
  if (style) {
    return [style addToSize:CGSizeZero context:context];
  } else {
    return size;
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIControl


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  [self setNeedsDisplay];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];
  [self setNeedsDisplay];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  [self setNeedsDisplay];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIAccessibility


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isAccessibilityElement {
  return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)accessibilityLabel {
  return [self titleForCurrentState];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIAccessibilityTraits)accessibilityTraits {
  return [super accessibilityTraits] | UIAccessibilityTraitButton;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTStyleDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)textForLayerWithStyle:(TTStyle*)style {
  return [self titleForCurrentState];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIFont*)font {
  if (!_font) {
    _font = [TTSTYLEVAR(buttonFont) retain];
  }
  return _font;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setFont:(UIFont*)font {
  if (font != _font) {
    [_font release];
    _font = [font retain];
    [self setNeedsDisplay];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForState:(UIControlState)state {
  return [self contentForState:state].title;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTitle:(NSString*)title forState:(UIControlState)state {
  TTButtonContent* content = [self contentForState:state];
  content.title = title;
  [self setNeedsDisplay];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)imageForState:(UIControlState)state {
  return [self contentForState:state].imageURL;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setImage:(NSString*)imageURL forState:(UIControlState)state {
  TTButtonContent* content = [self contentForState:state];
  content.delegate = self.imageDelegate;
  content.imageURL = imageURL;
  [self setNeedsDisplay];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)styleForState:(UIControlState)state {
  return [self contentForState:state].style;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setStyle:(TTStyle*)style forState:(UIControlState)state {
  TTButtonContent* content = [self contentForState:state];
  content.style = style;
  [self setNeedsDisplay];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setStylesWithSelector:(NSString*)selector {
  TTStyleSheet* ss = [TTStyleSheet globalStyleSheet];

  TTStyle* normalStyle = [ss styleWithSelector:selector forState:UIControlStateNormal];
  [self setStyle:normalStyle forState:UIControlStateNormal];

  TTStyle* highlightedStyle = [ss styleWithSelector:selector forState:UIControlStateHighlighted];
  [self setStyle:highlightedStyle forState:UIControlStateHighlighted];

  TTStyle* selectedStyle = [ss styleWithSelector:selector forState:UIControlStateSelected];
  [self setStyle:selectedStyle forState:UIControlStateSelected];

  TTStyle* disabledStyle = [ss styleWithSelector:selector forState:UIControlStateDisabled];
  [self setStyle:disabledStyle forState:UIControlStateDisabled];
}


@end
*/