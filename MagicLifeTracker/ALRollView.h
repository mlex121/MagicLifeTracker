//  
//  ALRollView.h
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

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@class ALRollView;

@protocol ALRollViewDelegate <NSObject>

@optional

- (void)rollViewTapped:(ALRollView *)rollView;

@end

@interface ALRollView : UIView

@property (nonatomic) NSUInteger value;
@property (nonatomic, getter=isWinner) BOOL winner;
@property (nonatomic, nullable, weak) id<ALRollViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
