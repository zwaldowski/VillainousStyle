//
//  VSTextStyle.h
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

#import <VillainousStyle/VSStyle.h>

#if !TARGET_OS_IPHONE
typedef enum {		
    UILineBreakModeWordWrap = 0,            // Wrap at word boundaries
    UILineBreakModeCharacterWrap,           // Wrap at character boundaries
    UILineBreakModeClip,                    // Simply clip when it hits the end of the rect
    UILineBreakModeHeadTruncation,          // Truncate at head of line: "...wxyz". Will truncate multiline text on first line
    UILineBreakModeTailTruncation,          // Truncate at tail of line: "abcd...". Will truncate multiline text on last line
    UILineBreakModeMiddleTruncation,        // Truncate middle of line:  "ab...yz". Will truncate multiline text in the middle
} UILineBreakMode;

typedef enum {
    UITextAlignmentLeft = 0,
    UITextAlignmentCenter,
    UITextAlignmentRight,                   // could add justified in future
} UITextAlignment;

typedef enum {
    UIBaselineAdjustmentAlignBaselines = 0, // default. used when shrinking text to position based on the original baseline
    UIBaselineAdjustmentAlignCenters,
    UIBaselineAdjustmentNone,
} UIBaselineAdjustment;

typedef enum {
    UIControlContentVerticalAlignmentCenter  = 0,
    UIControlContentVerticalAlignmentTop     = 1,
    UIControlContentVerticalAlignmentBottom  = 2,
    UIControlContentVerticalAlignmentFill    = 3,
} UIControlContentVerticalAlignment;
#endif

@interface VSTextStyle : VSStyle {
	VSFont* _font;
	VSColor* _color;
	VSColor* _shadowColor;
	CGSize _shadowOffset;
	CGFloat _minimumFontSize;
	NSInteger _numberOfLines;
	UITextAlignment _textAlignment;
	UIControlContentVerticalAlignment _verticalAlignment;
	UILineBreakMode _lineBreakMode;
}

@property(nonatomic,retain) VSFont* font;
@property(nonatomic,retain) VSColor* color;
@property(nonatomic,retain) VSColor* shadowColor;
@property(nonatomic) CGFloat minimumFontSize;
@property(nonatomic) NSInteger numberOfLines;
@property(nonatomic) CGSize shadowOffset;
@property(nonatomic) UITextAlignment textAlignment;
@property(nonatomic) UIControlContentVerticalAlignment verticalAlignment;
@property(nonatomic) UILineBreakMode lineBreakMode;

+ (VSTextStyle*)styleWithFont:(VSFont*)aFont next:(VSStyle*)nextStyle;
+ (VSTextStyle*)styleWithColor:(VSColor*)aColor next:(VSStyle*)nextStyle;
+ (VSTextStyle*)styleWithFont:(VSFont*)aFont color:(VSColor*)aColor next:(VSStyle*)nextStyle;
+ (VSTextStyle*)styleWithFont:(VSFont*)aFont color:(VSColor*)aColor
                textAlignment:(UITextAlignment)aTextAlignment next:(VSStyle*)nextStyle;
+ (VSTextStyle*)styleWithFont:(VSFont*)aFont color:(VSColor*)aColor
				  shadowColor:(VSColor*)aShadowColor shadowOffset:(CGSize)aShadowOffset
						 next:(VSStyle*)nextStyle;
+ (VSTextStyle*)styleWithFont:(VSFont*)aFont color:(VSColor*)aColor
			  minimumFontSize:(CGFloat)aMinimumFontSize
				  shadowColor:(VSColor*)aShadowColor shadowOffset:(CGSize)aShadowOffset
						 next:(VSStyle*)nextStyle;
+ (VSTextStyle*)styleWithFont:(VSFont*)aFont color:(VSColor*)aColor
              minimumFontSize:(CGFloat)aMinimumFontSize
                  shadowColor:(VSColor*)aShadowColor shadowOffset:(CGSize)aShadowOffset
                textAlignment:(UITextAlignment)aTextAlignment
            verticalAlignment:(UIControlContentVerticalAlignment)aVerticalAlignment
                lineBreakMode:(UILineBreakMode)aLineBreakMode numberOfLines:(NSInteger)aNumberOfLines
                         next:(VSStyle*)nextStyle;

@end
