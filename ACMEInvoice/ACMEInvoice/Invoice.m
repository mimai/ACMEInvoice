//
//  Invoice.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "Invoice.h"

@interface Invoice ()
@property (strong, nonatomic) NSNumber *taxAmount;
@property (strong, nonatomic) NSNumber *totalAmount;
@end

@implementation Invoice

//- (id)initWithName:(NSString*)customerName serviceDescription:(NSString*)description amount:(NSNumber*)amount
//{
//    self = [super init];
//    if (self) {
//        self.customerName = customerName;
//        self.description = description;
//        self.amount = amount;
//        self.taxAmount = [NSNumber numberWithDouble:0.0f];
//        self.totalAmount = amount;
//    }
//    
//    return self;
//}
//
- (void)calculateTax:(NSNumber*)taxRate
{
    double taxAmount = _amount.doubleValue * taxRate.doubleValue / 100.0f;
    self.taxAmount = [NSNumber numberWithDouble:taxAmount];
    
    double totalAmount = _amount.doubleValue + taxAmount;
    self.totalAmount = [NSNumber numberWithDouble:totalAmount];
}

@end
