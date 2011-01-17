//
//  VSBlendStyle.h
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

#import "VSBlendStyle.h"

@implementation VSBlendStyle

@synthesize blendMode = _blendMode;


///////////////////////////////////////////////////////////////////////////////////////////////////
// class public

+ (VSBlendStyle*)styleWithBlend:(CGBlendMode)blendMode next:(VSStyle*)next {
  VSBlendStyle* style = [[[self alloc] initWithNext:next] autorelease];
  style.blendMode = blendMode;
  return style;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNext:(VSStyle*)next {
	if (self = [super initWithNext:next]) {
		_blendMode = kCGBlendModeNormal;
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// VSStyle

- (void)draw:(VSStyleContext*)context {
  if (_blendMode) {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextSetBlendMode(ctx, _blendMode);

    [self.next draw:context];
    CGContextRestoreGState(ctx);

  } else {
    return [self.next draw:context];
  }
}


@end
