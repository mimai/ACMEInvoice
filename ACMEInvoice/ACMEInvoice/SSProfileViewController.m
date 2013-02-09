//
//  SSProfileViewController.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "SSProfileViewController.h"

#import "SSAppDelegate.h"

@interface SSProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextField *businessNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressLine1TextField;
@property (weak, nonatomic) IBOutlet UITextField *addressLine2TextField;
@property (weak, nonatomic) IBOutlet UITextField *addressLine3TextField;
@property (weak, nonatomic) IBOutlet UITextField *taxRateTextField;

@end

@implementation SSProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SSAppDelegate *appDelegate = [SSAppDelegate delegate];
    _businessNameTextField.text = appDelegate.businessName;
    _addressLine1TextField.text = appDelegate.addressLine1;
    _addressLine2TextField.text = appDelegate.addressLine2;
    _addressLine3TextField.text = appDelegate.addressLine3;
    
    NSString *taxRate = [NSString stringWithFormat:@"%.1f", appDelegate.taxRate.doubleValue];
    _taxRateTextField.text = taxRate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - text field delegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    SSAppDelegate *appDelegate = [SSAppDelegate delegate];

    if (_businessNameTextField == textField) {
        // TODO: need to check if name is non-trivial, eg., "  "
        appDelegate.businessName = _businessNameTextField.text;
    } else if (_addressLine1TextField == textField) {
        // TODO: need to validate if address is non-trivial, eg., "  "
        appDelegate.addressLine1 = _addressLine1TextField.text;
    } else if (_addressLine2TextField == textField) {
        // TODO: need to validate if address is non-trivial, eg., "  "
        appDelegate.addressLine2 = _addressLine2TextField.text;
    } else if (_addressLine3TextField == textField) {
        // TODO: need to validate if address is non-trivial, eg., "  "
        appDelegate.addressLine3 = _addressLine3TextField.text;
    } else if (_taxRateTextField == textField) {
        if (_taxRateTextField.text.length) {
            
            NSNumber *taxRate = [NSNumber numberWithDouble:[textField.text doubleValue]];
            appDelegate.taxRate = taxRate;
        }
    }
}

@end
