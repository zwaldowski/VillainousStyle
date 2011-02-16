//
//  VSButton.h
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

#import "VSStyleDelegate.h"
#import "VSGlobal.h"

@class VSFont, VSStyle;

@interface VSButton : NSControl <VSStyleDelegate> {
	VSFont*             _font;
	BOOL                _isVertical;
	NSMutableDictionary	*_content;
}

@property (nonatomic, retain) VSFont* font;
@property (nonatomic)         BOOL    isVertical;


+ (VSButton*)buttonWithStyle:(NSString*)selector;
+ (VSButton*)buttonWithStyle:(NSString*)selector title:(NSString*)title;

/*
- (NSString*)titleForState:(UIControlState)state;
- (void)setTitle:(NSString*)title forState:(UIControlState)state;

- (VSStyle*)styleForState:(UIControlState)state;
- (void)setStyle:(VSStyle*)style forState:(UIControlState)state;
*/

/*
 * Sets the styles for all control states using a single style selector.
 *
 * The method for the selector must accept a single argument for the control state.  It will
 * be called to return a style for each of the different control states.
 */

- (void)setStylesWithSelector:(NSString*)selector;

@end