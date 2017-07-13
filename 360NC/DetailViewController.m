//
//  DetailViewController.m
//  360NC
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 25/01/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "DetailViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface DetailViewController ()
{
    NSArray *emplyArray,*details;
    
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _EmpUserPic.image=[UIImage imageNamed:@"images"];
    _backBton.layer.cornerRadius = 10;
    _backBton.clipsToBounds = YES;
    
    _nextBtn.layer.cornerRadius = 10; 
    _nextBtn.clipsToBounds = YES;
  
}


    -(void)viewWillAppear:(BOOL)animated
    {
        [super viewWillAppear:YES];
        self.navigationItem.title=@"NET CONNECT PVT LTD.";
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async( dispatch_get_main_queue(), ^{
            
            details=    [self getEmployeDetail];
            NSLog(@"details==%@",details);
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
  }


-(NSArray *)getEmployeDetail
{
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
//    NSString *userID = [[NSUserDefaults standardUserDefaults]
//                        stringForKey:@"user"];
    
    
    @try {
        
        
            NSDictionary *params = @{@"emp_code":self.employeeID};
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            [manager GET:@"http://202.143.96.19:8080/NC360Android/emp_details?" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
                
                emplyArray = responseObject ;
              
                
               [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
                NSLog(@"Error: %@", myString);
            }];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
       }
    
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
       
     }
    
    
    return emplyArray;
    
}



-(void)viewDidAppear:(BOOL)animated
{
    
     NSLog(@"View  details==%@",emplyArray);
    
    _EmpDegigation.text=[emplyArray valueForKey:@"Designation"];
    _EmpID.text=[emplyArray valueForKey:@"EmpCode"];
    _EmpName.text=[emplyArray valueForKey:@"Employee_Name"];
    _EmpLocation.text=[emplyArray valueForKey:@"Location"];
    _EmpMail.text=[emplyArray valueForKey:@"Email"];
    _EmpMobile.text=[emplyArray valueForKey:@"Mobile"];
    _EmpClient.text=[emplyArray valueForKey:@"Client_Name"];
    _EmpProject.text=[emplyArray valueForKey:@"Project_Name"];
    _EmpResource.text=[emplyArray valueForKey:@"Resource_ID"];
    _EmpAddress.text=[emplyArray valueForKey:@"Address"];
     [super viewDidAppear: YES];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)onClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
   
    
    
}
@end
