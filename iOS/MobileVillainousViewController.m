//
//  MobileVillainousViewController.m
//  MobileVillainous
//
//  Created by Zachary Waldowski on 1/9/11.
//  Copyright 2011 Dizzy Technology. All rights reserved.
//

#import "MobileVillainousViewController.h"
#import "iDarkStyleSheet.h"
#import "iLightStyleSheet.h"

@implementation MobileVillainousViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	backgroundView.styleName = @"backgroundStyle";
	toggleLabel.styleName = @"toggleLabelStyle";
	toggleLabel.text = @"Toggle Stylesheet";

	rectStyle.styleName = @"rectStyle";
	roundRectStyle.styleName = @"roundRectStyle";
	gradBorderStyle.styleName = @"gradBorderStyle";
	roundLeftArrowStyle.styleName = @"roundLeftArrowStyle";
	partRoundRectStyle.styleName = @"partRoundRectStyle";
	speechRectStyle.styleName = @"speechRectStyle";
	speechRectAltStyle.styleName = @"speechRectAltStyle";
	dropShadowStyle.styleName = @"dropShadowStyle";
	innShadowStyle.styleName = @"innShadowStyle";
	chiselStyle.styleName = @"chiselStyle";
	embossStyle.styleName = @"embossStyle";
	toolbarButtonStyle.styleName = @"toolbarButtonStyle";
	backButtonStyle.styleName = @"backButtonStyle";
	backButtonStyle.text = @"Navigation";
	badgeStyle.styleName = @"badgeStyle";
	maskedImageStyle.styleName = @"maskedImageStyle";
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)toggleStyle:(id)sender {
	//NSLog(@"sender:  %@", sender);
	if ([(UISwitch *)sender isOn]) {
		[VSStyleSheet setGlobalStyleSheet:[iLightStyleSheet styleSheet]];
	} else {
		[VSStyleSheet setGlobalStyleSheet:[iDarkStyleSheet styleSheet]];
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
