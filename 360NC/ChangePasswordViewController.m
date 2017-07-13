//
//  ChangePasswordViewController.m
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 24/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UITabBarController+Swipe.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#define kOFFSET_FOR_KEYBOARD 80.0
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainView.layer.borderColor=[UIColor redColor].CGColor;
    _mainView.layer.borderWidth=2.0f;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


- (IBAction)onClickResetPass:(id)sender
{
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:nil];
    
    
    @try {
        
        
        NSArray *listArray = [[NSUserDefaults standardUserDefaults]
                              arrayForKey:@"tabArray"];
        
        
        
        
        
    
        NSString *emp_code=[listArray objectAtIndex:1];
        
        
        
        if([self.oldpasstxt.text isEqualToString:@""] || [self.newpasstxt.text isEqualToString:@""] ||[self.confirmpasstxt.text isEqualToString:@""])
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self alertStatus:@"Please enter oldpass,newpass and confirmpass" :@"Sign in Failed!" :0];
            
        } else
            
        {
            
            
            NSDictionary *params = @{@"emp_code": emp_code,
                                     @"old_pass": self.oldpasstxt.text,
                                     @"new_pass": self.newpasstxt.text
                                    
                                    };
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            [manager GET:@"http://202.143.96.19:8080/NC360Android/reset_password?" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
                
                _data = responseObject ;
                NSLog(@"_data===%@",_data);
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                NSString *success;
                success = [_data objectForKey:@"RESULT"];
                
                NSString *status;
                status = [_data objectForKey:@"Status"];
                
                if([success  isEqual: @"SUCCESS"])
                {
                    
                    [self alertStatus:@"Password Successfull Updated" :@" Thank u!" :0];
                    
                    UITabBarController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
                    tbc.selectedIndex=0;
                    [self presentViewController:tbc animated:YES completion:nil];
                    
                    
                } else {
                    [self alertStatus:@"Something is wrong" :@" Failed!" :0];
                    
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
                NSLog(@"Error: %@", myString);
            }];
            
            
            
        }
        
    }
    
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    
    
    
}


- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
    
}




- (IBAction)onClickCancel:(id)sender {
    
    UITabBarController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    tbc.selectedIndex=0;
    [self presentViewController:tbc animated:YES completion:nil];
}
@end
