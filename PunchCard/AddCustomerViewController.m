//
//  AddCustomerViewController.m
//  PunchCard
//
//  Created by Travis Wade on 9/21/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "AddCustomerViewController.h"
#import "CounterViewController.h"

@interface AddCustomerViewController ()

@end

@implementation AddCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.errorLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button handler

- (IBAction) addCustomerButtonPressed: (id)sender {
    if (self.firstName.text.length > 0) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        self.errorLabel.hidden = NO;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
