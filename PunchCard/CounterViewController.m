//
//  CounterViewController.m
//  PunchCard
//
//  Created by Travis Wade on 8/30/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "CounterViewController.h"
#import "CoreDataHelper.h"

@interface CounterViewController ()

@end

@implementation CounterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (self.currentCustomer) {
        self.customerNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.currentCustomer.firstName, self.currentCustomer.lastName];
        
        [self setPunchedButtons];
        self.messageLabel.text = @"";
        
        self.overlayView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button helpers

- (IBAction) punchButtonPressed:(id) sender {
    PunchButton *button = (PunchButton *) sender;
    
    if ([self isSelectableButton:button]) {
        BOOL incremented = [button setPunch];
        [CoreDataHelper.sharedManager punchCountChanged:incremented forCustomer:self.currentCustomer];
        [self checkForButtonReset];
        [self updateMessageCount];
    }
}

- (void) setPunchedButtons {
    
    for (int i = 1; i <= 10; i++) {
        PunchButton *button = [self.view viewWithTag:i];
        
        if (i <= (self.currentCustomer.punchCount % 10)) {
            [button setPunch];
        }
    }
}


- (BOOL) isSelectableButton:(PunchButton *) sender {
    int mod = self.currentCustomer.punchCount % 10;
    
    mod = (mod == 0) ? 0 : mod;
    
    if (sender.tag == mod || sender.tag == mod + 1) {
        return YES;
    } else {
        return NO;
    }
}

- (void) checkForButtonReset {
    if ((self.currentCustomer.punchCount % 10) == 0) {
        [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(resetButtons:) userInfo:nil repeats:NO];
    }
}

- (void) resetButtons:(NSTimer *) timer {
    for (int i = 1; i <= 10; i++) {
        PunchButton *button = [self.view viewWithTag:i];
        [button setPunch];
    }
}

- (void) updateMessageCount {
    if (self.currentCustomer.punchCount > 0) {
        NSString *message;
        
        if (self.currentCustomer.punchCount == 1) {
            message = [NSString stringWithFormat:@"%@ has purchased 1 drink.", self.currentCustomer.firstName];
        } else {
            if (self.currentCustomer.punchCount > 20) {
                message = [NSString stringWithFormat:@"%@ has purchased %lli drinks.\nThat's %lli punch cards filled out!", self.currentCustomer.firstName, self.currentCustomer.punchCount, (self.currentCustomer.punchCount / 10)];
            } else {
                message = [NSString stringWithFormat:@"%@ has purchased %lli drinks.", self.currentCustomer.firstName, self.currentCustomer.punchCount];
            }
        }
        
        self.messageLabel.text = message;
    }
}

@end
