//  
//  ALRollView.m
//  MagicLifeTracker
//  
//  Created by Alexander Lim on 2017-11-05.
//  Copyright 2017 Alexander Lim
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ALRollView.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ALRollView

@interface ALRollView ()

@property (nonatomic, readonly) UILabel *label;
@property (nonatomic, readonly) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation ALRollView

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        // It's a dice roll, there's no zero.
        _value = 1;
        _winner = NO;

        _label = [[UILabel alloc] init];
        self.label.textColor = UIColor.whiteColor;
        self.label.font = [UIFont systemFontOfSize:50];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.numberOfLines = 2;
        [self addSubview:self.label];

        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [self.tapGestureRecognizer addTarget:self action:@selector(tapGestureRecognized:)];
        [self addGestureRecognizer:self.tapGestureRecognizer];

        [self update];
    }

    return self;
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    const CGFloat inset = 20;
    const UIEdgeInsets insets = UIEdgeInsetsMake(inset, inset, inset, inset);
    self.label.frame = UIEdgeInsetsInsetRect(self.bounds, insets);
}

#pragma mark - Gesture recognizers

- (void)tapGestureRecognized:(null_unspecified UITapGestureRecognizer *)sender
{
    __strong id<ALRollViewDelegate> _Nullable delegate = self.delegate;

    if (sender.state == UIGestureRecognizerStateRecognized &&
        [delegate respondsToSelector:@selector(rollViewTapped:)]) {
        [delegate rollViewTapped:self];
    }
}

#pragma mark - Private API

- (void)update
{
    self.label.text = ^NSString * _Nonnull()
    {
        if (self.isWinner)
        {
            return [NSString stringWithFormat:@"You rolled %tu,\nyou pick!", self.value];
        }
        else
        {
            return [NSString stringWithFormat:@"You rolled %tu.", self.value];
        }
    }();
}

#pragma mark - Public API

- (void)setValue:(NSUInteger)value
{
    _value = value;
    [self update];
}

- (void)setWinner:(BOOL)winner
{
    _winner = winner;
    [self update];
}

@end

NS_ASSUME_NONNULL_END
