//
//  CardPayment.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "CardPayment.h"

@interface CardPayment ()
-(void)runPayfirma:(NSString*)transactionType;
@end

@implementation CardPayment

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
    
    NSString *urlFormatString = @"payfirma://process?amount=%@&transaction_type=%@&description=%@&email=%@&orig_id=%@&sending_app=%@&auto_return=%@&return_url=temp://return";
    NSString *urlString = [NSString stringWithFormat:urlFormatString, amountTxt, transactionType, descriptionTxt, emailTxt, transactionID, _appName, returnType];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

@end
