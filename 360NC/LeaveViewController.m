//
//  LeaveViewController.m
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 21/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "LeaveViewController.h"
#import "LeaveTableViewCell.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "ApplyLeaveViewController.h"

@interface LeaveViewController ()

@end

@implementation LeaveViewController{
    
      NSString *custID;
      NSArray *data;
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
    self.navigationItem.title=@"Leave.";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async( dispatch_get_main_queue(), ^{
        
           [self sendDataToServer];
          [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    });
    
    
}




-(void)viewDidAppear:(BOOL)animated
{
     _LeaveTableView.dataSource=self;
     _LeaveTableView.delegate=self;
     [_LeaveTableView reloadData];
    
    
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"LeaveTableViewCell";
    
    LeaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LeaveTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
   
    
    cell.noLbl.text=[myindexNo objectAtIndex:indexPath.row];
    cell.leavedateLbl.text=[[data objectAtIndex:indexPath.row] valueForKey:@"LeaveDate"];
    cell.leavereasonLbl.text=[[data objectAtIndex:indexPath.row] valueForKey:@"LeaveReason"];
    cell.stausLbl.text=[[data objectAtIndex:indexPath.row] valueForKey:@"Status"];
    
    
    
    
    return cell;
}



-(void)sendDataToServer
{
    
    NSDictionary *params;
    
    
    @try {
                   
                      params = @{@"emp_code": custID,
                                 @"offset":@"0"
                       
                                 };
            
            
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:@"http://202.143.96.19:8080/NC360Android/leave_info?"parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            data = responseObject ;
            
           
            
           
            for (int i=0; i < data.count; i++)
            {
                
               
                
                if (!myindexNo) myindexNo = [[NSMutableArray alloc] init];
                 [myindexNo addObject:[NSString stringWithFormat:@"%d.",i]];
                
            }
            
            [_LeaveTableView reloadData];
            
            
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
   
}


- (IBAction)onClickApplyLeave:(id)sender


{
     ApplyLeaveViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ApplyLeaveViewController"];
    
         [self presentViewController:vc animated:YES completion:nil];
        
    
}




@end
