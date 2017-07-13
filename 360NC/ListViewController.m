//
//  ListViewController.m
//  360NC
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 02/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "ListViewController.h"



@interface ListViewController ()<UISearchResultsUpdating, UISearchControllerDelegate>

@property (strong, nonatomic) UISearchController *controller;
@property (strong, nonatomic) NSArray *results;
@end

@implementation ListViewController{
    
    NSArray *recipes;
    NSArray *searchResults;
    
    NSMutableArray *recipes1;
    
}
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
  
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationItem.title=@"NET CONNECT PVT LTD.";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
        dispatch_async( dispatch_get_main_queue(), ^{
           
            [self getPaymentList];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    
    
   
}

-(void)viewDidAppear:(BOOL)animated
{
    _tableView.dataSource=self;
    _tableView.delegate=self;
   
}
-(void)getPaymentList{
    
   
    
    NSArray *listArray = [[NSUserDefaults standardUserDefaults]
                        arrayForKey:@"listArray"];
    
    NSString *user=[listArray objectAtIndex:0];
    NSString *role=[listArray objectAtIndex:1];
    NSString *user_id=[listArray objectAtIndex:2];
    
    
    @try {
        
        NSDictionary *params = @{@"search_token":@"",
                                 @"user": user,
                                 @"user_id":user_id,
                                 @"role":role
                                 
                               
                                 };

        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:@"http://202.143.96.19:8080/NC360Android/emp_directory?" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            recipes = responseObject ;
            NSLog(@"_data===%@",recipes);
            
            [_tableView reloadData];
           
            recipes1= [[NSMutableArray alloc]init];
            
            for (int i=0;i<[recipes count];i++){
                NSString *tmpObject=[NSString stringWithFormat:@"%@",
                                    
                                     [[recipes objectAtIndex:i] objectForKey:@"Employee_Name"]];
                
                [recipes1 addObject:tmpObject];
                tmpObject=nil;
            }
            
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
            NSLog(@"Error: %@", myString);
        }];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    }
    @catch (NSException *exception) {
        
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [recipes count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text =[searchResults objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text =[[recipes objectAtIndex:indexPath.row] objectForKey:@"Employee_Name"];
        
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     DetailViewController * userDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
     userDetails.employeeID=[[recipes objectAtIndex:indexPath.row] objectForKey:@"EmpCode"];
    
    [self.navigationController pushViewController:userDetails animated:YES];
    
  
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [recipes1 filteredArrayUsingPredicate:resultPredicate];
}

#pragma mark - UISearchDisplayController delegate methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}


@end
