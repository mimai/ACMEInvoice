//
//  SSInvoiceDetailViewController.h
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-09.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSInvoiceDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
