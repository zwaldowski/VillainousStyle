//
//  iLightStyleSheet.m
//  MobileVillainous
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

#import "iLightStyleSheet.h"
#import "VillainousStyle.h"

@implementation iLightStyleSheet

#define kBlackColor    VSColorRGB(0.62, 0.64, 0.67)
#define kBlueColor     VSColorRGB(0.75, 0.77, 0.82)
#define kDarkBlueColor VSColorRGB(0.43, 0.52, 0.64)

-(VSStyle *)backgroundStyle {
	return [VSSolidFillStyle styleWithColor:VSColorRGB(0.85, 0.87, 0.91) next:nil];
}

-(VSStyle *)toggleLabelStyle {
	return 	[VSTextStyle styleWithFont:[VSFont boldSystemFontOfSize:18] color:VSColorRGBA(0, 0, 0, 1) next:nil];
}

-(VSStyle *)rectStyle {
	return [VSSolidFillStyle styleWithColor:[VSColor whiteColor] next:[VSSolidBorderStyle styleWithColor:kBlackColor width:1 next:nil]];
}

-(VSStyle *)roundRectStyle {
	return [VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:10] next:
			[VSSolidFillStyle styleWithColor:[VSColor whiteColor] next:
			 [VSSolidBorderStyle styleWithColor:kBlackColor width:1 next:nil]]];
}


-(VSStyle *)gradBorderStyle {
	return [VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:10] next:
			[VSSolidFillStyle styleWithColor:[VSColor whiteColor] next:
			 [VSLinearGradientBorderStyle styleWithColor1:[VSColor blackColor]
												   color2:VSColorRGB(0.85, 0.87, 0.91) width:2 next:nil]]];
}


-(VSStyle *)roundLeftArrowStyle {
	return [VSShapeStyle styleWithShape:[VSRoundedLeftArrowShape shapeWithRadius:5] next:
			[VSSolidFillStyle styleWithColor:[VSColor whiteColor] next:
			 [VSSolidBorderStyle styleWithColor:kBlackColor width:1 next:nil]]];
}


-(VSStyle *)partRoundRectStyle {
	return [VSShapeStyle styleWithShape:
			[VSRoundedRectangleShape shapeWithTopLeft:0 topRight:0 bottomRight:10 bottomLeft:10] next:
			[VSSolidFillStyle styleWithColor:[VSColor whiteColor] next:
			 [VSSolidBorderStyle styleWithColor:kBlackColor width:1 next:nil]]];
}


-(VSStyle *)speechRectStyle {
	return [VSShapeStyle styleWithShape:[VSSpeechBubbleShape shapeWithRadius:5 pointLocation:60
																  pointAngle:90
																   pointSize:CGSizeMake(20,10)] next:
			[VSSolidFillStyle styleWithColor:[VSColor whiteColor] next:
			 [VSSolidBorderStyle styleWithColor:kBlackColor width:1 next:nil]]];
}


-(VSStyle *)speechRectAltStyle {
	return [VSShapeStyle styleWithShape:[VSSpeechBubbleShape shapeWithRadius:5 pointLocation:290
																  pointAngle:270
																   pointSize:CGSizeMake(20,10)] next:
			[VSSolidFillStyle styleWithColor:[UIColor whiteColor] next:
			 [VSSolidBorderStyle styleWithColor:kBlackColor width:1 next:nil]]];
}


-(VSStyle *)dropShadowStyle {
	return [VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:10] next:
			[VSShadowStyle styleWithColor:VSColorRGBA(0,0,0,0.5) blur:5 offset:CGSizeMake(2, 2) next:
			 [VSInsetStyle styleWithInset:UIEdgeInsetsMake(0.25, 0.25, 0.25, 0.25) next:
			  [VSSolidFillStyle styleWithColor:[VSColor whiteColor] next:
			   [VSInsetStyle styleWithInset:UIEdgeInsetsMake(-0.25, -0.25, -0.25, -0.25) next:
				[VSSolidBorderStyle styleWithColor:kBlackColor width:1 next:nil]]]]]];
}


