//
//  SSAppDelegate.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-08.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "SSAppDelegate.h"

#import "Invoice.h"
#import "CardPayment.h"

@implementation SSAppDelegate

+ (SSAppDelegate*) delegate {
    return (SSAppDelegate*)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.businessName = @"ACME Corporation";
    self.addressLine1 = @"100 Main Street";
    self.addressLine2 = @"Atown";
    self.addressLine3 = @"BC, A1B2C3";
    
    self.taxRate = [NSNumber numberWithDouble:12.0f];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -- invoice

- (Invoice*)createInvoice
{
    Invoice *newInvoice = [[Invoice alloc] init];
    
    return newInvoice;
}

- (CardPayment*)createCardPayment
{
    CardPayment *newCardPayment = [[CardPayment alloc] init];
    
    return newCardPayment;
}

#pragma mark -- Launching from URL

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url{
    
    NSString *temp = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapes( NULL, (__bridge CFStringRef)[url absoluteString], (__bridge CFStringRef)@"");
    NSArray *urlArray = [temp componentsSeparatedByString:@"?"];
    
    NSString *query = [urlArray objectAtIndex:1];
    NSArray *queryPairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *pairs = [NSMutableDictionary dictionary];
    for (NSString *queryPair in queryPairs) {
        NSArray *bits = [queryPair componentsSeparatedByString:@"="];
        if ([bits count] != 2) { continue; }
        
        NSString *key = [[bits objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *value = [[bits objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [pairs setObject:value forKey:key];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Data returned"
                                                    message:[NSString stringWithFormat:@"%@", pairs]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString*)sourceApplication
         annotation:(id)annotation{
    
    NSString *temp = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapes( NULL, (__bridge CFStringRef)[url absoluteString], (__bridge CFStringRef)@"");
    NSArray *urlArray = [temp componentsSeparatedByString:@"?"];
    
    NSString *query = [urlArray objectAtIndex:1];
    NSArray *queryPairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *pairs = [NSMutableDictionary dictionary];
    for (NSString *queryPair in queryPairs) {
        NSArray *bits = [queryPair componentsSeparatedByString:@"="];
        if ([bits count] != 2) { continue; }
        
        NSString *key = [[bits objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *value = [[bits objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [pairs setObject:value forKey:key];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Data returned"
                                                    message:[NSString stringWithFormat:@"%@", pairs]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    return YES;
}

@end
