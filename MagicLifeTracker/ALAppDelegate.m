//
//  ALAppDelegate.m
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

#import "ALAppDelegate.h"
#import "ALViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ALAppDelegate
@synthesize window;

#pragma mark - UIApplicationDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    self.window = [[UIWindow alloc] init];
    self.window.tintColor = UIColor.whiteColor;

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[ALViewController alloc] init]];
    navigationController.navigationBar.translucent = NO;
    navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.25 alpha:1];
    navigationController.navigationBar.titleTextAttributes = @{
                                                               NSForegroundColorAttributeName: (UIColor *)self.window.tintColor,
                                                               };
    navigationController.navigationBar.barStyle = UIBarStyleBlack;

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

@end

NS_ASSUME_NONNULL_END
