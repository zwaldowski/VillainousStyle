//
//  VSStyleSheet.h
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

extern const NSString *VSStyleSheetChangedNotification;

@class VSStyle;

@interface VSStyleSheet : NSObject {
	NSMutableDictionary* _styles;
}

+ (id) styleSheet;

+ (NSArray *)allStyleSheets;

+ (VSStyleSheet*)globalStyleSheet;
+ (void)setGlobalStyleSheet:(VSStyleSheet*)styleSheet;
- (BOOL)isGlobalStyleSheet;

- (VSStyle*)styleWithSelector:(NSString*)selector;

#if TARGET_OS_IPHONE
- (VSStyle*)styleWithSelector:(NSString*)selector forState:(UIControlState)state;
#endif

@end
