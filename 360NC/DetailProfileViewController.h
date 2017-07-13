//
//  DetailProfileViewController.h
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 20/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebHelperViewController.h"
#import "FTPopOverMenu.h"

@interface DetailProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *EmpImage;
@property (weak, nonatomic) IBOutlet UITextField *EmpID;
@property (weak, nonatomic) IBOutlet UITextField *EmpName;
@property (weak, nonatomic) IBOutlet UITextField *EmpMail;


@property (weak, nonatomic) IBOutlet UITextField *EmpMobileNo;

@property(strong,nonatomic)NSString *employeeID;

@property (weak, nonatomic) IBOutlet UITextView *addressText;
- (IBAction)onClickLogBtn:(id)sender;

@end
