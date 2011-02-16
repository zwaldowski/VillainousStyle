//
//  MobileVillainousViewController.m
//  MobileVillainous
//
//  Created by Zachary Waldowski on 2/15/11.
//  Copyright 2011 Dizzy Technology. All rights reserved.
//

#import "MobileVillainousViewController.h"
#import "iDarkStyleSheet.h"
#import "iLightStyleSheet.h"

@implementation MobileVillainousViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
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
	//maskedImageStyle.styleName = @"maskedImageStyle";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)toggleStyle:(UISwitch *)sender {
	if ([sender isOn]) {
		[VSStyleSheet setGlobalStyleSheet:[iLightStyleSheet styleSheet]];
	} else {
		[VSStyleSheet setGlobalStyleSheet:[iDarkStyleSheet styleSheet]];
	}
}

@end
