//
//  LightStyleSheet.m
//  VillainousStyle Demo
//
//  Created by Steve Streza on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LightStyleSheet.h"
#import "VSStyles.h"
#import "VSShapes.h"

@implementation LightStyleSheet

#define kBlackColor     VSColorRGBA(0.62, 0.64, 0.67, 1.0)
#define kBlueColor      VSColorRGBA(0.86, 0.89, 0.89, 1.0)
#define kDarkBlueColor  VSColorRGBA(0.74, 0.79, 0.87, 0.5)
#define kDoomIconImage  (VSImage *)([VSImage imageNamed:@"doom-icon"])

-(VSStyle *)backgroundStyle{
	return [VSSolidFillStyle styleWithColor:VSColorRGBA(0.929, 0.929, 0.929, 1.0) next:nil];
}

-(VSStyle *)upperLeftStyle{
	return [VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:10] next:
	    [VSShadowStyle styleWithColor:VSColorRGBA(1, 1, 1, 0.9) blur:1 offset:CGSizeMake(0, 1) next:
	      [VSLinearGradientFillStyle styleWithColor1:VSColorRGBA(1, 1, 1, 1) color2:VSColorRGBA(0.85, 0.86, 0.9, 1.0) next:
	        [VSSolidBorderStyle styleWithColor:VSColorRGBA(0.5, 0.5, 0.5, 0.75) width:1 next:
	          [VSImageStyle styleWithImage:kDoomIconImage defaultImage:nil contentMode:UIViewContentModeScaleToFill size:[kDoomIconImage size] next:
	            nil]]]]];
}

-(VSStyle *)upperRightStyle{
	return [VSInsetStyle styleWithInset:UIEdgeInsetsMake(10, 10, 10, 10) next:
	  [VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:9] next:
	    [VSShadowStyle styleWithColor:VSColorRGB(1, 1, 1) blur:1 offset:CGSizeMake(0, 1) next:
	      [VSReflectiveFillStyle styleWithColor:kDarkBlueColor next:
	        [VSInnerShadowStyle styleWithColor:VSColorRGBA(0, 0, 0, 0.85) blur:12.0 offset:CGSizeZero next:
	          [VSInsetStyle styleWithInset:UIEdgeInsetsMake(0, -1, 0, -1) next:
	            [VSBevelBorderStyle styleWithHighlight:nil shadow:VSColorRGBA(0, 0, 0, 0.15) width:1 lightSource:270 next:
	              nil]]]]]]];
}

-(VSStyle *)lowerLeftStyle{
	return [VSShadowStyle styleWithColor:VSColorRGBA(0, 0, 0, 0.5) blur:5 offset:CGSizeMake(0, 2) next:
	  [VSInsetStyle styleWithInset:UIEdgeInsetsMake(10., 10., 10., 10.) next:
	    [VSShapeStyle styleWithShape:[VSRoundedLeftArrowShape shapeWithRadius:10.0] next:
	      [VSSolidBorderStyle styleWithColor:VSColorRGBA(0.,1.,0.,1.) width:5. next:
	        [VSLinearGradientFillStyle styleWithColor1:VSColorRGBA(0.3, 0.8, 0.5, 1.0) color2:VSColorRGBA(0.4, 1.0, 0.6, 1.0) next:
	          nil]]]]];
}

-(VSStyle *)lowerRightStyle{
	return [VSShadowStyle styleWithColor:VSColorRGBA(0, 0, 0, 0.5) blur:5 offset:CGSizeMake(0, 2) next:
	  [VSInsetStyle styleWithInset:UIEdgeInsetsMake(20, 20, 20, 20) next:
		[VSShapeStyle styleWithShape:[VSRoundedRightArrowShape shapeWithRadius:10] next:
		  [VSSolidBorderStyle styleWithColor:VSColorRGBA(0, 1, 1, 1) width:5 next:
			[VSLinearGradientFillStyle styleWithColor1:VSColorRGBA(0.7, 0.7, 0.8, 1) color2:VSColorRGBA(0.8, 0.8, 0.9, 1) next:
			  [VSTextStyle styleWithFont:[VSFont fontWithName:@"Helvetica Bold" size:14] color:VSColorRGBA(0, 0, 0, 1) next:
			    nil]]]]]];
}

@end
