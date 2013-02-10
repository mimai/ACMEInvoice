//
//  SSInvoiceListViewController.h
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-09.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSInvoiceDetailViewController;

@interface SSInvoiceListViewController : UITableViewController

@property (strong, nonatomic) SSInvoiceDetailViewController *detailViewController;

@end
