//
//  VSView.m
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
#import "VSViewiOS.h"
#else
#import "VSViewMac.h"
#endif
#import "VSStyles.h"
#import "NSView+VSStyle.h"

@interface VSView(VSPrivate)
- (void)addObservers;
- (void)removeObservers;
- (void)setNeedsStyleReload;
@end

@implementation VSView

@synthesize style = _style, styleName = _styleName;

-(id)initWithFrame:(CGRect)frameRect{
	if(self = [super initWithFrame:frameRect]){
#if TARGET_OS_IPHONE
		self.contentMode = UIViewContentModeRedraw;
		self.opaque = NO;
#endif
		[self addObservers];
	}
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
	if(self = [super initWithCoder:aDecoder]){
#if TARGET_OS_IPHONE
		self.contentMode = UIViewContentModeRedraw;
		self.opaque = NO;
		// no bg color for items made in IB
		self.backgroundColor = [VSColor clearColor];
#endif
		[self addObservers];
	}
	return self;
}

-(id)init{
	if(self = [super init]){
#if TARGET_OS_IPHONE
		self.contentMode = UIViewContentModeRedraw;
		self.opaque = NO;
#endif
		[self addObservers];
	}
	return self;
}

- (void)dealloc {
	[_style release]; _style = nil;
	[_styleName release]; _styleName = nil;
	[self removeObservers];
	[super dealloc];
}

-(void)drawRect:(CGRect)aRect{
	[self drawStyle:[self style]];
}

-(void)setStyleName:(NSString *)aStyleName{
	if([_styleName isEqualToString:aStyleName]) return;
	
	[_styleName autorelease];
	_styleName = [aStyleName copy];
	
	[self setNeedsStyleReload];
}


-(VSStyle *)style{
	if(_styleName){
		return [[VSStyleSheet globalStyleSheet] styleWithSelector:_styleName];
	}else{
		return _style;
	}
}

- (void)setStyle:(VSStyle*)style {
	if (style != _style) {
		[_style release];
		_style = [style retain];
		
		[self setNeedsDisplay];
	}
}

- (void)drawContent:(CGRect)rect {
	
}

-(void)setNeedsStyleReload{
	if(_styleName){
		VSStyle *newStyle = VSStyleNamed(styleName);
		//	NSLog(@"Updating style named %@",styleName);
		if(newStyle){
			[self setStyle:newStyle];
			[self setNeedsDisplay];
		}
	}
}

#if TARGET_OS_MAC
-(void)setFrame:(CGRect)newFrame{
	[super setFrame:newFrame];
	[self setNeedsDisplay];
}
#endif

-(void)addObservers {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedsDisplay) name:@"VSStyleSheetChangedNotification" object:nil];	
}

- (void)removeObservers {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"VSStyleSheetChangedNotification" object:nil];	
}

@end