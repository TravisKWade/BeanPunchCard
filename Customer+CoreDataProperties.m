//
//  Customer+CoreDataProperties.m
//  PunchCard
//
//  Created by Travis Wade on 9/27/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "Customer+CoreDataProperties.h"

@implementation Customer (CoreDataProperties)

+ (NSFetchRequest<Customer *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Customer"];
}

@dynamic firstName;
@dynamic lastName;
@dynamic punchCount;

@end
