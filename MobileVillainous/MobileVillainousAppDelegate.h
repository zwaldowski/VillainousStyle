//
//  MobileVillainousAppDelegate.h
//  MobileVillainous
//
//  Created by Zachary Waldowski on 2/15/11.
//  Copyright 2011 Dizzy Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MobileVillainousViewController;

@interface MobileVillainousAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MobileVillainousViewController *viewController;

@end
