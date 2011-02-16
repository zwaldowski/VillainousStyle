//
//  VSStyleController.h
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

#import <VillainousStyle/VillainousStyle.h>
//#import "VSStyleLabel.h"

@interface VSStyleController : NSWindowController {
	IBOutlet VSView *backgroundView;
	
	IBOutlet VSView *styleView1;
	IBOutlet VSView *styleView2;
	IBOutlet VSView *styleView3;
	IBOutlet VSLabel *styleView4;
	
	NSArray *styleSheets;
}

-(void)selectStyleSheetAtIndex:(NSUInteger)index;
-(IBAction)changeStyleSheet:sender;
@end
