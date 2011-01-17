//
//  VSHighlightBorderStyle.h
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

#import "VSStyle.h"

@interface VSHighlightBorderStyle : VSStyle {
  VSColor*  _color;
  VSColor*  _highlightColor;
  CGFloat   _width;
}

@property (nonatomic, retain) VSColor*  color;
@property (nonatomic, retain) VSColor*  highlightColor;
@property (nonatomic)         CGFloat   width;

+ (VSHighlightBorderStyle*)styleWithColor:(VSColor*)color highlightColor:(VSColor*)highlightColor width:(CGFloat)width next:(VSStyle*)next;

@end
