//
//  SSInvoiceViewController.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "SSNewInvoiceViewController.h"

#import "SSAppDelegate.h"

#import "Invoice.h"

@interface SSNewInvoiceViewController ()
@property (strong, nonatomic) Invoice *currentInvoice;

@property (weak, nonatomic) IBOutlet UILabel *businessNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLine1Label;
@property (weak, nonatomic) IBOutlet UILabel *addressLine2Label;
@property (weak, nonatomic) IBOutlet UILabel *addressLine3Label;

@property (weak, nonatomic) IBOutlet UITextField *clientNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *taxAmoutTextField;
@property (weak, nonatomic) IBOutlet UITextField *invoiceAmountTextField;

@property (weak, nonatomic) IBOutlet UIButton *proceedToPaymentButton;

- (IBAction)proceedToPaymentButtonPress:(id)sender;

@end

@implementation SSNewInvoiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.currentInvoice = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SSAppDelegate *appDelegate = [SSAppDelegate delegate];
    self.businessNameLabel.text = appDelegate.businessName;
    self.addressLine1Label.text = appDelegate.addressLine1;
    self.addressLine2Label.text = appDelegate.addressLine2;
    self.addressLine3Label.text = appDelegate.addressLine3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button actions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([segue.destinationViewController respondsToSelector:@selector(setInvoice:)]) {
        [segue.destinationViewController performSelector:@selector(setInvoice:)
                                              withObject:_currentInvoice];
    } 
}

- (IBAction)proceedToPaymentButtonPress:(id)sender
{
    SSAppDelegate *appDelegate = [SSAppDelegate delegate];
    appDelegate.currentInvoice = _currentInvoice;
    
    [self performSegueWithIdentifier:@"ProceedToPayment" sender:sender];
}

#pragma mark - text field delegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    SSAppDelegate *appDelegate = [SSAppDelegate delegate];

    if (nil == _currentInvoice) {
        self.currentInvoice = [appDelegate createInvoice];
    }
    
    if (_descriptionTextField == textField) {
        // TODO: need to check if description is non-trivial, eg., "  "
        _currentInvoice.description = _descriptionTextField.text;
    } else if (_clientNameTextField == textField) {
        // TODO: need to check if client name is non-trivial, eg., "  "
        _currentInvoice.customerName = _clientNameTextField.text;
    } else if (_amountTextField == textField) {
        if (_amountTextField.text.length) {
            NSNumber *amount = [NSNumber numberWithDouble:[textField.text doubleValue]];
            _currentInvoice.amount = amount;
            
            [_currentInvoice calculateTax:appDelegate.taxRate];
            
            // update display fields
            NSString *formattedAmount = [NSString stringWithFormat:@"$%.2f", amount.doubleValue];
            _amountTextField.text = formattedAmount;
            NSString *formattedTaxAmount = [NSString stringWithFormat:@"$%.2f", _currentInvoice.taxAmount.doubleValue];
            _taxAmoutTextField.text = formattedTaxAmount;
            NSString *formattedTotalAmount = [NSString stringWithFormat:@"$%.2f", _currentInvoice.totalAmount.doubleValue];
            _invoiceAmountTextField.text = formattedTotalAmount;
        }
    }
    
    // check if client name, description and amount have been entered
    if (   (_descriptionTextField.text.length)
        && (_amountTextField.text.length)
        && (_clientNameTextField.text.length)) {
        // yes...enable proceed button
        _proceedToPaymentButton.enabled = YES;
    }
}

@end
