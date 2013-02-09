//
//  Invoice.h
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Invoice : NSObject

@property (strong, nonatomic) NSString *customerName;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSNumber *amount;
@property (readonly, nonatomic) NSNumber *taxAmount;
@property (readonly, nonatomic) NSNumber *totalAmount;

//- (id)initWithName:(NSString*)customerName serviceDescription:(NSString*)description amount:(NSNumber*)amount;
- (void)calculateTax:(NSNumber*)taxRate;

@end
