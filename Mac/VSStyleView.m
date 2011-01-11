//
//  VSStyleView.m
//  VillainousStyle Mac Demo
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

#import "VSStyleView.h"

@implementation VSStyleView

@synthesize style, styleName;

-(id)initWithFrame:(NSRect)frameRect{
	if(self = [super initWithFrame:frameRect]){
		[self addObservers];
	}
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
	if(self = [super initWithCoder:aDecoder]){
		[self addObservers];
	}
	return self;
}

-(id)init{
	if(self = [super init]){
		[self addObservers];
	}
	return self;
}

-(void)addObservers{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(setNeedsDisplay) 
												 name:@"VSStyleSheetChangedNotification"
											   object:nil];	
}

-(void)removeObservers{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:@"VSStyleSheetChangedNotification"
												  object:nil];
}

-(void)setNeedsDisplay{
//	NSLog(@"Updating style named %@",styleName);
	[self setStyle:VSStyleNamed(styleName)];
	[self setNeedsDisplay:YES];
}

-(void)setStyleName:(NSString *)aStyleName{
	if([styleName isEqualToString:aStyleName]) return;
	
	[styleName autorelease];
	styleName = [aStyleName copy];
	
	[self setNeedsDisplay];
}

-(void)setStyle:(VSStyle *)aStyle{
	[style autorelease];
	style = [aStyle retain];
	
	[self setNeedsDisplay:YES];
}

-(void)drawRect:(NSRect)aRect{
//	NSLog(@"Drawing style in rect - %@", [[VSStyleSheet globalStyleSheet] className]);
	[self drawStyle:[self style] inRect:[self bounds]];
}

-(VSStyle *)style{
	if(styleName){
		return [[VSStyleSheet globalStyleSheet] styleWithSelector:styleName];
	}else{
		return style;
	}
}

-(void)dealloc{
    //STUB release your objects here
	self.style = nil;
	self.styleName = nil;

	[self removeObservers];    
    [super dealloc];
}

@end
