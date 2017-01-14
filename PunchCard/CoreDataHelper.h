//
//  CoreDataHelper.h
//  PunchCard
//
//  Created by Travis Wade on 9/22/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Customer+CoreDataClass.h"

@interface CoreDataHelper : NSObject

@property (strong, nonatomic) NSManagedObjectContext *context;

+ (CoreDataHelper *) sharedManager;

- (void) addCustomerWithFirstName:(NSString *) firstName andLastName:(NSString *) lastName withCompletion: (void (^)(BOOL success))completion;
- (void) updateCustomerWithFirstName:(NSString *) firstName andLastName:(NSString *) lastName forCustomer:(Customer *) customer withCompletion: (void (^)(BOOL success))completion;
- (NSDictionary *) getAllCustomers;

- (void) punchCountChanged:(BOOL) punchAdded forCustomer:(Customer *) customer;
- (void) deleteCustom:(Customer *) customer;

@end
