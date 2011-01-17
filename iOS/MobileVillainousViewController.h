//
//  MobileVillainousViewController.h
//  MobileVillainous
//
//  Created by Zachary Waldowski on 1/9/11.
//  Copyright 2011 Dizzy Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VillainousStyle.h"

@interface MobileVillainousViewController : UIViewController {
	IBOutlet VSView *backgroundView;
	IBOutlet VSLabel *toggleLabel;
	IBOutlet VSView *rectStyle;
	IBOutlet VSView *roundRectStyle;
	IBOutlet VSView *gradBorderStyle;
	IBOutlet VSView *roundLeftArrowStyle;
	IBOutlet VSView *partRoundRectStyle;
	IBOutlet VSView *speechRectStyle;
	IBOutlet VSView *speechRectAltStyle;
	IBOutlet VSView *dropShadowStyle;
	IBOutlet VSView *innShadowStyle;
	IBOutlet VSView *chiselStyle;
	IBOutlet VSView *embossStyle;
	IBOutlet VSView *toolbarButtonStyle;
	IBOutlet VSLabel *backButtonStyle;
	IBOutlet VSView *badgeStyle;
	IBOutlet VSView *maskedImageStyle;
}

-(IBAction)toggleStyle:(id)sender;

@end

