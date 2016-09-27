//
//  Customer+CoreDataProperties.h
//  PunchCard
//
//  Created by Travis Wade on 9/27/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "Customer+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Customer (CoreDataProperties)

+ (NSFetchRequest<Customer *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nonatomic) int64_t punchCount;

@end

NS_ASSUME_NONNULL_END
