//
//  VSStyles.h
//  VillainousStyle
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

#import <VillainousStyle/VSGlobal.h>

#import <VillainousStyle/VSStyleDelegate.h>

#import <VillainousStyle/VSStyle.h>

#import <VillainousStyle/VSBlendStyle.h>
#import <VillainousStyle/VSPartStyle.h>

#import <VillainousStyle/VSSolidFillStyle.h>
#import <VillainousStyle/VSLinearGradientFillStyle.h>
#import <VillainousStyle/VSReflectiveFillStyle.h>

#import <VillainousStyle/VSHighlightBorderStyle.h>
#import <VillainousStyle/VSLinearGradientBorderStyle.h>
#import <VillainousStyle/VSSolidBorderStyle.h>
#import <VillainousStyle/VSBevelBorderStyle.h>
#import <VillainousStyle/VSFourBorderStyle.h>

#import <VillainousStyle/VSShadowStyle.h>
#import <VillainousStyle/VSInnerShadowStyle.h>

#import <VillainousStyle/VSBoxStyle.h>
#import <VillainousStyle/VSInsetStyle.h>

#import <VillainousStyle/VSTextStyle.h>
#import <VillainousStyle/VSImageStyle.h>
#import <VillainousStyle/VSContentStyle.h>
#import <VillainousStyle/VSMaskStyle.h>
#import <VillainousStyle/VSShapeStyle.h>

#import <VillainousStyle/VSStyleSheet.h>

#define VSStyleNamed(_SELECTOR) (VSStyle *)([[VSStyleSheet globalStyleSheet] styleWithSelector: @#_SELECTOR ])