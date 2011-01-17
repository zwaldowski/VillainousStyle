//
//  iLightStyleSheet.h
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

#import <Foundation/Foundation.h>
#import "VSStyleSheet.h"

@interface iLightStyleSheet : VSStyleSheet;

-(VSStyle *)backgroundStyle;
-(VSStyle *)toggleLabelStyle;

-(VSStyle *)rectStyle;
-(VSStyle *)roundRectStyle;
-(VSStyle *)gradBorderStyle;
-(VSStyle *)roundLeftArrowStyle;
-(VSStyle *)partRoundRectStyle;
-(VSStyle *)speechRectStyle;
-(VSStyle *)speechRectAltStyle;
-(VSStyle *)dropShadowStyle;
-(VSStyle *)innShadowStyle;
-(VSStyle *)chiselStyle;
-(VSStyle *)embossStyle;
-(VSStyle *)toolbarButtonStyle;
-(VSStyle *)backButtonStyle;
-(VSStyle *)badgeStyle;
-(VSStyle *)maskedImageStyle;

@end
