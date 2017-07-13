//
//  TimesheetViewController.m
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 21/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "TimesheetViewController.h"
#import "CreateTimeSheetViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "TimesheetTableViewCell.h"

@interface TimesheetViewController ()

@end

@implementation TimesheetViewController{
    
    
    NSString *custID;
    NSArray *data;
    
    NSMutableArray *res;
    NSMutableArray *myindexNo;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *userID = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"user"];
    
    
    
    custID=userID;
    NSLog(@"custID==%@",custID);
  
    
    
   
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title=@"NET CONNECT PVT LTD.";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async( dispatch_get_main_queue(), ^{
        
        [self sendDataToServer];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    });
    
}

-(void)viewDidAppear:(BOOL)animated
{
    _TimesheetTableView.dataSource=self;
    _TimesheetTableView.delegate=self;
    
    [_TimesheetTableView reloadData];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [res count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TimesheetTableViewCell";
    
    TimesheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TimesheetTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    
    
    cell.noLbl.text= [myindexNo objectAtIndex:indexPath.row];
    cell.kraLbl.text=[[res objectAtIndex:indexPath.row] valueForKey:@"KRA"];
    cell.dateLbl.text=[[res objectAtIndex:indexPath.row] valueForKey:@"Date"];
    cell.starttimeLbl.text=[[res objectAtIndex:indexPath.row] valueForKey:@"StartTime"];
    cell.endtimeLbl.text=[[res objectAtIndex:indexPath.row] valueForKey:@"EndTime"];
    
   
    
    return cell;
}



-(void)sendDataToServer
{
    
    
    
    NSDictionary *params;
    
    
    @try {
        
        params = @{@"emp_code": custID
                  
                   
                   };
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:@"http://202.143.96.19:8080/NC360Android/time_sheet_info?"parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            
            
             res=[NSMutableArray alloc];
             data = responseObject ;
             res=[data valueForKey:@"TimeSheetItems"];
            
            
            
            for (int i=0; i < res.count; i++)
            {
                
                
                
                if (!myindexNo) myindexNo = [[NSMutableArray alloc] init];
                [myindexNo addObject:[NSString stringWithFormat:@"%d.",i]];
                
            }
            
            
           
             [_TimesheetTableView reloadData];
         
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
            NSLog(@"Error: %@", myString);
        }];
        
        
        
    }
    
    
    
    @catch (NSException *exception) {
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (IBAction)onCreateTimesheet:(id)sender
{
    
    
    CreateTimeSheetViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateTimeSheetViewController"];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    
}
@end
