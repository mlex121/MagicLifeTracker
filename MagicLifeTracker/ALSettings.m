//  
//  ALSettings.m
//  MagicLifeTracker
//  
//  Created by Alexander Lim on 11/11/17.
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

#import "ALSettings.h"
#import "ALMacros.h"
#import "NSUserDefaults+Convenience.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - NSUserDefaults keys

static NSString * const ALSettingsStartingLifeTotalKey = @"ALSettingsStartingLifeTotalKey";

static NSString * const ALSettingsTopPlayerLifeTotalKey = @"ALSettingsTopPlayerLifeTotalKey";
static NSString * const ALSettingsBottomPlayerLifeTotalKey = @"ALSettingsBottomPlayerLifeTotalKey";

#pragma mark - ALSettings

@interface ALSettings ()

@property (nonatomic, readonly) NSUserDefaults *userDefaults;

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults NS_DESIGNATED_INITIALIZER;

@end

@implementation ALSettings

#pragma mark - Initializers

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults
{
    self = [super init];

    if (self)
    {
        _userDefaults = userDefaults;
    }

    return self;
}

- (instancetype)init AL_UNRECOGNIZED_SELECTOR
+ (instancetype)new AL_UNRECOGNIZED_SELECTOR

#pragma mark - Public API

+ (ALSettings *)settings
{
    static ALSettings *settings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[self alloc] initWithUserDefaults:NSUserDefaults.standardUserDefaults];
        ALAssertNonnull(settings);
    });
    return settings;
}

- (NSInteger)startingLifeTotal
{
    static const NSInteger defaultValue = 20;
    return [self.userDefaults integerForKey:ALSettingsStartingLifeTotalKey
                               defaultValue:defaultValue];
}

- (void)setStartingLifeTotal:(NSInteger)startingLifeTotal
{
    [self.userDefaults setInteger:startingLifeTotal
                           forKey:ALSettingsStartingLifeTotalKey];
    [self.userDefaults synchronize];
}

- (NSInteger)topPlayerLifeTotal
{
    return [self.userDefaults integerForKey:ALSettingsTopPlayerLifeTotalKey
                               defaultValue:self.startingLifeTotal];
}

- (void)setTopPlayerLifeTotal:(NSInteger)topPlayerLifeTotal
{
    [self.userDefaults setInteger:topPlayerLifeTotal
                           forKey:ALSettingsTopPlayerLifeTotalKey];
    [self.userDefaults synchronize];
}

- (NSInteger)bottomPlayerLifeTotal
{
    return [self.userDefaults integerForKey:ALSettingsBottomPlayerLifeTotalKey
                               defaultValue:self.startingLifeTotal];
}

- (void)setBottomPlayerLifeTotal:(NSInteger)bottomPlayerLifeTotal
{
    [self.userDefaults setInteger:bottomPlayerLifeTotal
                           forKey:ALSettingsBottomPlayerLifeTotalKey];
    [self.userDefaults synchronize];
}

@end

NS_ASSUME_NONNULL_END
