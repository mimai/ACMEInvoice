//
//  SSPaymentViewController.h
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Invoice;

@interface SSPaymentViewController : UIViewController
<
UITextFieldDelegate
>

@property (strong, nonatomic) Invoice *invoice;

@end
