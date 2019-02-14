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

@interface MKAIconToggleButton ()

@property (nonatomic, copy) NSMutableArray<UIImage *> *images;

@end

@implementation MKAIconToggleButton

+ (instancetype)toggleButtonWithImages:(NSArray<UIImage *> *)images {
    return [[MKAIconToggleButton new] withImages:images];
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

    [self withImages:images];
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
    else if (currentStateIndex < self.images.count) {
        _currentStateIndex = currentStateIndex;
    }
    else {
        _currentStateIndex = 0;
    }

    [self setImage:[self imageAtIndex:_currentStateIndex] forState:UIControlStateNormal];
}

#pragma mark - public method

- (instancetype)withImages:(NSArray<UIImage *> *)images {
    _images = images.mutableCopy;

    UIImage *image = [self imageAtIndex:0];

    if (image) {
        [self setImage:image forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        self.bounds = (CGRect) { CGPointZero, image.size };
    }

    [self addTarget:self action:@selector(mka_click:) forControlEvents:UIControlEventTouchUpInside];

    return self;
}

- (void)nextState {
    ++self.currentStateIndex;
}

#pragma mark - private method

- (void)mka_click:(id)sender {
    ++self.currentStateIndex;

    if (self.clickHandler) {
        self.clickHandler(self);
    }
}

- (nullable UIImage *)imageAtIndex:(NSUInteger)index {
    if (index < self.images.count) {
        if (self.isImageTemplate) {
            return [self.images[index] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        else {
            return self.images[index];
        }
    }
    else {
        return nil;
    }
}

@end
