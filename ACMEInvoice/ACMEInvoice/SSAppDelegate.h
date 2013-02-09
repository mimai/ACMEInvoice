//
//  SSAppDelegate.h
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Invoice;
@class CardPayment;

@interface SSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *businessName;
@property (strong, nonatomic) NSString *addressLine1;
@property (strong, nonatomic) NSString *addressLine2;
@property (strong, nonatomic) NSString *addressLine3;
@property (strong, nonatomic) NSNumber *taxRate;

@property (strong, nonatomic) Invoice *currentInvoice;
@property (strong, nonatomic) CardPayment *currentCardPayment;

+ (SSAppDelegate*)delegate;

- (Invoice*)createInvoice;
- (CardPayment*)createCardPayment;

@end
