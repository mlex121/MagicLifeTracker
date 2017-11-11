//  
//  ALLifeTrackerButton.m
//  MagicLifeTracker
//  
//  Created by Alexander Lim on 11/7/17.
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

#import "ALLifeTrackerButton.h"
#import "ALMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALLifeTrackerButton ()

- (instancetype)initWithTitle:(NSString *)title target:(id)target pressAction:(SEL)pressAction horizontalAdjustment:(CGFloat)horizontalAdjustment NS_DESIGNATED_INITIALIZER;

@end

@implementation ALLifeTrackerButton

#pragma mark - Initializers

- (instancetype)initWithTitle:(NSString *)title target:(id)target pressAction:(SEL)pressAction horizontalAdjustment:(CGFloat)horizontalAdjustment
{
    self = [super initWithFrame:CGRectZero];

    if (self)
    {
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.textColor = UIColor.whiteColor;
        self.titleLabel.font = [UIFont systemFontOfSize:50];
        [self addTarget:target
                 action:pressAction
       forControlEvents:UIControlEventTouchUpInside];
        self.contentEdgeInsets = UIEdgeInsetsMake(0, horizontalAdjustment, 0, -horizontalAdjustment);
    }

    return self;
}

+ (instancetype)plusButtonWithTarget:(id)target pressAction:(SEL)pressAction horizontalAdjustment:(CGFloat)horizontalAdjustment
{
    return [[self alloc] initWithTitle:@"⊕"
                                target:target
                           pressAction:pressAction
                  horizontalAdjustment:horizontalAdjustment];
}

+ (instancetype)minusButtonWithTarget:(id)target pressAction:(SEL)pressAction horizontalAdjustment:(CGFloat)horizontalAdjustment
{
    return [[self alloc] initWithTitle:@"⊖"
                                target:target
                           pressAction:pressAction
                  horizontalAdjustment:-horizontalAdjustment];
}

- (instancetype)initWithFrame:(CGRect)frame AL_UNRECOGNIZED_SELECTOR
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder AL_UNRECOGNIZED_SELECTOR
- (instancetype)init AL_UNRECOGNIZED_SELECTOR
+ (instancetype)new AL_UNRECOGNIZED_SELECTOR

#pragma mark - UIButton

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.backgroundColor = highlighted ? [UIColor colorWithWhite:1 alpha:0.5] : UIColor.clearColor;
}

@end

NS_ASSUME_NONNULL_END
