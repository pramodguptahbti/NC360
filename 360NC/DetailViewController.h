//
//  DetailViewController.h
//  360NC
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 25/01/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController



@property (weak, nonatomic) IBOutlet UIImageView *EmpImage;
@property (weak, nonatomic) IBOutlet UITextField *EmpID;
@property (weak, nonatomic) IBOutlet UITextField *EmpName;
@property (weak, nonatomic) IBOutlet UITextField *EmpMail;
@property (weak, nonatomic) IBOutlet UITextField *EmpMobile;
@property (weak, nonatomic) IBOutlet UITextField *EmpDegigation;
@property (weak, nonatomic) IBOutlet UITextField *EmpLocation;

@property(strong,nonatomic)NSString *employeeID;
@property (weak, nonatomic) IBOutlet UIButton *backBton;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIImageView *EmpUserPic;
@property (weak, nonatomic) IBOutlet UITextField *EmpResource;
@property (weak, nonatomic) IBOutlet UITextField *EmpClient;
@property (weak, nonatomic) IBOutlet UITextField *EmpProject;
@property (weak, nonatomic) IBOutlet UITextField *EmpAddress;

- (IBAction)onClickBackBtn:(id)sender;

@end
