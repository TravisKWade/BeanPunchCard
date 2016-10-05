//
//  ViewController.m
//  PunchCard
//
//  Created by Travis Wade on 8/30/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "CustomerListViewController.h"
#import "CoreDataHelper.h"
#import "Customer+CoreDataClass.h"
#import "CounterViewController.h"

@interface CustomerListViewController ()

@end

@implementation CustomerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customerList = [CoreDataHelper.sharedManager getAllCustomers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"counterSegue"]) {
         CounterViewController *counterVC = (CounterViewController *)segue.destinationViewController;
         NSIndexPath *indexPath = (NSIndexPath *) sender;
         counterVC.currentCustomer = [self.customerList objectAtIndex:indexPath.row];
     } else {
         AddCustomerViewController *addCustomerVC = (AddCustomerViewController *)segue.destinationViewController;
         addCustomerVC.delegate = self;
     }
 }

#pragma mark - add customer delegate

- (void) customerAdded {
    self.customerList = [CoreDataHelper.sharedManager getAllCustomers];
    [self.tableView reloadData];
}

#pragma mark - table view cells

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.customerList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    Customer *customer = [self.customerList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", customer.firstName, customer.lastName];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"counterSegue" sender:indexPath];
}


@end
