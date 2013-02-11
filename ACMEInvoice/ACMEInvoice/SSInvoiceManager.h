//
//  SSInvoiceManager.h
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-10.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Invoice.h"

@interface SSInvoiceManager : NSObject

@property (readonly, nonatomic) Invoice *currentInvoice;
@property (readonly, nonatomic) NSArray *history;

+ (id)sharedInvoiceManager;

- (Invoice*)createInvoice;

@end
