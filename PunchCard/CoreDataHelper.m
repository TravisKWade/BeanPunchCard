//
//  CoreDataHelper.m
//  PunchCard
//
//  Created by Travis Wade on 9/22/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "CoreDataHelper.h"
#import "AppDelegate.h"
#import "Customer+CoreDataClass.h"

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

#pragma mark - Get Methods

- (NSArray *) getAllCustomers {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    [fetchRequest setSortDescriptors:@[sort]];
    
    NSError *error;
    NSArray *customers = [self.context executeFetchRequest:fetchRequest error:&error];
    
    return customers;
}

@end
