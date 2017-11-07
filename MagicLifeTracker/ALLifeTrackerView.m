//  
//  ALLifeTrackerView.m
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

#import "ALLifeTrackerView.h"
#import "ALMacros.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ALLifeTrackerView

@interface ALLifeTrackerView ()

@property (nonatomic, readonly) UIButton *minusButton;
@property (nonatomic, readonly) UIButton *plusButton;
@property (nonatomic, readonly) UILabel *lifeTotalLabel;

@end

@implementation ALLifeTrackerView

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        static const CGFloat buttonLabelAdjustment = 25;

        _minusButton = [[self class] buttonWithTitle:@"⊖"
                                              target:self
                                              action:@selector(minusButtonTapped:)];
        self.minusButton.contentEdgeInsets = UIEdgeInsetsMake(0, -buttonLabelAdjustment, 0, buttonLabelAdjustment);
        [self addSubview:self.minusButton];

        _plusButton = [[self class] buttonWithTitle:@"⊕"
                                             target:self
                                             action:@selector(plusButtonTapped:)];
        self.plusButton.contentEdgeInsets = UIEdgeInsetsMake(0, buttonLabelAdjustment, 0, -buttonLabelAdjustment);
        [self addSubview:self.plusButton];

        _lifeTotalLabel = [[UILabel alloc] init];
        self.lifeTotalLabel.textColor = UIColor.whiteColor;
        self.lifeTotalLabel.font = [UIFont systemFontOfSize:100];
        self.lifeTotalLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lifeTotalLabel];

        self.lifeTotal = 0;
    }

    return self;
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.minusButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds));
    self.plusButton.frame = CGRectMake(CGRectGetMidX(self.bounds), 0, CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds));
    self.lifeTotalLabel.frame = self.bounds;
}

#pragma mark - Actions

- (void)minusButtonTapped:(null_unspecified UIButton *)sender
{
    self.lifeTotal -= 1;
}

- (void)plusButtonTapped:(null_unspecified UIButton *)sender
{
    self.lifeTotal += 1;
}

#pragma mark - Public API

- (void)setLifeTotal:(NSInteger)lifeTotal
{
    _lifeTotal = lifeTotal;
    self.lifeTotalLabel.text = [NSString stringWithFormat:@"%zd",
                                _lifeTotal];
}

#pragma mark - Private API

+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    ALAssertNonnull(title);
    UIButton *button = [[UIButton alloc] init];

    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textColor = UIColor.whiteColor;
    button.titleLabel.font = [UIFont systemFontOfSize:50];
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    button.showsTouchWhenHighlighted = YES;

    return button;
}

@end

NS_ASSUME_NONNULL_END
