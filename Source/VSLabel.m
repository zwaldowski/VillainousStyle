//
//  VSLabel.m
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

#import "VSLabel.h"
#import "VSStyles.h"

@implementation VSLabel

@synthesize text = _text;

+ (id)labelWithText:(NSString *)aString {
	return [[[self alloc] initWithText:aString] autorelease];
}

- (id)initWithText:(NSString*)aString {
  if (self = [self init]) {
    self.text = aString;
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _text = nil;
  }
  return self;
}

- (void)dealloc {
	[_text release]; _text = nil;

  [super dealloc];
}

- (NSString*)textForLayerWithStyle:(VSStyle*)style {
  return self.text;
}

- (void)setText:(NSString*)text {
  if (text != _text) {
    [_text release];
    _text = [text copy];
    [self setNeedsDisplay];
  }
}

#if TARGET_OS_IPHONE
#pragma mark UIAccessibility

- (BOOL)isAccessibilityElement {
	return YES;
}

- (NSString *)accessibilityLabel {
	return _text;
}

- (UIAccessibilityTraits)accessibilityTraits {
	return [super accessibilityTraits] | UIAccessibilityTraitStaticText;
}
#endif

@end