-(VSStyle *)innShadowStyle {
	return [VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:10] next:
			[VSSolidFillStyle styleWithColor:[VSColor whiteColor] next:
			 [VSInnerShadowStyle styleWithColor:VSColorRGBA(0,0,0,0.5) blur:6 offset:CGSizeMake(1, 1) next:
			  [VSSolidBorderStyle styleWithColor:kBlackColor width:1 next:nil]]]];
}


-(VSStyle *)chiselStyle {
	return [VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:10] next:
			[VSShadowStyle styleWithColor:VSColorRGBA(1, 1, 1, 0.9) blur:1 offset:CGSizeMake(0, 1) next:
			 [VSLinearGradientFillStyle styleWithColor1:VSColorRGB(1, 1, 1)
												 color2:VSColorRGB(0.85, 0.87, 0.91) next:
			  [VSSolidBorderStyle styleWithColor:kBlueColor width:1 next:nil]]]];
}


-(VSStyle *)embossStyle {
	return [VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:10] next:
			[VSLinearGradientFillStyle styleWithColor1:VSColorRGB(1, 1, 1)
												color2:VSColorRGB(0.85, 0.87, 0.91) next:
			 [VSFourBorderStyle styleWithTop:kBlueColor right:kBlackColor bottom:kBlackColor left:kBlueColor width:1 next:nil]]];
}


-(VSStyle *)toolbarButtonStyle {
	return [VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:4.5] next:
			[VSShadowStyle styleWithColor:VSColorRGB(1, 1, 1) blur:1 offset:CGSizeMake(0, 1) next:
			 [VSReflectiveFillStyle styleWithColor:kDarkBlueColor next:
			  [VSBevelBorderStyle styleWithHighlight:[kDarkBlueColor shadow]
											  shadow:[kDarkBlueColor multiplyHue:1 saturation:0.5 value:0.5]
											   width:1 lightSource:270 next:
			   [VSInsetStyle styleWithInset:UIEdgeInsetsMake(0, -1, 0, -1) next:
				[VSBevelBorderStyle styleWithHighlight:nil shadow:VSColorRGBA(0,0,0,0.15)
												 width:1 lightSource:270 next:nil]]]]]];
}


-(VSStyle *)backButtonStyle {
	return [VSShapeStyle styleWithShape:[VSRoundedLeftArrowShape shapeWithRadius:4.5] next:
			[VSShadowStyle styleWithColor:VSColorRGB(1, 1, 1) blur:1 offset:CGSizeMake(0, 1) next:
			 [VSReflectiveFillStyle styleWithColor:kDarkBlueColor next:
			  [VSBevelBorderStyle styleWithHighlight:[kDarkBlueColor shadow]
											  shadow:[kDarkBlueColor multiplyHue:1 saturation:0.5 value:0.5]
											   width:1 lightSource:270 next:
			   [VSInsetStyle styleWithInset:UIEdgeInsetsMake(0, -1, 0, -1) next:
				[VSBevelBorderStyle styleWithHighlight:nil shadow:VSColorRGBA(0,0,0,0.15)
												 width:1 lightSource:270 next:nil]]]]]];
}


-(VSStyle *)badgeStyle {
	return [VSShapeStyle styleWithShape:[VSRoundedRectangleShape shapeWithRadius:VS_ROUNDED] next:
			[VSInsetStyle styleWithInset:UIEdgeInsetsMake(1.5, 1.5, 1.5, 1.5) next:
			 [VSShadowStyle styleWithColor:VSColorRGBA(0,0,0,0.8) blur:3 offset:CGSizeMake(0, 5) next:
			  [VSReflectiveFillStyle styleWithColor:[VSColor redColor] next:
			   [VSInsetStyle styleWithInset:UIEdgeInsetsMake(-1.5, -1.5, -1.5, -1.5) next:
				[VSSolidBorderStyle styleWithColor:[VSColor whiteColor] width:3 next:nil]]]]]];
}


-(VSStyle *)maskedImageStyle {
	return nil;
	//[TTMaskStyle styleWithMask:TTIMAGE(@"bundle://mask.png") next:
	// [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(0, 180, 231)
	//									 color2:RGBCOLOR(0, 0, 255) next:nil]]
}

@end
