//
//  AddCustomerViewController.h
//  PunchCard
//
//  Created by Travis Wade on 9/21/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddCustomerDelegate <NSObject>
- (void) customerAdded;
@end

@interface AddCustomerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *addCustomerButton;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;

@property (nonatomic, weak) id<AddCustomerDelegate> delegate;

@end
