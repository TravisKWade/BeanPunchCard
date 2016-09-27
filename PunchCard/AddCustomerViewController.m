//
//  AddCustomerViewController.m
//  PunchCard
//
//  Created by Travis Wade on 9/21/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "AddCustomerViewController.h"
#import "CounterViewController.h"
#import "CoreDataHelper.h"

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
        
        [CoreDataHelper.sharedManager addCustomerWithFirstName:self.firstName.text andLastName:self.lastName.text withCompletion:^(BOOL success) {
            if (success) {
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.delegate customerAdded];
            } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Saving Error"
                                                                                         message:@"There was a problem saving the customers data"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                //We add buttons to the alert controller by creating UIAlertActions:
                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:nil]; //You can use a block here to handle a press on this button
                [alertController addAction:actionOk];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];

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
