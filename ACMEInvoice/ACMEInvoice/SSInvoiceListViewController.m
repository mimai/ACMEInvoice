//
//  SSInvoiceListViewController.m
//  ACMEInvoice
//
//  Created by Michael Imai on 2013-02-09.
//  Copyright (c) 2013 Michael Imai. All rights reserved.
//

#import "SSInvoiceListViewController.h"

#import "APSplitViewController.h"

#import "SSInvoiceManager.h"

#import "SSMasterHistoryViewController.h"
#import "SSInvoiceDetailViewController.h"

@interface SSInvoiceListViewController ()

@property (strong, nonatomic) SSInvoiceManager *invoiceManager;
@property (strong, nonatomic) APSplitViewController *split;

@end

@implementation SSInvoiceListViewController


- (id)initWithSplit:(APSplitViewController*)split
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.split = split;
        
        // init detail
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
         self.detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"invoiceDetailView"];
        _detailViewController.title = NSLocalizedString(@"Detail", nil);
        [_split pushToDetailController:self.detailViewController];
        self.invoiceManager = [SSInvoiceManager sharedInvoiceManager];
    }
    return self;
}

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.backgroundColor = [UIColor colorWithRed:0.6667f green:0.8549f blue:1.0f alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _invoiceManager.history.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Invoice *object = _invoiceManager.history[indexPath.row];
    cell.textLabel.text = object.description;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailViewController.detailItem = _invoiceManager.history[indexPath.row];
}

@end