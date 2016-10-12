//
//  EditCustomerViewController.h
//  PunchCard
//
//  Created by Travis Wade on 10/12/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer+CoreDataClass.h"

@protocol UpdateCustomerDelegate <NSObject>
- (void) customerUpdated;
@end

@interface EditCustomerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *updateCustomerButton;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;

@property (nonatomic, weak) id<UpdateCustomerDelegate> delegate;
@property (strong, nonatomic) Customer *editCustomer;

@end
