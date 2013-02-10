//
//  Invoice.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "Invoice.h"

@interface Invoice ()
@property (strong, nonatomic) NSNumber *taxAmount;
@property (strong, nonatomic) NSNumber *totalAmount;
@property (strong, nonatomic) NSString *appName;

-(void)runPayfirma:(NSString*)transactionType;
@end

@implementation Invoice

- (id)init
{
    self = [super init];
    if (self) {
        self.appName = @"ACMEInvoice";
        self.refundTransactionID = @"";
        self.description = @"test";
        self.email = @"mimai@shaw.ca";
        self.amount = [NSNumber numberWithDouble:0.0f];
        self.taxAmount = [NSNumber numberWithDouble:0.0f];
        self.totalAmount = _amount;
        
        _autoReturn = YES;
    }
    
    return self;
}

- (void)submitForPayment
{
    [self runPayfirma:@"sale"];
}

- (void)submitForAutorization
{
    [self runPayfirma:@"auth"];
}

- (void)submitForRefund
{
    [self runPayfirma:@"refund"];
}

-(void)runPayfirma:(NSString*)transactionType
{
    NSString *descriptionTxt = [_description stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *transactionID = [_refundTransactionID stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *amountTxt = [[NSString stringWithFormat:@"%.2f", _amount.doubleValue] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *emailTxt = [_email stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSString *returnType = @"no";
    if (_autoReturn)
    {
        returnType = @"yes";
    }
    
    NSString *returnUrl = [NSString stringWithFormat:@"%@://return", _appName];
    NSString *urlFormatString = @"payfirma://process?amount=%@&transaction_type=%@&description=%@&email=%@&orig_id=%@&sending_app=%@&auto_return=%@&return_url=%@";
    NSString *urlString = [NSString stringWithFormat:urlFormatString, amountTxt, transactionType, descriptionTxt, emailTxt, transactionID, _appName, returnType, returnUrl];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

@end
