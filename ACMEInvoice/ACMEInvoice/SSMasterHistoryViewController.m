//
//  SSMasterInvoiceDetailViewController.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-09.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "SSMasterHistoryViewController.h"

#import "SSInvoiceListViewController.h"

@interface SSMasterHistoryViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation SSMasterHistoryViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _masterViewController = [[SSInvoiceListViewController alloc] initWithSplit:self];
    self.masterViewController.title = NSLocalizedString(@"Invoices", nil);
    [self pushToMasterController:self.masterViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
