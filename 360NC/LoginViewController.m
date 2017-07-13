//
//  LoginViewController.m
//  360NC
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 31/01/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "LoginViewController.h"
#import "ListViewController.h"
#import "AttendenceListViewController.h"
#import "UITabBarController+Swipe.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#define kOFFSET_FOR_KEYBOARD 80.0

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loginBtn.layer.cornerRadius = 20; // this value vary as per your desire
    _loginBtn.clipsToBounds = YES;
    self.UserIdTextField.delegate=self;
    self.passwordTextField.delegate=self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.UserIdTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    return YES;
    
 }

- (IBAction)loginBtnClick:(id)sender
{
    
    self.userid= self.UserIdTextField.text;
    self.password=self.passwordTextField.text;
    [MBProgressHUD showHUDAddedTo:self.view animated:nil];
        
    
        @try {
            
            NSString *user= self.UserIdTextField.text;
            NSString *pass= self.passwordTextField.text;
            
            [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"user"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if([user isEqualToString:@""] || [pass isEqualToString:@""] )
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
                
            } else
                
            {
                
                
                
                
                
                
            NSDictionary *params = @{@"userID": user,
                                     @"password": pass,
                                     @"type":@"ROLE_Employee",
                                     @"ios":@""
                                     
                                     
                                     
                                     
                                     };
                
                        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                [manager GET:@"http://192.168.1.89:8080/NC360Android/login?" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                        NSLog(@"Login SUCCESS");
                        
                        
                        _userid=user;
                        
                        
                        if([status  isEqual: @"0"])
                        {
                        
                            
                        NSArray *tabArrayArray=[[NSArray alloc]initWithObjects:[_data objectForKey:@"Name"],user, nil];
                            
                            [[NSUserDefaults standardUserDefaults] setObject:tabArrayArray forKey:@"tabArray"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                            
                            UITabBarController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
                               tbc.selectedIndex=0;
                                [self presentViewController:tbc animated:YES completion:nil];
                             //[self.navigationController pushViewController:tbc animated:YES];
                            
                            
                        }
                        
                        else{
                            
                            NSArray *listArray=[[NSArray alloc]initWithObjects:user,status,[_data objectForKey:@"UserID"],[_data objectForKey:@"Employee_Name"],[_data objectForKey:@"EmpCode"], nil];
                            
                            [[NSUserDefaults standardUserDefaults] setObject:listArray forKey:@"listArray"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                            ListViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }
                        
                        
                        
                    } else {
                    [self alertStatus:@"Username and/or password is invalid" :@"Sign in Failed!" :0];
                        
                    }
                    
            
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
                        NSLog(@"Error: %@", myString);
                    }];
                
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                
                
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
    

    - (IBAction)backgroundTap:(id)sender {
        [self.view endEditing:YES];
    }
    
    -(void)keyboardWillShow {
        // Animate the current view out of the way
        if (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
    }
    
    -(void)keyboardWillHide {
        if (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
    }
    
    -(void)textFieldDidBeginEditing:(UITextField *)sender
    {
        if ([sender isEqual:self.UserIdTextField.text])
        {
            //move the main view, so that the keyboard does not hide it.
            if  (self.view.frame.origin.y >= 0)
            {
                [self setViewMovedUp:YES];
            }
        }
        
        if ([sender isEqual:self.passwordTextField.text]){
            if  (self.view.frame.origin.y >= 0)
            {
                [self setViewMovedUp:YES];
            }
            
        }
        
    }
    
    //method to move the view up/down whenever the keyboard is shown/dismissed
    -(void)setViewMovedUp:(BOOL)movedUp
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3]; // if you want to slide up the view
        
        CGRect rect = self.view.frame;
        if (movedUp)
        {
            // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
            // 2. increase the size of the view so that the area behind the keyboard is covered up.
            rect.origin.y -= kOFFSET_FOR_KEYBOARD;
            rect.size.height += kOFFSET_FOR_KEYBOARD;
        }
        else
        {
            // revert back to the normal state.
            rect.origin.y += kOFFSET_FOR_KEYBOARD;
            rect.size.height -= kOFFSET_FOR_KEYBOARD;
        }
        self.view.frame = rect;
        
        [UIView commitAnimations];
    }
    
    
    - (void)viewWillAppear:(BOOL)animated
    {
        [super viewWillAppear:animated];
        
          self.navigationItem.title=@"NET CONNECT PVT LTD.";
        
        // register for keyboard notifications
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    
    - (void)viewWillDisappear:(BOOL)animated
    {
        [super viewWillDisappear:animated];
        // unregister for keyboard notifications while not visible.
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillShowNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillHideNotification
                                                      object:nil];
    }
 
    
     

@end
