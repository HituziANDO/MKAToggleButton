//
// MKAToggleButton
//
// Copyright (c) 2020 Hituzi Ando. All rights reserved.
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

#import "MKAIconToggleButton.h"

@interface MKAToggleItem ()

@property (nonatomic, nullable) UIImage *image;
@property (nonatomic, copy, nullable) NSString *title;

- (CGSize)sizeWithFont:(UIFont *)font;

@end

@implementation MKAToggleItem

+ (instancetype)toggleItemWithImage:(nullable UIImage *)image title:(nullable NSString *)title {
    MKAToggleItem *item = [MKAToggleItem new];
    item.image = image;
    item.title = title;
    return item;
}

+ (instancetype)toggleItemWithImage:(UIImage *)image {
    MKAToggleItem *item = [MKAToggleItem new];
    item.image = image;
    return item;
}

+ (instancetype)toggleItemWithTitle:(NSString *)title {
    MKAToggleItem *item = [MKAToggleItem new];
    item.title = title;
    return item;
}

- (CGSize)sizeWithFont:(UIFont *)font {
    CGSize imageSize = self.image ? self.image.size : CGSizeZero;
    CGSize titleSize = self.title ? [self.title sizeWithAttributes:@{ NSFontAttributeName: font }] : CGSizeZero;
    return CGSizeMake(imageSize.width + titleSize.width, imageSize.height + titleSize.height);
}

@end

@interface MKAIconToggleButton ()

@property (nonatomic, copy) NSMutableArray<MKAToggleItem *> *items;
@property (nonatomic, nullable) UIColor *tintColorCache;
@property (nonatomic) UILongPressGestureRecognizer *longPressGesture;

@end

@implementation MKAIconToggleButton

// Margin left + margin right for `titleLabel`
static const CGFloat MKAIconToggleButtonMarginX = 16.f;

+ (instancetype)toggleButtonWithItems:(NSArray<MKAToggleItem *> *)items {
    return [self toggleButtonWithItems:items font:nil color:nil];
}

+ (instancetype)toggleButtonWithItems:(NSArray<MKAToggleItem *> *)items
                                 font:(nullable UIFont *)font
                                color:(nullable UIColor *)color {

    MKAIconToggleButton *button = [MKAIconToggleButton new];
    [button.items addObjectsFromArray:items];
    button.titleLabel.font = font;
    button.tintColor = color;

    return [button build];
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        _items = [NSMutableArray new];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        _items = [NSMutableArray new];
    }

    return self;
}

- (void)dealloc {
    self.onClicked = nil;
    self.onLongPressBegan = nil;
    self.onLongPressChanged = nil;
    self.onLongPressEnded = nil;
    self.onLongPressCancelled = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    NSArray<NSString *> *imageNamesArray = [self.imageNames componentsSeparatedByString:@","];

    for (NSString *imageName in imageNamesArray) {
        NSString *name = [imageName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        UIImage *image = [UIImage imageNamed:name];

        if (image) {
            [self.items addObject:[MKAToggleItem toggleItemWithImage:image title:nil]];
        }
    }

    [self build];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(self.touchableBounds, point);
}

#pragma mark - property

- (void)setTintColor:(UIColor *)color {
    [super setTintColor:color];
    [self reloadView];
    self.tintColorCache = color;
}

- (CGRect)touchableBounds {
    CGRect rect = self.bounds;
    rect.origin.x -= self.touchableExtensionLeft;
    rect.origin.y -= self.touchableExtensionTop;
    rect.size.width += (self.touchableExtensionLeft + self.touchableExtensionRight);
    rect.size.height += (self.touchableExtensionTop + self.touchableExtensionBottom);
    return rect;
}

- (void)setImageTemplate:(BOOL)imageTemplate {
    _imageTemplate = imageTemplate;
    [self reloadView];
}

- (void)setCurrentStateIndex:(NSUInteger)currentStateIndex {
    if (currentStateIndex < 0) {
        @throw [NSException exceptionWithName:NSRangeException
                                       reason:@"`currentStateIndex` must be upper than or equal to 0"
                                     userInfo:nil];
    }
    else if (currentStateIndex < self.items.count) {
        _currentStateIndex = currentStateIndex;
    }
    else {
        _currentStateIndex = 0;
    }

    [self reloadView];
}

- (void)setClickHandler:(void (^)(id _Nonnull))clickHandler {
    self.onClicked = clickHandler;
}

- (void (^)(id _Nonnull))clickHandler {
    return self.onClicked;
}

#pragma mark - public method

- (void)nextState {
    ++self.currentStateIndex;
}

#pragma mark - private method

- (instancetype)build {
    // Set first view.
    self.currentStateIndex = 0;

    [self addTarget:self action:@selector(mka_click:) forControlEvents:UIControlEventTouchUpInside];

    __block CGSize maxSize = CGSizeZero;
    [self.items enumerateObjectsUsingBlock:^(MKAToggleItem *item, NSUInteger idx, BOOL *stop) {
        CGSize size = [item sizeWithFont:self.titleLabel.font];

        if (maxSize.width < size.width) {
            maxSize = size;
        }
    }];
    self.bounds = (CGRect) { CGPointZero, CGSizeMake(maxSize.width + MKAIconToggleButtonMarginX, maxSize.height) };

    self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(mka_longPress:)];
    self.longPressGesture.minimumPressDuration = 0.5;
    [self addGestureRecognizer:self.longPressGesture];

    self.tintColorCache = self.tintColor;

    if (@available(iOS 13.0, *)) {
        UIHoverGestureRecognizer *recognizer = [[UIHoverGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(hovering:)];
        [self addGestureRecognizer:recognizer];
    }

    return self;
}

- (void)mka_click:(id)sender {
    ++self.currentStateIndex;

    if (self.onClicked) {
        self.onClicked(self);
    }
}

- (void)mka_longPress:(UILongPressGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            if (self.onLongPressBegan) {
                self.onLongPressBegan(self);
            }
            break;
        case UIGestureRecognizerStateChanged:
            if (self.onLongPressChanged) {
                self.onLongPressChanged(self);
            }
            break;
        case UIGestureRecognizerStateEnded:
            if (self.onLongPressEnded) {
                self.onLongPressEnded(self);
            }
            break;
        case UIGestureRecognizerStateCancelled:
            if (self.onLongPressCancelled) {
                self.onLongPressCancelled(self);
            }
            break;
        default:
            break;
    }
}

- (void)reloadView {
    [self setImage:[self imageAtIndex:self.currentStateIndex] forState:UIControlStateNormal];
    [self setTitle:[self titleAtIndex:self.currentStateIndex] forState:UIControlStateNormal];
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
}

- (nullable UIImage *)imageAtIndex:(NSUInteger)index {
    if (index < self.items.count) {
        if (self.isImageTemplate) {
            return [self.items[index].image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        else {
            return [self.items[index].image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }
    else {
        return nil;
    }
}

- (nullable NSString *)titleAtIndex:(NSUInteger)index {
    if (index < self.items.count) {
        return self.items[index].title;
    }
    else {
        return nil;
    }
}

- (void)hovering:(UIHoverGestureRecognizer *)recognizer API_AVAILABLE(ios(13.0)) {
    if (!self.hoverColor) {
        return;
    }

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            self.tintColor = self.hoverColor;
            [self setTitleColor:self.tintColor forState:UIControlStateNormal];
            break;
        case UIGestureRecognizerStateEnded:
            self.tintColor = self.tintColorCache;
            [self setTitleColor:self.tintColor forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

@end
