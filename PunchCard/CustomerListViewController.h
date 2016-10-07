//
//  ViewController.h
//  PunchCard
//
//  Created by Travis Wade on 8/30/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCustomerViewController.h"

@interface CustomerListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, AddCustomerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) NSDictionary *customerList;
@property (strong, nonatomic) NSArray *customerSectionsList;

@end

