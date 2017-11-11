//  
//  ALMacros.h
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

#ifndef ALMacros_h
#define ALMacros_h

#define ALWeakSelf __weak __typeof__(self) _Nullable
#define ALStrongSelf __strong __typeof__(self) _Nullable

#define ALAssertNonnull(value__) \
    do { NSCAssert(value__ != nil, @"Expected '%@' to be nonnull", @#value__); } while (0)

#define AL_UNRECOGNIZED_SELECTOR { [self doesNotRecognizeSelector:_cmd]; abort(); }

#endif /* ALMacros_h */
