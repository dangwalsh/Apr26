//
//  View.m
//  Apr26
//
//  Created by Daniel Walsh on 4/22/12.
//  Copyright (c) 2012 Walsh walsh Studio. All rights reserved.
//

#import "View.h"

@implementation View

@synthesize red;
@synthesize green;
@synthesize blue;
@synthesize o;

- (id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor whiteColor];
        
        initAlpha = 0.25;
        delay = 0.0;
        
		CGRect b = self.bounds;
		CGSize s = CGSizeMake(60, 40);	//size of buttons
        
        
        NSString *string = @"Double tap to clear the screen";
        UIFont *font = [UIFont italicSystemFontOfSize: 14.0];
        CGSize size = [string sizeWithFont: font];
        CGRect f = CGRectMake(
                              (self.bounds.size.width - size.width)/2, 
                              (self.bounds.size.height - size.height * 2), 
                              size.width, 
                              size.height
                              );
        
        label = [[UILabel alloc] initWithFrame: f];
        label.backgroundColor = [UIColor clearColor];
        label.alpha = initAlpha;
        label.font = font;
        label.text = string;
        
        [self addSubview:label];
        
        float margin = 5.0;
        
        blackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        blackButton.frame = CGRectMake(
                                       b.origin.x + (b.size.width-s.width) / 2 - 1.5 * s.width - 3 * margin,
                                       b.size.height - (b.size.height - s.height/2), 
                                       s.width, 
                                       s.height
                                       );
        [blackButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        [blackButton setTitle:@"Black" forState:UIControlStateNormal];
        
        [blackButton addTarget:self
                        action:@selector(makeBlack)
              forControlEvents:UIControlEventTouchDown
         ];
        
        [self addSubview: blackButton];
        
        redButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        redButton.frame = CGRectMake(
                                     b.origin.x + (b.size.width-s.width) / 2 - .5 * s.width - margin,
                                     b.size.height - (b.size.height - s.height/2), 
                                     s.width, 
                                     s.height
                                     );
        [redButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
        [redButton setTitle:@"Red" forState:UIControlStateNormal];
        [redButton addTarget:self
                      action:@selector(makeRed)
            forControlEvents:UIControlEventTouchDown
         ];
        
        [self addSubview: redButton];
        
        greenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        greenButton.frame = CGRectMake(
                                       b.origin.x + (b.size.width-s.width) / 2 + .5 * s.width + margin,
                                       b.size.height - (b.size.height - s.height/2), 
                                       s.width, 
                                       s.height
                                       );
        [greenButton setTitleColor: [UIColor greenColor] forState: UIControlStateNormal];
        [greenButton setTitle:@"Green" forState:UIControlStateNormal];
        
        [greenButton addTarget:self
                        action:@selector(makeGreen)
              forControlEvents:UIControlEventTouchDown
         ];
        
        [self addSubview: greenButton];
        
        blueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        blueButton.frame = CGRectMake(
                                      b.origin.x + (b.size.width-s.width) / 2 + 1.5 * s.width + 3 * margin,
                                      b.size.height - (b.size.height - s.height/2), 
                                      s.width, 
                                      s.height
                                      );
        [blueButton setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
        [blueButton setTitle:@"Blue" forState:UIControlStateNormal];
        
        [blueButton addTarget:self
                       action:@selector(makeBlue)
             forControlEvents:UIControlEventTouchDown
         ];
        
        [self addSubview: blueButton];
        
		path = CGPathCreateMutable();
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]
                                             initWithTarget: self action: @selector(handleDouble:)
                                             ];
        doubleTap.numberOfTapsRequired = 2;
        
        [self addGestureRecognizer: doubleTap];
        [self clearPath];
	}
	return self;
}

- (void) handleDouble: (UITapGestureRecognizer *) recognizer {
    [self performSelector: @selector(clearPath) withObject: nil afterDelay: delay];
}

- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
	CGPoint p = [[touches anyObject] locationInView: self];
	CGPathMoveToPoint(path, NULL, p.x, p.y);
    self.o = p;
    [UIView animateWithDuration: 0.4
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{label.alpha -= initAlpha;}
                     completion: NULL
     ]; 
}


- (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event {
	CGPoint p = [[touches anyObject] locationInView: self];
    CGRect r = CGRectMake(
                          p.x, 
                          p.y, 
                          [self calcDiff: p.x from: self.o.x], 
                          [self calcDiff: p.y from: self.o.y]
                          );
	CGPathAddLineToPoint(path, NULL, p.x, p.y);
    self.o = p;
	[self setNeedsDisplayInRect:r];	//Trigger a call to drawRect:.
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration: 0.4
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{label.alpha = initAlpha;}
                     completion: NULL
     ]; 
}

- (float) calcDiff: (float) c from: (float) d {
    
    float f;
    
    if (c - d != 0) {
        f = (-1 * (c - d));
    } else {
        f = -1.0;
    }
    
    return f;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void) drawRect: (CGRect) rect
{
	// Drawing code
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextBeginPath(c);
	CGContextAddPath(c, path);
	CGContextSetRGBStrokeColor(c, self.red, self.green, self.blue, 1);
	CGContextStrokePath(c);
}

- (void) clearPath{
    CGPathRelease(path);
	path = CGPathCreateMutable();
	[self setNeedsDisplay];
    label.alpha = initAlpha;
}

- (void) makeBlack {
    self.red = 0.0;
    self.green = 0.0;
    self.blue = 0.0;
}

- (void) makeRed {
    self.red = 1.0;
    self.green = 0.0;
    self.blue = 0.0;
}

- (void) makeGreen {
    self.red = 0.0;
    self.green = 1.0;
    self.blue = 0.0;
}

- (void) makeBlue {
    self.red = 0.0;
    self.green = 0.0;
    self.blue = 1.0;
}
@end
