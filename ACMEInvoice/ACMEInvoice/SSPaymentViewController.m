//
//  SSPaymentViewController.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "SSPaymentViewController.h"

#import "SSAppDelegate.h"

#import "Invoice.h"
#import "CardPayment.h"

@interface SSPaymentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *expiryDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (strong, nonatomic) CardPayment *cardPayment;

- (IBAction)cancelButtonPress:(id)sender;
- (IBAction)submitButtonPress:(id)sender;

@end

@implementation SSPaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *formatedAmount = [NSString stringWithFormat:@"$%.2f", _invoice.totalAmount.doubleValue];
    _amountTextField.text = formatedAmount;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action methods

- (IBAction)cancelButtonPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitButtonPress:(id)sender {
    _cancelButton.enabled = NO;
}

#pragma mark - text field delegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    SSAppDelegate *appDelegate = [SSAppDelegate delegate];
    
    if (nil == _cardPayment) {
        self.cardPayment = [appDelegate createCardPayment];
    }
    
    if (_cardNumberTextField == textField) {
        // TODO: need to check if description is non-trivial, eg., "  "
        _cardPayment.description = _cardNumberTextField.text;
    } else if (_expiryDateTextField == textField) {
        // TODO: need to check if client name is non-trivial, eg., "  "
//        _currentInvoice.customerName = _expiryDateTextField.text;
    } else if (_securityCodeTextField == textField) {
        if (_amountTextField.text.length) {
            NSNumber *amount = [NSNumber numberWithDouble:[textField.text doubleValue]];
//            _currentInvoice.amount = amount;
//            
//            [_currentInvoice calculateTax:appDelegate.taxRate];
//            
//            // update display fields
//            NSString *formattedAmount = [NSString stringWithFormat:@"$%.2f", amount.doubleValue];
//            _amountTextField.text = formattedAmount;
//            NSString *formattedTaxAmount = [NSString stringWithFormat:@"$%.2f", _currentInvoice.taxAmount.doubleValue];
//            _taxAmoutTextField.text = formattedTaxAmount;
//            NSString *formattedTotalAmount = [NSString stringWithFormat:@"$%.2f", _currentInvoice.totalAmount.doubleValue];
//            _invoiceAmountTextField.text = formattedTotalAmount;
        }
    }
}

@end
