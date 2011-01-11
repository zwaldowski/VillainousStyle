//
//  VSStyleSheet.m
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

#import "VSStyleSheet.h"
#import <objc/runtime.h>

@interface VSStyleSheet (Private)
+ (NSArray*)_subclassesOfClass:(Class)superclass fromCArray:(Class[])classes withCount:(int)count;
@end

///////////////////////////////////////////////////////////////////////////////////////////////////
// global

static NSArray *gAllStyleSheets;
static VSStyleSheet* gStyleSheet = nil;
const NSString *VSStyleSheetChangedNotification = @"VSStyleSheetChangedNotification";

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation VSStyleSheet

///////////////////////////////////////////////////////////////////////////////////////////////////
// class public

+(NSArray *)allStyleSheets{
	if(!gAllStyleSheets){
		int count = objc_getClassList(NULL, 0);
		
		Class classes[count];
		objc_getClassList(classes, count);
		
		NSArray *styleSheetClasses = [self _subclassesOfClass:self fromCArray:classes withCount:count];
		
		NSMutableArray *allSheets = [NSMutableArray arrayWithCapacity:[styleSheetClasses count]];
		for(Class sheetClass in styleSheetClasses){
			[allSheets addObject:[sheetClass styleSheet]];
		}
		
		gAllStyleSheets = [allSheets copy];
	}
	return [[gAllStyleSheets copy] autorelease];
}


+ (VSStyleSheet*)globalStyleSheet {
/*
 TODO Implement a default style sheet for Aqua
 Perhaps make alternatives for other common UI styles
 
	if (!gStyleSheet) {
		gStyleSheet = [[VSDefaultStyleSheet alloc] init];
	}
 */
	if (!gStyleSheet){
		gStyleSheet = [[[self allStyleSheets] lastObject] retain];
	}
	
	return gStyleSheet;
}

+ (void)setGlobalStyleSheet:(VSStyleSheet*)styleSheet {
	[gStyleSheet autorelease];
	gStyleSheet = [styleSheet retain];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)VSStyleSheetChangedNotification object:(id)gStyleSheet];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
	if (self = [super init]) {
		_styles = nil;
#if TARGET_OS_IPHONE
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
#endif
	}
	return self;
}

- (void)dealloc {
#if TARGET_OS_IPHONE
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
#endif
	[_styles release]; _styles = nil;
	
	[super dealloc];
}

+ (id) styleSheet{
	return [[[self alloc] init] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (BOOL)isGlobalStyleSheet{
	return [[[self class] globalStyleSheet] class] == [self class];
}

#if TARGET_OS_IPHONE
- (VSStyle*)styleWithSelector:(NSString*)selector {
	return [self styleWithSelector:selector forState:UIControlStateNormal];
}

- (VSStyle*)styleWithSelector:(NSString*)selector forState:(UIControlState)state {
	NSString* key = (state == UIControlStateNormal) ? selector : [NSString stringWithFormat:@"%@%d", selector, state];
	VSStyle* style = [_styles objectForKey:key];
	if (!style) {
		SEL sel = NSSelectorFromString(selector);
		if ([self respondsToSelector:sel]) {
			style = [self performSelector:sel withObject:(id)state];
			if (style) {
				if (!_styles) {
					_styles = [[NSMutableDictionary alloc] init];
				}
				[_styles setObject:style forKey:key];
			}
		}
	}
	return style;
}

#else

- (VSStyle*)styleWithSelector:(NSString*)selector {
	if(!selector) return nil;
	
	VSStyle* style = [_styles objectForKey:selector];
	if (!style) {
		SEL sel = NSSelectorFromString(selector);
		if ([self respondsToSelector:sel]) {
			style = [self performSelector:sel withObject:nil];
			if (style) {
				if (!_styles) {
					_styles = [[NSMutableDictionary alloc] init];
				}
				[_styles setObject:style forKey:selector];
			}
		}
	}
	return style;
}
#endif

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

+ (NSArray*)_subclassesOfClass:(Class)superclass fromCArray:(Class[])classes withCount:(int)count {
	NSMutableArray *array = [NSMutableArray array];
	
	for (int i = 0; i < count; i++) {
		Class subclass = classes[i];
		if (class_getSuperclass(subclass) == superclass
			&& [NSStringFromClass(subclass) hasPrefix:@"NSKVONotifying"] == NO
			/* avoid the autogenerated KVO classes if they ever come up in the future */)
		{
			[array addObject:subclass];
			[array addObjectsFromArray:[self _subclassesOfClass:subclass fromCArray:classes withCount:count]];
		}
	}
	
	return array;
}

#if TARGET_OS_IPHONE
- (void)didReceiveMemoryWarning:(void*)object {
	[_styles release]; _styles = nil;
}
#endif

@end
