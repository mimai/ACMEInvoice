//
//  CardPayment.h
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardPayment : NSObject

@property (strong, nonatomic) NSString *refundTransactionID;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSNumber *amount;
@property (strong, nonatomic) NSString *email;
@property (nonatomic) BOOL autoReturn;

@property (strong, nonatomic) NSString *appName;

- (void)submitForPayment;
- (void)submitForAutorization;
- (void)submitForRefund;

@end
