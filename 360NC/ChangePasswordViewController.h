//
//  ChangePasswordViewController.h
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 24/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController

- (IBAction)onClickResetPass:(id)sender;
- (IBAction)onClickCancel:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *oldpasstxt;
@property (weak, nonatomic) IBOutlet UITextField *newpasstxt;
@property (weak, nonatomic) IBOutlet UITextField *confirmpasstxt;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic, retain) NSDictionary *data;

@end
