//
//  ApplyLeaveViewController.m
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 24/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "ApplyLeaveViewController.h"
#import "UITabBarController+Swipe.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#define kOFFSET_FOR_KEYBOARD 80.0


@interface ApplyLeaveViewController ()

@end

@implementation ApplyLeaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    datepicKer=[[UIDatePicker alloc]init];
    datepicKer.datePickerMode=UIDatePickerModeDate;
    [self.startdatatxt setInputView:datepicKer];
    [self.enddatatxt setInputView:datepicKer];
    
    
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.startdatatxt setInputAccessoryView:toolBar];
    [self.enddatatxt setInputAccessoryView:toolBar];
   
    _mainView.layer.borderColor=[UIColor redColor].CGColor;
    _mainView.layer.borderWidth=2.0f;
    
    
    self.resontxt.delegate=self;

    
    // Do any additional setup after loading the view.
}

-(void)ShowSelectedDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
  
    
    if ( [_startdatatxt isFirstResponder] ) {
        
        self.startdatatxt.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datepicKer.date]];
        
        [_startdatatxt resignFirstResponder];
    } else if ( [_enddatatxt isFirstResponder] ) {
        
        self.enddatatxt.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datepicKer.date]];
        [_enddatatxt resignFirstResponder];
    }
    
    
    
    
    
//    self.enddatatxt.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datepicKer.date]];
//    [self.enddatatxt resignFirstResponder];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [self.resontxt resignFirstResponder];
    return YES;
    
    
}


- (IBAction)onClickCancel:(id)sender {
    
    UITabBarController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    tbc.selectedIndex=2;
    [self presentViewController:tbc animated:YES completion:nil];
    
   
    
    
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
    
    
    if ([sender isEqual:self.resontxt.text]){
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
     self.navigationItem.title=@"APPLY LEAVE.";
    
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

- (IBAction)onClickApply:(id)sender
{
        
        
    
        [MBProgressHUD showHUDAddedTo:self.view animated:nil];
        
        
        @try {
            
          
            NSArray *listArray = [[NSUserDefaults standardUserDefaults]
                                  arrayForKey:@"tabArray"];
            
             NSString *emp_name=[listArray objectAtIndex:0];
             NSString *emp_code=[listArray objectAtIndex:1];
           
                       
                     
            if([self.startdatatxt.text isEqualToString:@""] || [self.enddatatxt.text isEqualToString:@""] ||[self.resontxt.text isEqualToString:@""])
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self alertStatus:@"Please enter startDate,endDate and reason" :@"Sign in Failed!" :0];
                
            } else
                
            {
                
                NSDictionary *params = @{@"emp_code": emp_code,
                                         @"start_date": self.startdatatxt.text,
                                         @"end_date": self.enddatatxt.text,
                                         @"emp_name": emp_name,
                                         @"reason": self.resontxt.text,
                                         @"manager_id": @"EMAN000007"
                                         
                                         };
                
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                [manager GET:@"http://202.143.96.19:8080/NC360Android/apply_leave?" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                      
                       [self alertStatus:@"Leave Apply Successfull" :@" Thank u!" :0];
                        
            UITabBarController *tbc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBar"];
                        tbc.selectedIndex=2;
                        [self presentViewController:tbc animated:YES completion:nil];
                        
                        
                    } else {
                        [self alertStatus:@"Something is wrong" :@" Failed!" :0];
                        
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
    

@end
