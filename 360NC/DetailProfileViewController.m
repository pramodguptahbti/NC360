//
//  DetailProfileViewController.m
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 20/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "DetailProfileViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "LoginViewController.h"
#import "ChangePasswordViewController.h"

@interface DetailProfileViewController ()
{
    
    NSArray *emplyArray,*details;
        
    
    
}

@end

@implementation DetailProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
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



-(void)viewDidAppear:(BOOL)animated
{
    
     NSLog(@"View  details==%@",emplyArray);
    
    _EmpID.text=[emplyArray valueForKey:@"EmpCode"];
    _EmpName.text=[emplyArray valueForKey:@"Name"];
    _EmpMail.text=[emplyArray valueForKey:@"Email"];
    _addressText.text=[emplyArray valueForKey:@"Address"];
    _EmpMobileNo.text=[emplyArray valueForKey:@"Mobile"];
   
    [super viewDidAppear: YES];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



- (IBAction)onClickLogBtn:(id)sender {
    
        // Do any of the following setting to set the style (Only set what you want to change)
        // Maybe do this when app starts (in AppDelegate) or anywhere you wanna change the style.
        
        
        // uncomment the following line to use custom settings.
        
        //#define USE_CUSTOM_SETTINGS
        
#ifdef USE_CUSTOM_SETTINGS
        FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
        configuration.menuRowHeight = 80;
        configuration.menuWidth = 120;
        configuration.textColor = [UIColor orangeColor];
        configuration.textFont = [UIFont boldSystemFontOfSize:14];
        configuration.tintColor = [UIColor whiteColor];
        configuration.borderColor = [UIColor blackColor];
        configuration.borderWidth = 0.5;
        //    configuration.textAlignment = NSTextAlignmentCenter;
        //    configuration.ignoreImageOriginalColor = YES;// set 'ignoreImageOriginalColor' to YES, images color will be same as textColor
        
#endif
        
    
        [FTPopOverMenu showForSender:sender
                       withMenuArray:@[@"Change Password", @"Logout"]
                          imageArray:nil
                           doneBlock:^(NSInteger selectedIndex) {
                               
                              if (selectedIndex==0)
                               {
                            
                                 NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                                   
                                   
                                   ChangePasswordViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
                                   [self presentViewController:vc animated:YES completion:nil];
                                   
                                  
                                   
                               }
                               if (selectedIndex==1)
                               {
                                   
                                 NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                                   
                                   LoginViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                   [self presentViewController:vc animated:YES completion:nil];

                                   
                            }
                               
                               
                               
                               
                           } dismissBlock:^{
                               
                               NSLog(@"user canceled. do nothing.");
                               
                               
                               
                           }];
        
        
      
}
@end
