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

#import "MKAIconToggleButton.h"

@interface MKAToggleItem : NSObject

@property (nonatomic, nullable) UIImage *image;
@property (nonatomic, copy, nullable) NSString *title;

- (CGSize)sizeWithFont:(UIFont *)font;

@end

@implementation MKAToggleItem

- (CGSize)sizeWithFont:(UIFont *)font {
    CGSize imageSize = self.image ? self.image.size : CGSizeZero;
    CGSize titleSize = self.title ? [self.title sizeWithAttributes:@{ NSFontAttributeName: font }] : CGSizeZero;

    return CGSizeMake(imageSize.width + titleSize.width, imageSize.height + titleSize.height);
}

@end

@interface MKAIconToggleButton ()

@property (nonatomic, copy) NSMutableArray<MKAToggleItem *> *items;

@end

@implementation MKAIconToggleButton

// Margin left + margin right for `titleLabel`
static const CGFloat MKAIconToggleButtonMarginX = 16.f;

+ (instancetype)toggleButtonWithImages:(NSArray<UIImage *> *)images {
    return [[[MKAIconToggleButton new] setImages:images] build];
}

// TODO: withFont: for size calculation
+ (instancetype)toggleButtonWithTitles:(NSArray<NSString *> *)titles {
    return [[[MKAIconToggleButton new] setTitles:titles] build];
}

+ (instancetype)toggleButtonWithItems:(NSArray<NSDictionary<NSString *, UIImage *> *> *)items {
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:items.count];
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:items.count];

    [items enumerateObjectsUsingBlock:^(NSDictionary<NSString *, UIImage *> *obj, NSUInteger idx, BOOL *stop) {
        [titles addObject:obj.allKeys.firstObject];
        [images addObject:obj[obj.allKeys.firstObject]];
    }];

    return [[[[MKAIconToggleButton new] setImages:images] setTitles:titles] build];
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
    self.clickHandler = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    NSArray<NSString *> *imageNamesArray = [self.imageNames componentsSeparatedByString:@","];

    NSMutableArray<UIImage *> *images = [NSMutableArray new];

    for (NSString *imageName in imageNamesArray) {
        NSString *name = [imageName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        UIImage *image = [UIImage imageNamed:name];

        if (image) {
            [images addObject:image];
        }
    }

    [[self setImages:images] build];
}

#pragma mark - property

- (NSUInteger)selectedIndex {
    return self.currentStateIndex;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    self.currentStateIndex = selectedIndex;
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

    [self setImage:[self imageAtIndex:_currentStateIndex] forState:UIControlStateNormal];
    [self setTitle:[self titleAtIndex:_currentStateIndex] forState:UIControlStateNormal];
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
}

#pragma mark - public method

- (instancetype)withImages:(NSArray<UIImage *> *)images {
    return [[self setImages:images] build];
}

- (void)nextState {
    ++self.currentStateIndex;
}

#pragma mark - private method

- (instancetype)build {
    MKAToggleItem *item = self.items.firstObject;

    if (item) {
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
    }

    return self;
}

- (instancetype)setImages:(NSArray<UIImage *> *)images {
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
        MKAToggleItem *item = [self findOrCreateToggleItemAtIndex:idx];
        item.image = image;
    }];

    return self;
}

- (instancetype)setTitles:(NSArray<NSString *> *)titles {
    [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        MKAToggleItem *item = [self findOrCreateToggleItemAtIndex:idx];
        item.title = title;
    }];

    return self;
}

- (MKAToggleItem *)findOrCreateToggleItemAtIndex:(NSUInteger)index {
    if (index < self.items.count) {
        return self.items[index];
    }
    else {
        MKAToggleItem *item = [MKAToggleItem new];
        [self.items addObject:item];

        return item;
    }
}

- (void)mka_click:(id)sender {
    ++self.currentStateIndex;

    if (self.clickHandler) {
        self.clickHandler(self);
    }
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

@end
