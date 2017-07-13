//
//  WebHelperViewController.m
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 22/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "WebHelperViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"




@interface WebHelperViewController ()
{
    
    NSArray *emplyArray;
}

@end

@implementation WebHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}


+(id)sharedManager
{
    
    static WebHelperViewController *sharedWebhelperclass=nil;
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken,^{
        
        sharedWebhelperclass=[[self alloc]init];
        
        
    });
    
    return sharedWebhelperclass;
    
}


-(void)getdetails{
    
    
    
}



-(NSArray *)getEmployeDetail
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *userID = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"user"];
    
    
    @try {
        
        
        NSDictionary *params = @{@"emp_code":userID};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:@"http://202.143.96.19:8080/NC360Android/profile?" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
