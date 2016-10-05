//
//  CounterViewController.h
//  PunchCard
//
//  Created by Travis Wade on 8/30/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer+CoreDataClass.h"
#import "PunchButton.h"

@interface CounterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *overlayView;
@property (strong, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet PunchButton *punchButton1;
@property (strong, nonatomic) IBOutlet PunchButton *punchButton2;
@property (strong, nonatomic) IBOutlet PunchButton *punchButton3;
@property (strong, nonatomic) IBOutlet PunchButton *punchButton4;
@property (strong, nonatomic) IBOutlet PunchButton *punchButton5;
@property (strong, nonatomic) IBOutlet PunchButton *punchButton6;
@property (strong, nonatomic) IBOutlet PunchButton *punchButton7;
@property (strong, nonatomic) IBOutlet PunchButton *punchButton8;
@property (strong, nonatomic) IBOutlet PunchButton *punchButton9;
@property (strong, nonatomic) IBOutlet PunchButton *punchButton10;


@property (strong, nonatomic) Customer* currentCustomer;

@end
