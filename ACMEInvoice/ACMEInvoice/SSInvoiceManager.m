//
//  SSInvoiceManager.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-10.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "SSInvoiceManager.h"

@interface SSInvoiceManager ()
@property (strong, nonatomic) Invoice *currentInvoice;
@property (strong, nonatomic) NSMutableArray *myHistory;
@end

@implementation SSInvoiceManager

+ (id)sharedInvoiceManager
{
    static dispatch_once_t onceQueue;
    static SSInvoiceManager *invoiceManager = nil;
    
    dispatch_once(&onceQueue, ^{ invoiceManager = [[self alloc] init]; });
    return invoiceManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.myHistory = [NSMutableArray arrayWithCapacity:5];
    }
    
    return self;
}

- (NSArray *)history
{
    return _myHistory;
}

#pragma mark -- invoice

- (Invoice*)createInvoice
{
    static int number = 1000;
    
    Invoice *newInvoice = [[Invoice alloc] init];
    newInvoice.invoiceID = [NSString stringWithFormat:@"%d", number];
    
    number++;
    
    self.currentInvoice = newInvoice;
    
    [_myHistory addObject:newInvoice];
    
    return newInvoice;
}

@end
