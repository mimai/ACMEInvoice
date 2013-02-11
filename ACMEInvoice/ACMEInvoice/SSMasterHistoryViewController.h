//
//  SSInvoiceDetailViewController.h
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-09.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "APSplitViewController.h"

@class SSInvoiceListViewController;

@interface SSMasterHistoryViewController : APSplitViewController

@property (nonatomic, readonly) SSInvoiceListViewController *masterViewController;

@end
