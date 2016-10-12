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
    self.customerSectionsList = [[self.customerList allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
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
         
         NSString *sectionTitle = [self.customerSectionsList objectAtIndex:indexPath.section];
         NSArray *customersInSection = [self.customerList objectForKey:sectionTitle];

         counterVC.currentCustomer = [customersInSection objectAtIndex:indexPath.row];
     } else if ([segue.identifier isEqualToString:@"updateSegue"]) {
         EditCustomerViewController *editVC = (EditCustomerViewController *)segue.destinationViewController;
         NSIndexPath *indexPath = (NSIndexPath *) sender;
         
         NSString *sectionTitle = [self.customerSectionsList objectAtIndex:indexPath.section];
         NSArray *customersInSection = [self.customerList objectForKey:sectionTitle];
         
         editVC.editCustomer = [customersInSection objectAtIndex:indexPath.row];
         editVC.delegate = self;
     } else {
         AddCustomerViewController *addCustomerVC = (AddCustomerViewController *)segue.destinationViewController;
         addCustomerVC.delegate = self;
     }
 }

#pragma mark -  customer delegates

- (void) customerAdded {
    self.customerList = [CoreDataHelper.sharedManager getAllCustomers];
    self.customerSectionsList = [[self.customerList allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.tableView reloadData];
}

- (void) customerUpdated {
    self.customerList = [CoreDataHelper.sharedManager getAllCustomers];
    self.customerSectionsList = [[self.customerList allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.tableView reloadData];
}

#pragma mark - table view cells

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.customerList.count;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = [self.customerSectionsList objectAtIndex:section];
    NSArray *customersInSection = [self.customerList objectForKey:sectionTitle];
    return customersInSection.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.customerSectionsList objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    NSString *sectionTitle = [self.customerSectionsList objectAtIndex:indexPath.section];
    NSArray *customersInSection = [self.customerList objectForKey:sectionTitle];
    
    Customer *customer = [customersInSection objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", customer.firstName, customer.lastName];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *newPath = indexPath;
    [self performSegueWithIdentifier:@"counterSegue" sender:newPath];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.customerSectionsList;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *editButton = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        [self performSegueWithIdentifier:@"updateSegue" sender:indexPath];
                                    }];
    editButton.backgroundColor = [UIColor colorWithRed:43/255 green:30/255 blue:20/255 alpha:1.0];
    
    return @[editButton];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
