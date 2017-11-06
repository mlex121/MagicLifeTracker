//  
//  ALPlayerView.m
//  MagicLifeTracker
//  
//  Created by Alexander Lim on 2017-11-06.
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

#import "ALPlayerView.h"
#import "ALLifeTrackerView.h"
#import "ALRollView.h"
#import "ALMacros.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ALPlayerView

@interface ALPlayerView () <ALRollViewDelegate>

@property (nonatomic, readonly) ALLifeTrackerView *lifeTrackerView;
@property (nonatomic, readonly) ALRollView *rollView;

@end

@implementation ALPlayerView

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        _lifeTrackerView = [[ALLifeTrackerView alloc] initWithFrame:frame];
        [self addSubview:self.lifeTrackerView];

        _rollView = [[ALRollView alloc] initWithFrame:frame];
        self.rollView.delegate = self;
        self.rollView.hidden = YES;
        [self addSubview:self.rollView];
    }

    return self;
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.lifeTrackerView.frame = self.bounds;
    self.rollView.frame = self.bounds;
}

#pragma mark - ALRollViewDelegate

- (void)rollViewTapped:(ALRollView *)rollView
{
    __strong id<ALPlayerViewDelegate> _Nullable delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(playerViewRollViewTapped:)])
    {
        [delegate playerViewRollViewTapped:self];
    }
}

#pragma mark - Public API

- (void)setLifeTotal:(NSInteger)lifeTotal
{
    self.lifeTrackerView.lifeTotal = lifeTotal;
}

- (NSInteger)lifeTotal
{
    return self.lifeTrackerView.lifeTotal;
}

static const NSTimeInterval animationDuration = 0.25;

- (void)rollWithValue:(NSUInteger)rollValue isWinner:(BOOL)isWinner
{
    self.rollView.value = rollValue;
    self.rollView.winner = isWinner;

    [self.rollView.layer removeAllAnimations];
    self.rollView.alpha = 0;
    self.rollView.hidden = NO;

    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.rollView.alpha = 1;
                     } completion:^(BOOL finished) {
                         [self clearRollDelayed];
                     }];
}

- (void)clearRollDelayed
{
    ALWeakSelfType weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ALStrongSelfType blockSelf = weakSelf;
        [blockSelf clearRoll];
    });
}

- (void)clearRoll
{
    if (fabs(self.rollView.alpha) < DBL_EPSILON ||
        self.rollView.hidden == YES) {
        self.rollView.alpha = 0;
        self.rollView.hidden = YES;
        return;
    }

    [self.rollView.layer removeAllAnimations];

    self.rollView.alpha = 1;
    self.rollView.hidden = NO;

    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.rollView.alpha = 0;
                     } completion:^(BOOL finished) {
                         self.rollView.hidden = YES;
                     }];
}

@end

NS_ASSUME_NONNULL_END
