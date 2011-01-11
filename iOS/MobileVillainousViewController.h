//
//  MobileVillainousViewController.h
//  MobileVillainous
//
//  Created by Zachary Waldowski on 1/9/11.
//  Copyright 2011 Dizzy Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSStyleView.h"

@interface MobileVillainousViewController : UIViewController {
	IBOutlet VSStyleView *backgroundView;
	IBOutlet VSStyleView *topLeftView;
	IBOutlet VSStyleView *topRightView;
	IBOutlet VSStyleView *bottomLeftView;
	IBOutlet VSStyleView *bottomRightView;
}

@end

