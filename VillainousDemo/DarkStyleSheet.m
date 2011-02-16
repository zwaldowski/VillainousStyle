//
//  DarkStyleSheet.m
//  VillainousStyle Demo
//
//  Created by Steve Streza on 11/6/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DarkStyleSheet.h"
#import "VSStyles.h"
#import "VSShapes.h"

@implementation DarkStyleSheet

#define kBlackColor     VSColorRGBA(0.23, 0.25, 0.28, 1.0)
#define kBlueColor      VSColorRGBA(0.47, 0.50, 0.50, 1.0)
#define kDarkBlueColor  VSColorRGBA(0.35, 0.40, 0.48, 0.5)
#define kDoomIconImage  (VSImage *)([VSImage imageNamed:@"doom-icon"])

-(VSStyle *)backgroundStyle{
	return [VSLinearGradientFillStyle styleWithColor1:VSColorRGBA(0.05, 0.05, 0.05, 1.0) color2:VSColorRGBA(0.35, 0.35, 0.40, 1.0) next:nil];
}

-(VSStyle *)upperLeftStyle{
	return [VSInsetStyle styleWithInset:UIEdgeInsetsMake(10, 10, 10, 10) next:
			[VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:10] next:
			 [VSShadowStyle styleWithColor:VSColorRGBA(1.0, 1.0, 1.0, 0.5) blur:1 offset:CGSizeMake(0, 1) next:
			  [VSLinearGradientFillStyle styleWithColor1:VSColorRGBA(0.5, 0.5, 0.5, 1.0) color2:VSColorRGBA(0.345, 0.36, 0.4, 1.0) next:
			   [VSSolidBorderStyle styleWithColor:VSColorRGBA(0.5, 0.5, 0.5, 0.75) width:1 next:
				[VSImageStyle styleWithImage:kDoomIconImage defaultImage:nil contentMode:UIViewContentModeScaleAspectFit size:[kDoomIconImage size] next:
				 nil]]]]]];
}

-(VSStyle *)upperRightStyle{
	return [VSInsetStyle styleWithInset:UIEdgeInsetsMake(10., 10., 10., 10.) next:
			[VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:9] next:
			 [VSShadowStyle styleWithColor:VSColorRGB(255/256.,255/256.,255/256.) blur:1 offset:CGSizeMake(0, 1) next:
			  [VSReflectiveFillStyle styleWithColor:kDarkBlueColor next:
			   [VSInnerShadowStyle styleWithColor:VSColorRGBA(0., 0., 0., 0.85) blur:12.0 offset:CGSizeZero next:
				[VSInsetStyle styleWithInset:UIEdgeInsetsMake(0, -1, 0, -1) next:
				 [VSBevelBorderStyle styleWithHighlight:nil shadow:VSColorRGBA(0, 0, 0, 0.15) width:1 lightSource:270 next:
				  nil]]]]]]];
}

-(VSStyle *)lowerLeftStyle{
	return [VSShadowStyle styleWithColor:VSColorRGB(0, 0, 0) blur:5 offset:CGSizeMake(0, 2) next:
			[VSInsetStyle styleWithInset:UIEdgeInsetsMake(10, 10, 10, 10) next:
			 [VSShapeStyle styleWithShape:[VSRoundedRightArrowShape shapeWithRadius:10.0] next:
			  [VSSolidBorderStyle styleWithColor:VSColorRGBA(1, 0, 0, 0.5) width:5. next:
			   [VSLinearGradientFillStyle styleWithColor1:VSColorRGBA(0.4, 0.1, 0.2, 1.0) color2:VSColorRGBA(0.6, 0.2, 0.3, 1.0) next:
				nil]]]]];
}

-(VSStyle *)lowerRightStyle{
	return [VSShadowStyle styleWithColor:VSColorRGBA(0, 0, 0, 0.5) blur:5.0 offset:CGSizeMake(0, 2) next:
			[VSInsetStyle styleWithInset:UIEdgeInsetsMake(20, 20, 20, 20) next:
			 [VSShapeStyle styleWithShape:[VSRoundedLeftArrowShape shapeWithRadius:10.0] next:
			  [VSSolidBorderStyle styleWithColor:VSColorRGBA(1, 0, 0, 1) width:5 next:
			   [VSLinearGradientFillStyle styleWithColor1:VSColorRGBA(0.2, 0.2, 0.3, 1.0) color2:VSColorRGBA(0.3, 0.3, 0.4, 1.0) next:
				[VSTextStyle styleWithFont:[VSFont fontWithName:@"Helvetica Bold" size:14] color:VSColorRGBA(1, 1, 1, 1) next:
				 nil]]]]]];
}


@end
