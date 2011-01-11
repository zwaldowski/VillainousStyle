//
//  VSStyleController.m
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

#import "VSStyleController.h"
#import "LightStyleSheet.h"
#import "DarkStyleSheet.h"

@implementation VSStyleController

-(id)init{
    if(self = [super init]){
        //STUB initialize your object here
		styleSheets = [[NSArray arrayWithObjects:
						[LightStyleSheet styleSheet],
						[DarkStyleSheet styleSheet],
					   nil] retain];
		
		[self selectStyleSheetAtIndex:0];

	}
	return self;
}

-(void)selectStyleSheetAtIndex:(NSUInteger)index{
	[VSStyleSheet setGlobalStyleSheet:[styleSheets objectAtIndex:index]];	
}

-(IBAction)changeStyleSheet:(id)sender{
	NSUInteger index = [(NSPopUpButton *)sender selectedTag];
	NSLog(@"Selecting stylesheet %lu",index);
	[self selectStyleSheetAtIndex:index];
}

-(void)awakeFromNib{
	styleView4.stringValue = @"Hello world!";
	
	backgroundView.styleName = @"backgroundStyle";
	styleView1.styleName = @"upperLeftStyle";
	styleView2.styleName = @"upperRightStyle";
	styleView3.styleName = @"lowerLeftStyle";
	styleView4.styleName = @"lowerRightStyle";
}

-(void)dealloc{
	//STUB release your objects here
	[styleSheets autorelease];
	
	[super dealloc];
}

@end
