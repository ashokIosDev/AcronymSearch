//
//  ViewController.m
//  AcronymSearch
//
//  Created by Ashok on 7/29/17.
//  Copyright © 2017 Macys. All rights reserved.
//

#import "ViewController.h"
#import "SearchField.h"
#import "NetworkController.h"
#import "AcronymHelper.h"
#import "AcromineSearchResult.h"
#import "LongFormObject.h"
#import "DetailViewController.h"
@interface ViewController ()

@property (nonatomic, strong) IBOutlet SearchField *searchBox;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *longforms;

@end

@implementation ViewController

- (void)viewDidLoad {
    [NetworkController instance];
    [super viewDidLoad];
    NSTextAttachment*   placeholderImageTextAttachment = [[NSTextAttachment alloc] init];
    placeholderImageTextAttachment.image = [UIImage imageNamed:@"Search_Img"];
    
    // Use 'bound' to adjust position and size
    placeholderImageTextAttachment.bounds = CGRectMake(0, 0, 16, 16);
    NSMutableAttributedString*  placeholderImageString = [[NSAttributedString attributedStringWithAttachment:placeholderImageTextAttachment] mutableCopy];
    
    // Append the placeholder text
    NSMutableAttributedString*  placeholderString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"Search", nil)];
    [placeholderImageString appendAttributedString:placeholderString];
    
    // set as (attributed) placeholder
    self.searchBox.searchTxtFld.attributedPlaceholder = placeholderImageString;
   
    self.searchBox.searchTxtFld.returnKeyType = UIReturnKeySearch;
    self.searchBox.searchTxtFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchBox.searchTxtFld.delegate = self;
   
    __weak SearchField *weaksb = self.searchBox;
    weaksb.btnActionBlock = ^{
        if (!weaksb.searchTxtFld.text || [weaksb.searchTxtFld.text isEqualToString:@""])
            [AcronymHelper showOKAlertWithTitle:@"Error" message:@"Please enter an acronym."];
        else
            [self searchAcronym:weaksb.searchTxtFld.text];
    };


    
}

- (void)searchAcronym:(NSString *)searchTerm {
    
    __weak ViewController *weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetworkController getAcronym:searchTerm
                       success:^(NSURLSessionDataTask *task, id response) {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               //response is always a single item array so we get the first element
                               if(((NSArray*)response).count > 0) {
                                   AcromineSearchResult *searchResult = [[AcromineSearchResult alloc] initWithDictionary:response[0]];
                                   weakSelf.longforms = [searchResult.results mutableCopy];
                                   [weakSelf.tableView reloadData];
                               } else {
                                   [AcronymHelper showOKAlertWithTitle:@"Error" message:@"Acronym not found."];
                               }
                           });
                       }
                       failure:^(NSURLSessionDataTask *task, NSError *error) {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               [AcronymHelper showOKAlertWithError:error];
                           });
                       }
     ];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LongFormObject *longform = [self.longforms objectAtIndex:indexPath.row];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.longform = longform;
        destViewController.shortform =  self.searchBox.searchTxtFld.text;
    }
}

#pragma mark - Text Field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    [self.searchBox.btnActionBlock invoke];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.longforms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defcell" forIndexPath:indexPath];
    //cell.label.text = self.longforms[indexPath.row][@"lf"];
    cell.textLabel.text = [(LongFormObject *)[self.longforms objectAtIndex:indexPath.row] longform];
    return cell;
   // return
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // [self prepareForSegue: sender:nil];
    [self performSegueWithIdentifier:@"showDetail" sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
