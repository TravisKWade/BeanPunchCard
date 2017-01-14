//
//  CoreDataHelper.m
//  PunchCard
//
//  Created by Travis Wade on 9/22/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "CoreDataHelper.h"
#import "AppDelegate.h"


@implementation CoreDataHelper

static CoreDataHelper *coreDataHelper;

+ (CoreDataHelper *) sharedManager {
    if (!coreDataHelper) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            coreDataHelper = [[CoreDataHelper alloc] init];
        });
    }
    
    return coreDataHelper;
}

- (id)init {
    if (self = [super init]) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        self.context = delegate.managedObjectContext;
    }
    return self;
}

#pragma mark - Add Methods

- (void) addCustomerWithFirstName:(NSString *) firstName andLastName:(NSString *) lastName withCompletion: (void (^)(BOOL success))completion {
    if(firstName.length > 0) {
        if (coreDataHelper.context) {
            Customer *customer = [NSEntityDescription insertNewObjectForEntityForName:@"Customer" inManagedObjectContext:self.context];
            customer.firstName = firstName;
            customer.lastName = lastName;
            customer.punchCount = 0;
            
            NSError *error;
            [coreDataHelper.context save:&error];
            
            if (!error) {
                completion(YES);
            } else {
                completion(NO);
            }
        }
    } else {
        completion(NO);
    }
}

#pragma mark - Update Methods

- (void) updateCustomerWithFirstName:(NSString *) firstName andLastName:(NSString *) lastName forCustomer:(Customer *) customer withCompletion: (void (^)(BOOL success))completion {
    if(firstName.length > 0) {
        if (coreDataHelper.context) {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:self.context];
            [fetchRequest setEntity:entity];
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"firstName = %@ AND lastName = %@", customer.firstName, customer.lastName]];
            
            NSError *error;
            NSArray *fetchedCustomers = [self.context executeFetchRequest:fetchRequest error:&error];
            
            if (fetchedCustomers.count > 0) {
                Customer *savedCustomer = [fetchedCustomers objectAtIndex:0];
                
                savedCustomer.firstName = firstName;
                savedCustomer.lastName = lastName;

                [self.context save:&error];
                
                if (!error) {
                    completion(YES);
                } else {
                    completion(NO);
                }
            } else {
                completion(NO);
            }
        }
    } else {
        completion(NO);
    }
}

#pragma mark - Get Methods

- (NSDictionary *) getAllCustomers {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSSortDescriptor *secondSort = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSArray *sortDescriptors = @[sorter, secondSort];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSArray *customers = [self.context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableDictionary *groupedCustomers = [[NSMutableDictionary alloc] init];
    NSMutableArray *currentLetterCustomers = [[NSMutableArray alloc] init];
    NSString *customerLetter;
    
    for (int i = 0; i < customers.count; i++) {
        Customer *customer = [customers objectAtIndex:i];
        
        NSString *currentLetter = [[customer.firstName substringToIndex:1] uppercaseString];
        
        if (!customerLetter) {
            customerLetter = currentLetter;
        }
        
        if ([customerLetter isEqualToString:currentLetter]) {
            [currentLetterCustomers addObject:customer];
        } else {
            [groupedCustomers setObject:[[NSMutableArray alloc] initWithArray:currentLetterCustomers] forKey:customerLetter];
            
            [currentLetterCustomers removeAllObjects];
            customerLetter = currentLetter;
            [currentLetterCustomers addObject:customer];
        }
        
    }
    
    // make sure to add the last customers
    if (customerLetter) {
        [groupedCustomers setObject:[[NSMutableArray alloc] initWithArray:currentLetterCustomers] forKey:customerLetter];
    }
    
    return groupedCustomers;
}

#pragma mark - Put Methods

- (void) punchCountChanged:(BOOL) punchAdded forCustomer:(Customer *) customer {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"firstName = %@ AND lastName = %@", customer.firstName, customer.lastName]];
    
    NSError *error;
    NSArray *fetchedCustomers = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedCustomers.count > 0) {
        Customer *savedCustomer = [fetchedCustomers objectAtIndex:0];
        
        if (punchAdded) {
            savedCustomer.punchCount++;
        } else {
            savedCustomer.punchCount--;
        }
        
        [self.context save:&error];
    }
    
}

#pragma mark - Delete

- (void) deleteCustom:(Customer *) customer {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"firstName = %@ AND lastName = %@", customer.firstName, customer.lastName]];
    
    NSError *error;
    NSArray *fetchedCustomers = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedCustomers.count > 0) {
        Customer *savedCustomer = [fetchedCustomers objectAtIndex:0];
        [self.context deleteObject:savedCustomer];
        [self.context save:&error];
    }
}

@end
