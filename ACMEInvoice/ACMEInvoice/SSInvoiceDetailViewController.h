//
//  SSInvoiceDetailViewController.h
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-11.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Invoice;

@interface SSInvoiceDetailViewController : UIViewController

@property (strong, nonatomic) Invoice *detailItem;

@end
