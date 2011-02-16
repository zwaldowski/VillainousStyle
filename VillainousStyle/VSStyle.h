//
//  VSStyle.h
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

@class VSStyleContext;

static const NSInteger kDefaultLightSource = 125;

@interface VSStyle : NSObject {
	VSStyle* _next;
}

@property(nonatomic,retain) VSStyle* next;

- (id)initWithNext:(VSStyle *)next;
- (VSStyle *)next:(VSStyle *)next;

- (void)draw:(VSStyleContext*)context;

- (UIEdgeInsets)addToInsets:(UIEdgeInsets)insets forSize:(CGSize)size;
- (CGSize)addToSize:(CGSize)size context:(VSStyleContext *)context;

- (void)addStyle:(VSStyle*)style;

- (id)firstStyleOfClass:(Class)cls;
- (id)styleForPart:(NSString*)name;

- (CGGradientRef)newGradientWithColors:(VSColor**)colors count:(int)count;
- (CGGradientRef)newGradientWithColors:(VSColor**)colors locations:(CGFloat*)locations count:(int)count;

// all child styles with no value in their next
// uses an NSSet in case future styles can have split layouts
- (NSSet *) finalStyles;

@end
