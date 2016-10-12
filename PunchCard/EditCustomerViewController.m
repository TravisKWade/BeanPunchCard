//
//  EditCustomerViewController.m
//  PunchCard
//
//  Created by Travis Wade on 10/12/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "EditCustomerViewController.h"
#import "CoreDataHelper.h"

@interface EditCustomerViewController ()

@end

@implementation EditCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.errorLabel.hidden = YES;
    self.updateCustomerButton.layer.cornerRadius = 10;
    
    self.firstName.text = self.editCustomer.firstName;
    self.lastName.text = self.editCustomer.lastName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button handler

- (IBAction) updateCustomerButtonPressed: (id)sender {
    if (self.firstName.text.length > 0) {
        
        [CoreDataHelper.sharedManager updateCustomerWithFirstName:self.firstName.text andLastName:self.lastName.text forCustomer:self.editCustomer withCompletion:^(BOOL success) {
            if (success) {
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.delegate customerUpdated];
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

@end
