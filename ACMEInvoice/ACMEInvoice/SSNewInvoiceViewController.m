//
//  SSInvoiceViewController.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "SSNewInvoiceViewController.h"

#import "SSAppDelegate.h"
#import "SSInvoiceManager.h"

@interface SSNewInvoiceViewController ()
@property (strong, nonatomic) Invoice *currentInvoice;

@property (weak, nonatomic) IBOutlet UILabel *businessNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLine1Label;
@property (weak, nonatomic) IBOutlet UILabel *addressLine2Label;
@property (weak, nonatomic) IBOutlet UILabel *addressLine3Label;

@property (weak, nonatomic) IBOutlet UITextField *clientNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *invoiceNumber;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

// results from payfirma
@property (weak, nonatomic) IBOutlet UILabel *taxAmoutLabel;
@property (weak, nonatomic) IBOutlet UITextField *taxAmoutTextField;
@property (weak, nonatomic) IBOutlet UILabel *invoiceAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *invoiceAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *transactionIdLabel;
@property (weak, nonatomic) IBOutlet UITextField *transactionIdTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITextField *statusTextField;

@property (weak, nonatomic) IBOutlet UIButton *proceedToPaymentButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBarButtonItem;

@property (nonatomic) BOOL keyboardVisible;

- (IBAction)proceedToPaymentButtonPress:(id)sender;
- (IBAction)addButtonBarItemPress:(id)sender;

@end

@implementation SSNewInvoiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.keyboardVisible = NO;
    self.currentInvoice = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillShow:)
                                                 name: UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillHide:)
                                                 name: UIKeyboardWillHideNotification
                                               object:nil];

    SSAppDelegate *appDelegate = [SSAppDelegate delegate];
    self.businessNameLabel.text = appDelegate.businessName;
    self.addressLine1Label.text = appDelegate.addressLine1;
    self.addressLine2Label.text = appDelegate.addressLine2;
    self.addressLine3Label.text = appDelegate.addressLine3;
    
    SSInvoiceManager *invoiceManager = [SSInvoiceManager sharedInvoiceManager];
    
    if (nil == _currentInvoice) {
        self.currentInvoice = [invoiceManager createInvoice];
        [_currentInvoice addObserver:self
                          forKeyPath:@"transactionResult"
                             options:NSKeyValueObservingOptionNew
                             context:nil];
    }
    
    self.invoiceNumber.text = _currentInvoice.invoiceID;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button actions

- (IBAction)proceedToPaymentButtonPress:(id)sender
{
    _proceedToPaymentButton.hidden = YES;
    _cancelBarButtonItem.enabled = NO;
    
    [_currentInvoice submitForPayment];
}

- (IBAction)addButtonBarItemPress:(id)sender
{
    [_currentInvoice removeObserver:self forKeyPath:@"transactionResult"];
    
    SSInvoiceManager *invoiceManager = [SSInvoiceManager sharedInvoiceManager];
    self.currentInvoice = [invoiceManager createInvoice];
    [_currentInvoice addObserver:self
                      forKeyPath:@"transactionResult"
                         options:NSKeyValueObservingOptionNew
                         context:nil];

    self.invoiceNumber.text = _currentInvoice.invoiceID;

    // clear all entry fields
    _descriptionTextField.text = nil;
    _emailTextField.text = nil;
    _clientNameTextField.text = nil;
    _amountTextField.text = nil;

    _proceedToPaymentButton.hidden = NO;
    _addBarButtonItem.enabled = NO;
    _cancelBarButtonItem.enabled = YES;
    
    _taxAmoutLabel.hidden = YES;
    _taxAmoutTextField.hidden = YES;
    _taxAmoutTextField.text = nil;
    
    _invoiceAmountLabel.hidden = YES;
    _invoiceAmountTextField.hidden = YES;
    _invoiceAmountTextField.text = nil;
    
    _dateLabel.hidden = YES;
    _dateTextField.hidden = YES;
    _dateTextField.text = nil;
    
    _transactionIdLabel.hidden = YES;
    _transactionIdTextField.hidden = YES;
    _transactionIdTextField.text = nil;
    
    _statusLabel.hidden = YES;
    _statusTextField.hidden = YES;
    _statusTextField.text = nil;
}

- (IBAction)cancelButtonBarItemPress:(id)sender
{
    // clear all entry fields
    _descriptionTextField.text = nil;
    _emailTextField.text = nil;
    _clientNameTextField.text = nil;
    _amountTextField.text = nil;
}

#pragma mark - keyboard notification methods

-(void) keyboardWillShow:(NSNotification *)notif
{
    // If keyboard is visible, return
    if (!self.keyboardVisible)
    {
        CGRect myFrame = self.view.frame;
        myFrame.origin.y = -150.0f;
        [UIView animateWithDuration:0.5f
                         animations:^{
                             self.view.frame = myFrame;
                         }
         ];
        self.keyboardVisible = YES;
    }
}

-(void) keyboardWillHide:(NSNotification *)notif
{
    // If keyboard is visible, return
    if (self.keyboardVisible)
    {
        CGRect myFrame = self.view.frame;
        myFrame.origin.y = 0.0f;
        [UIView animateWithDuration:0.25f
                         animations:^{
                             self.view.frame = myFrame;
                         }
         ];
        self.keyboardVisible = NO;
    }
}

#pragma mark - text field delegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    SSInvoiceManager *invoiceManager = [SSInvoiceManager sharedInvoiceManager];

    if (nil == _currentInvoice) {
        self.currentInvoice = [invoiceManager createInvoice];
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

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"%s: %d keyPath=%@ change=%@", __FUNCTION__, __LINE__, keyPath, change);
    
    if (NSOrderedSame == [keyPath compare:@"transactionResult"]) {
        _proceedToPaymentButton.hidden = YES;
        _addBarButtonItem.enabled = YES;
        
        _taxAmoutLabel.hidden = NO;
        _taxAmoutTextField.hidden = NO;
        _taxAmoutTextField.text = _currentInvoice.taxAmount;
        
        _invoiceAmountLabel.hidden = NO;
        _invoiceAmountTextField.hidden = NO;
        _invoiceAmountTextField.text = _currentInvoice.totalAmount;
        
        _dateLabel.hidden = NO;
        _dateTextField.hidden = NO;
        _dateTextField.text = _currentInvoice.transactionDate;
        
        _transactionIdLabel.hidden = NO;
        _transactionIdTextField.hidden = NO;
        _transactionIdTextField.text = _currentInvoice.transactionID;
        
        _statusLabel.hidden = NO;
        _statusTextField.hidden = NO;
        _statusTextField.text = _currentInvoice.transactionResult;
    }
}

@end
