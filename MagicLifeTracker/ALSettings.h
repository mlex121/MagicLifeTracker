//  
//  ALSettings.h
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

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/**
 @brief An abstraction over the life tracker's settings.

 This stores values such as the starting life total for each player, internally
 using NSUserDefaults.
 */
@interface ALSettings : NSObject

/**
 @brief The shared settings object.

 Use this when you want access to individual settings; the initializers are
 intentionally made unavailable.
 */
@property (class, nonatomic, readonly, nonnull) ALSettings *settings;

/**
 @brief The starting life total for each player.
 */
@property (nonatomic) NSInteger startingLifeTotal;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
