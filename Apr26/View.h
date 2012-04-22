//
//  View.h
//  Apr26
//
//  Created by Daniel Walsh on 4/22/12.
//  Copyright (c) 2012 Walsh walsh Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View : UIView {
    CGMutablePathRef path;
    UIButton *blackButton;
    UIButton *redButton;
    UIButton *greenButton;
    UIButton *blueButton;
    NSTimeInterval delay;
    UILabel *label;
    float initAlpha;
}

@property(nonatomic, assign) CGPoint o;
@property(nonatomic, assign) float red;
@property(nonatomic, assign) float blue;
@property(nonatomic, assign) float green;


- (void) clearPath;

@end
