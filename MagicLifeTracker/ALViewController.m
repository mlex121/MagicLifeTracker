//
//  ALViewController.m
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

#import "ALViewController.h"
#import "ALPlayerView.h"
#import "ALSettings.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ALViewController

@interface ALViewController () <ALPlayerViewDelegate>

@property (nonatomic, readonly) ALPlayerView *topPlayerView;
@property (nonatomic, readonly) ALPlayerView *bottomPlayerView;

@end

@implementation ALViewController

#pragma mark - Initializers

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];

    if (self) {
        self.title = @"Magic Life Tracker";

        _topPlayerView = [[ALPlayerView alloc] init];
        self.topPlayerView.delegate = self;

        _bottomPlayerView = [[ALPlayerView alloc] init];
        self.bottomPlayerView.delegate = self;

        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.topPlayerView];
    [self.view addSubview:self.bottomPlayerView];

    UIBarButtonItem *rollItem = [[UIBarButtonItem alloc] initWithTitle:@"🎲" style:UIBarButtonItemStylePlain target:self action:@selector(rollButtonTapped)];

    UIBarButtonItem *resetItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(resetButtonTapped)];
    self.navigationItem.leftBarButtonItems = @[
                                               rollItem,
                                               resetItem,
                                               ];

    UIBarButtonItem *settingsItem = [[UIBarButtonItem alloc] initWithTitle:@"⚙️" style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonTapped)];
    self.navigationItem.rightBarButtonItem = settingsItem;

    [self resetTrackers];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    const CGRect bounds = self.view.bounds;
    const CGFloat width = CGRectGetWidth(bounds);
    const CGFloat halfHeight = CGRectGetHeight(bounds) / 2;

    // Top half of the screen, rotated a half-turn.
    self.topPlayerView.frame = CGRectMake(0, 0, width, halfHeight);
    self.topPlayerView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);

    // Bottom half of the screen.
    self.bottomPlayerView.frame = CGRectMake(0, CGRectGetMidY(bounds), width, halfHeight);
}

#pragma mark - ALPlayerViewDelegate

- (void)playerViewRollViewTapped:(ALPlayerView *)playerView
{
    [self.topPlayerView clearRoll];
    [self.bottomPlayerView clearRoll];
}

#pragma mark - Actions

- (void)rollButtonTapped
{
    /*
     The dice roll is "rigged" in that we don't keep rolling until someone wins;
     instead, we flip a coin to determine winner.

     Then we generate the winner's dice roll between 1 and 6 inclusive and roll
     a number for the loser that's below that.

     This avoids waiting for a potentially arbitrarily large number of dice
     rolls.
     */
    BOOL topPlayerWins = (arc4random_uniform(2) == 0);
    uint32_t winningDiceRoll = arc4random_uniform(5) + 1;
    uint32_t losingDiceRoll = arc4random_uniform(winningDiceRoll);

    // Assign the winner/loser and add 1 because we roll 0-indexed.
    NSUInteger topPlayerRoll = (NSUInteger)(topPlayerWins ? winningDiceRoll : losingDiceRoll) + 1;
    NSUInteger bottomPlayerRoll = (NSUInteger)(topPlayerWins ? losingDiceRoll : winningDiceRoll) + 1;

    [self.topPlayerView rollWithValue:topPlayerRoll isWinner:topPlayerWins];
    [self.bottomPlayerView rollWithValue:bottomPlayerRoll isWinner:!topPlayerWins];
}

- (void)resetButtonTapped
{
    [self resetTrackers];
}

- (void)settingsButtonTapped
{
    // TODO
}

#pragma mark - Private API

- (void)resetTrackers
{
    self.topPlayerView.lifeTotal = ALSettings.settings.startingLifeTotal;
    self.bottomPlayerView.lifeTotal = ALSettings.settings.startingLifeTotal;
}

@end

NS_ASSUME_NONNULL_END
