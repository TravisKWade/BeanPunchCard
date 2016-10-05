//
//  CounterViewController.h
//  PunchCard
//
//  Created by Travis Wade on 8/30/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer+CoreDataClass.h"

@interface CounterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *overlayView;
@property (strong, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UIButton *punchButton1;
@property (strong, nonatomic) IBOutlet UIButton *punchButton2;
@property (strong, nonatomic) IBOutlet UIButton *punchButton3;
@property (strong, nonatomic) IBOutlet UIButton *punchButton4;
@property (strong, nonatomic) IBOutlet UIButton *punchButton5;
@property (strong, nonatomic) IBOutlet UIButton *punchButton6;
@property (strong, nonatomic) IBOutlet UIButton *punchButton7;
@property (strong, nonatomic) IBOutlet UIButton *punchButton8;
@property (strong, nonatomic) IBOutlet UIButton *punchButton9;
@property (strong, nonatomic) IBOutlet UIButton *punchButton10;


@property (strong, nonatomic) Customer* currentCustomer;

@end
