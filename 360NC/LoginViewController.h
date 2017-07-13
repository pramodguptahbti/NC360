//
//  LoginViewController.h
//  360NC
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 31/01/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    
   
    
    
}
@property (weak, nonatomic) IBOutlet UITextField *UserIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic, retain) NSDictionary *data;
@property(strong,nonatomic) NSString *userid,*password;

- (IBAction)loginBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
