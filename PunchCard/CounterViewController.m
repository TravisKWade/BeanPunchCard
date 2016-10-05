//
//  CounterViewController.m
//  PunchCard
//
//  Created by Travis Wade on 8/30/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "CounterViewController.h"

@interface CounterViewController ()

@end

@implementation CounterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (self.currentCustomer) {
        self.customerNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.currentCustomer.firstName, self.currentCustomer.lastName];
        
        [self setPunchedButtons];
        [self updateEnabledButtons];
        
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
    
    [button setPunch];
}

- (void) setPunchedButtons {
    
    for (int i = 1; i < 10; i++) {
        

        
    }
}

- (void) updateEnabledButtons {
    
}

@end
