//
//  Apr26AppDelegate.h
//  Apr26
//
//  Created by Daniel Walsh on 4/22/12.
//  Copyright (c) 2012 Walsh walsh Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class View;

@interface Apr26AppDelegate : UIResponder <UIApplicationDelegate> {
    View *view;
	UIWindow *_window;
}

@property (strong, nonatomic) UIWindow *window;

@end
