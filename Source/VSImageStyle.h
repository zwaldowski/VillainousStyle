//
//  VSImageStyle.h
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

#import "VSGlobal.h"
#import "VSStyle.h"
#import "NSImage+ContentMode.h"

@interface VSImageStyle : VSStyle {
	NSString* _imageURL;
	VSImage* _image;
	VSImage* _defaultImage;
	UIViewContentMode _contentMode;
	CGSize _size;
}

@property(nonatomic,copy) NSString* imageURL;
@property(nonatomic,retain) VSImage* image;
@property(nonatomic,retain) VSImage* defaultImage;
@property(nonatomic) CGSize size;
@property(nonatomic) UIViewContentMode contentMode;

+ (VSImageStyle*)styleWithImageURL:(NSString*)imageURL next:(VSStyle*)next;
+ (VSImageStyle*)styleWithImageURL:(NSString*)imageURL defaultImage:(VSImage*)defaultImage
							  next:(VSStyle*)next;
+ (VSImageStyle*)styleWithImageURL:(NSString*)imageURL defaultImage:(VSImage*)defaultImage
					   contentMode:(UIViewContentMode)contentMode
							  size:(CGSize)size next:(VSStyle*)next;
+ (VSImageStyle*)styleWithImage:(VSImage*)image next:(VSStyle*)next;
+ (VSImageStyle*)styleWithImage:(VSImage*)image defaultImage:(VSImage*)defaultImage
						   next:(VSStyle*)next;
+ (VSImageStyle*)styleWithImage:(VSImage*)image defaultImage:(VSImage*)defaultImage
					contentMode:(UIViewContentMode)contentMode
						   size:(CGSize)size next:(VSStyle*)next;

@end
