//
//  CoreDataHelper.h
//  PunchCard
//
//  Created by Travis Wade on 9/22/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

@property (strong, nonatomic) NSManagedObjectContext *context;

+(CoreDataHelper *) sharedManager;

@end
