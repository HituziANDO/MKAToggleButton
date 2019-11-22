//
// MKAToggleButton
//
// Copyright (c) 2019-present Hituzi Ando. All rights reserved.
//
// MIT License
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAIconToggleButton : UIButton
/**
 * Touchable extension left.
 */
@property (nonatomic) IBInspectable CGFloat touchableExtensionLeft;
/**
 * Touchable extension top.
 */
@property (nonatomic) IBInspectable CGFloat touchableExtensionTop;
/**
 * Touchable extension right.
 */
@property (nonatomic) IBInspectable CGFloat touchableExtensionRight;
/**
 * Touchable extension bottom.
 */
@property (nonatomic) IBInspectable CGFloat touchableExtensionBottom;
/**
 * Touchable bounds.
 */
@property (nonatomic, readonly) CGRect touchableBounds;

@property (nonatomic, copy, nullable) IBInspectable NSString *imageNames;
/**
 * Tells whether rendering mode is template mode.
 */
@property (nonatomic, getter=isImageTemplate) IBInspectable BOOL imageTemplate;
@property (nonatomic, copy, nullable) void (^clickHandler)(id sender);
@property (nonatomic) NSUInteger selectedIndex DEPRECATED_MSG_ATTRIBUTE("Uses `currentStateIndex` instead of this.");
@property (nonatomic) NSUInteger currentStateIndex;

+ (instancetype)toggleButtonWithImages:(NSArray<UIImage *> *)images;
+ (instancetype)toggleButtonWithTitles:(NSArray<NSString *> *)titles;
+ (instancetype)toggleButtonWithTitles:(NSArray<NSString *> *)titles
                                  font:(nullable UIFont *)font
                                 color:(nullable UIColor *)color;
+ (instancetype)toggleButtonWithItems:(NSArray<NSDictionary<NSString *, UIImage *> *> *)items;
+ (instancetype)toggleButtonWithItems:(NSArray<NSDictionary<NSString *, UIImage *> *> *)items
                                 font:(nullable UIFont *)font
                                color:(nullable UIColor *)color;

- (instancetype)withImages:(NSArray<UIImage *> *)images DEPRECATED_MSG_ATTRIBUTE(
    "Uses `+ toggleButtonWithImages:` instead of this.");

- (void)nextState;

@end

NS_ASSUME_NONNULL_END
