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
#import "ALLifeTrackerView.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ALViewController

@interface ALViewController ()

@property (nonatomic, readonly) ALLifeTrackerView *topLifeTrackerView;
@property (nonatomic, readonly) ALLifeTrackerView *bottomLifeTrackerView;

@end

@implementation ALViewController

#pragma mark - Initializers

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];

    if (self) {
        self.title = @"Magic Life Tracker";

        _topLifeTrackerView = [[ALLifeTrackerView alloc] init];
        _bottomLifeTrackerView = [[ALLifeTrackerView alloc] init];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.topLifeTrackerView];
    [self.view addSubview:self.bottomLifeTrackerView];

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

    CGRect bounds = self.view.bounds;
    CGFloat width = CGRectGetWidth(bounds);
    CGFloat halfHeight = CGRectGetHeight(bounds) / 2;
    self.topLifeTrackerView.frame = CGRectMake(0, 0, width, halfHeight);
    self.topLifeTrackerView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
    self.bottomLifeTrackerView.frame = CGRectMake(0, CGRectGetMidY(bounds), width, halfHeight);
}

#pragma mark - Actions

- (void)rollButtonTapped
{
    // TODO
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
    static const NSInteger defaultLifeTotal = 20;
    self.topLifeTrackerView.lifeTotal = defaultLifeTotal;
    self.bottomLifeTrackerView.lifeTotal = defaultLifeTotal;
}

@end

NS_ASSUME_NONNULL_END
