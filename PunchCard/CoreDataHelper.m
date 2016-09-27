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

+ (CoreDataHelper *)sharedManager {
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
@end
