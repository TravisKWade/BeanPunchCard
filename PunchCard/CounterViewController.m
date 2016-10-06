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
    }
}

- (void) setPunchedButtons {
    
    for (int i = 1; i <= 10; i++) {
        PunchButton *button = [self.view viewWithTag:i];
        
        if (i <= self.currentCustomer.punchCount) {
            [button setPunch];
        }
    }
}


- (BOOL) isSelectableButton:(PunchButton *) sender {
    if (sender.tag == self.currentCustomer.punchCount || sender.tag == self.currentCustomer.punchCount + 1) {
        return YES;
    } else {
        return NO;
    }
}

- (void) checkForButtonReset {
    if (self.currentCustomer.punchCount == 10) {
        [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(resetButtons:) userInfo:nil repeats:NO];
    }
}

- (void) resetButtons:(NSTimer *) timer {
    for (int i = 1; i <= 10; i++) {
        PunchButton *button = [self.view viewWithTag:i];
        [button setPunch];
    }
}

@end
