//
//  PunchButton.m
//  PunchCard
//
//  Created by Travis Wade on 10/5/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "PunchButton.h"

@implementation PunchButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.clipsToBounds = YES;
}

#pragma mark - setter helpers

- (void) setPunch {
    if (self.punched) {
        self.punched = NO;
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setImage:[UIImage imageNamed:@"bean.jpg"] forState:UIControlStateNormal];
        
        [self setAlpha:1];
    } else {
        self.punched = YES;
        
        [self setImage:[UIImage imageNamed:@"cup.png"] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor blackColor]];
        [self setAlpha:.7];
    }
}

@end
