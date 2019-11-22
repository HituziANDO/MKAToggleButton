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

@interface MKAToggleItem : NSObject
/**
 * An icon.
 */
@property (nonatomic, nullable, readonly) UIImage *image;
/**
 * A title.
 */
@property (nonatomic, copy, nullable, readonly) NSString *title;

/**
 * Creates an item.
 *
 * @param image An icon.
 * @param title A title.
 * @return An item.
 */
+ (instancetype)toggleItemWithImage:(nullable UIImage *)image title:(nullable NSString *)title;
/**
 * Creates an item.
 *
 * @param image An icon.
 * @return An item.
 */
+ (instancetype)toggleItemWithImage:(UIImage *)image;
/**
 * Creates an item.
 *
 * @param title A title.
 * @return An item.
 */
+ (instancetype)toggleItemWithTitle:(NSString *)title;

@end

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
/**
 * A handler when the click event occurred.
 */
@property (nonatomic, copy, nullable) void (^clickHandler)(id sender);
/**
 * Current state.
 */
@property (nonatomic) NSUInteger currentStateIndex;

+ (instancetype)toggleButtonWithItems:(NSArray<MKAToggleItem *> *)items;
+ (instancetype)toggleButtonWithItems:(NSArray<MKAToggleItem *> *)items
                                 font:(nullable UIFont *)font
                                color:(nullable UIColor *)color;
+ (instancetype)toggleButtonWithDictionary:(NSArray<NSDictionary<NSString *, UIImage *> *> *)dictionary
DEPRECATED_MSG_ATTRIBUTE("Use `toggleButtonWithItems:` method instead.");;
+ (instancetype)toggleButtonWithDictionary:(NSArray<NSDictionary<NSString *, UIImage *> *> *)dictionary
                                      font:(nullable UIFont *)font
                                     color:(nullable UIColor *)color
DEPRECATED_MSG_ATTRIBUTE("Use `toggleButtonWithItems:font:color:` method instead.");
+ (instancetype)toggleButtonWithImages:(NSArray<UIImage *> *)images
DEPRECATED_MSG_ATTRIBUTE("Use `toggleButtonWithItems:` method instead.");
+ (instancetype)toggleButtonWithTitles:(NSArray<NSString *> *)titles
DEPRECATED_MSG_ATTRIBUTE("Use `toggleButtonWithItems:` method instead.");
+ (instancetype)toggleButtonWithTitles:(NSArray<NSString *> *)titles
                                  font:(nullable UIFont *)font
                                 color:(nullable UIColor *)color
DEPRECATED_MSG_ATTRIBUTE("Use `toggleButtonWithItems:font:color:` method instead.");

/**
 * Moves to next state.
 */
- (void)nextState;

@end

NS_ASSUME_NONNULL_END
