//
//  SSInvoiceDetailViewController.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-11.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "SSInvoiceDetailViewController.h"

#import "Invoice.h"

@interface SSInvoiceDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *clientNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *invoiceNumber;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

@property (weak, nonatomic) IBOutlet UITextField *taxAmoutTextField;
@property (weak, nonatomic) IBOutlet UITextField *invoiceAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *transactionIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *statusTextField;

- (void)configureView;
@end

@implementation SSInvoiceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
    
    // Update the view.
    [self configureView];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        _invoiceNumber.text = _detailItem.invoiceID;
        _clientNameTextField.text = _detailItem.customerName;
        _descriptionTextField.text = _detailItem.description;
        _emailTextField.text = _detailItem.email;
        _amountTextField.text = [NSString stringWithFormat:@"%.2f", _detailItem.amount.doubleValue];
        _invoiceAmountTextField.text = _detailItem.totalAmount;
        _taxAmoutTextField.text = _detailItem.taxAmount;
        _transactionIdTextField.text = _detailItem.transactionID;
        _dateTextField.text = _detailItem.transactionDate;
        _statusTextField.text = _detailItem.transactionResult;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
