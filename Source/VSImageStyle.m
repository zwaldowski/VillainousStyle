//
//  VSImageStyle.m
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

#import "VSImageStyle.h"


@implementation VSImageStyle

@synthesize imageURL = _imageURL, image = _image, defaultImage = _defaultImage, contentMode = _contentMode, size = _size;

///////////////////////////////////////////////////////////////////////////////////////////////////
// class public

+ (VSImageStyle*)styleWithImageURL:(NSString*)imageURL next:(VSStyle*)next {
	VSImageStyle* style = [[[self alloc] initWithNext:next] autorelease];
	style.imageURL = imageURL;
	return style;
}

+ (VSImageStyle*)styleWithImageURL:(NSString*)imageURL defaultImage:(VSImage*)defaultImage next:(VSStyle*)next {
	VSImageStyle* style = [[[self alloc] initWithNext:next] autorelease];
	style.imageURL = imageURL;
	style.defaultImage = defaultImage;
	return style;
}

+ (VSImageStyle*)styleWithImageURL:(NSString*)imageURL defaultImage:(VSImage*)defaultImage contentMode:(UIViewContentMode)contentMode size:(CGSize)size next:(VSStyle*)next {
	VSImageStyle* style = [[[self alloc] initWithNext:next] autorelease];
	style.imageURL = imageURL;
	style.defaultImage = defaultImage;
	style.contentMode = contentMode;
	style.size = size;
	return style;
}

+ (VSImageStyle*)styleWithImage:(VSImage*)image next:(VSStyle*)next {
	VSImageStyle* style = [[[self alloc] initWithNext:next] autorelease];
	style.image = image;
	return style;
}

+ (VSImageStyle*)styleWithImage:(VSImage*)image defaultImage:(VSImage*)defaultImage next:(VSStyle*)next {
	VSImageStyle* style = [[[self alloc] initWithNext:next] autorelease];
	style.image = image;
	style.defaultImage = defaultImage;
	return style;
}

+ (VSImageStyle*)styleWithImage:(VSImage*)image defaultImage:(VSImage*)defaultImage contentMode:(UIViewContentMode)contentMode size:(CGSize)size next:(VSStyle*)next {
	VSImageStyle* style = [[[self alloc] initWithNext:next] autorelease];
	style.image = image;
	style.defaultImage = defaultImage;
	style.contentMode = contentMode;
	style.size = size;
	return style;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (VSImage*)imageForContext:(VSStyleContext*)context {
	VSImage* image = self.image;
	if (!image && [context.delegate respondsToSelector:@selector(imageForLayerWithStyle:)]) {
		image = [context.delegate imageForLayerWithStyle:self];
	}
	return image;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNext:(VSStyle*)next {  
	if (self = [super initWithNext:next]) {
		_imageURL = nil;
		_image = nil;
		_defaultImage = nil;
		_contentMode = UIViewContentModeScaleToFill;
		_size = CGSizeZero;
	}
	return self;
}

- (void)dealloc {
	[_imageURL release];
	[_image release];
	[_defaultImage release];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// VSStyle

- (void)draw:(VSStyleContext*)context {
	VSImage* image = _image;
	if(!image){
		image = [self imageForContext:context];
	}
	if (image) {
		[image drawInRect:context.contentFrame contentMode:_contentMode];
	}
	return [self.next draw:context];
}

- (CGSize)addToSize:(CGSize)size context:(VSStyleContext*)context {
	if (_size.width || _size.height) {
		size.width += _size.width;
		size.height += _size.height;
	} else if (_contentMode == UIViewContentModeScaleToFill) {
		VSImage* image = [self imageForContext:context];
		if (image) {
			size.width += image.size.width;
			size.height += image.size.height;
		}
	}
	
	if (_next) {
		return [self.next addToSize:size context:context];
	} else {
		return size;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (VSImage*)image {
	if (!_image && _imageURL) {
		NSURL *url = (NSURL *)_imageURL;
		if([url isKindOfClass:[NSString class]]){
			url = [NSURL URLWithString:(NSString *)url];
		}
		_image = [[[VSImage alloc] initWithContentsOfURL:url] retain];
	}
	return _image;
}

@end
