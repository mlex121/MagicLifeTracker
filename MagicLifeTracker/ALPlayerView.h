//  
//  ALPlayerView.h
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

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@class ALPlayerView;
@class ALLifeTrackerView;
@class ALRollView;

@protocol ALPlayerViewDelegate <NSObject>

- (void)playerViewRollViewTapped:(ALPlayerView *)playerView;

@end

/**
 @brief This view represents a single player in the life tracker.

 It's meant to take up half the screen and is responsible for showing the life
 totals and the dice roll when appropriate.
 */
@interface ALPlayerView : UIView

@property (nonatomic, nullable, weak) id<ALPlayerViewDelegate> delegate;
@property (nonatomic) NSInteger lifeTotal;

- (void)rollWithValue:(NSUInteger)rollValue isWinner:(BOOL)isWinner;
- (void)clearRoll;

@end

NS_ASSUME_NONNULL_END
