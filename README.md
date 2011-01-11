Overview
========

VillainousStyle is a drawing library for defining a visual style from a chain of individual drawing instructions. Each instruction modifies the drawing context to perform common drawing operations such as creating shadows, fills, borders, and shapes. It allows for multiple style sheets which can be used to theme an application in multiple visual contexts. VillainousStyle sits on top of CoreGraphics, and does not use WebKit for rendering at all. It is a fork of the VSStyle and VSShape classes, originally from the [Three20 project](http://github.com/joehewitt/three20).

This fork of VillainousStyle includes two Xcode projects, supporting a total of five targets:  
* VillainousStyle.framework for use on Mac OS X
* libVillainousStyle.a for use on Mac OS X
* Villainous, a demo app built for Mac OS X
* libVillainousStyle.a for use in building iOS apps
* MobileVillainous, a demo app built for iOS

Requirements
============

* Mac OS X 10.5+ (building/running)
* A version of Xcode that supports "latest iOS" and "latest Mac OS X" options
* 

Install
=======

Clone or download the repository.

For use in Mac apps, build the framework using "VillainousStyle Mac.xcodeproj".

For use in iOS, drag "VillainousStyle iOS.xcodeproj" into your Xcode project, enter the target settings for your application, add libVillainousStyle.a as a dependency, and then drag libVillainousStyle.a into your target's "Link Binary with Libraries."

You may also build and run the test applications from their appropriate Xcode projects.

Stylesheets
===========

VSStyleSheet is an abstract superclass for a set of styles. To create your own stylesheet, subclass VSStyleSheet and add methods that return an instance of VSStyle for each style you wish to add. You will likely want to create a protocol for your styles to implement, to ensure that your stylesheet implements all the necessary styles.

There is a global stylesheet, which can be thought of as the "active" stylesheet. Call `+[VSStyleSheet setGlobalStyleSheet:]` to change the active theme, which will fire a `VSStyleSheetChangedNotification`. When that gets fired, you'll want to tell your views to update their styles and redraw.

Features
======

VillainousStyle can draw both styles and shapes.  Styles affect drawing and positioning, whereas shapes affect the fills and borders but do not clip the content styles.  Most styles' invocation can support more VSStyles on the chain.

* Fills
 * VSSolidFillStyle - Fills the current shape with a solid color
 * VSLinearGradientFillStyle - Fills the current shape with a gradient between two colors
 * VSReflectiveFillStyle - Fills the current shape with a glossy-style gradient between two colors
* Borders
 * VSSolidBorderStyle - Draws a border around the current shape with a solid color
 * VSBevelBorderStyle - Draws a beveled edge border for a 3D effect around the current shape
 * VSFourBorderStyle - Draws a border around the current shape with four colors, one for each edge
* Shadows
 * VSShadowStyle - Draws a shadow behind content with a given color, blur, and offset
 * VSInnerShadowStyle - Draws a shadow inside the content with a given color, blur, and offset
* Positioning
 * VSBoxStyle - Adds a margin or padding to the content area
 * VSInsetStyle - Adds edge insets to the content area
* Content
 * VSTextStyle - Draws text inside the current shape (see VSStyleDelegate)
 * VSImageStyle - Draws an image inside the current shape (see VSStyleDelegate)
 * VSContentStyle - Calls a delegate method to draw arbitrary content (see VSStyleDelegate)
* Clipping
 * VSMaskStyle - Clips the drawing area to an image mask
 * VSShapeStyle - Clips the drawing area with a VSShape object
* Shapes
 * VSRectangleShape
 * VSRoundedRectangleShape
 * VSRoundedLeftArrowShape - a rounded rectangle with a left-facing arrow
 * VSRoundedRightArrowShape - a rounded rectangle with a right-facing arrow

Screenshots
===========

![Light Test Style](http://github.com/amazingsyco/VillainousStyle/raw/master/Screenshots/light-test-style.png "Light Test Style")
![Dark Test Style](http://github.com/amazingsyco/VillainousStyle/raw/master/Screenshots/dark-test-style.png "Dark Test Style")

License
=======
Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
