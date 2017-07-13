//
//  LeaveViewController.h
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 21/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *LeaveTableView;
- (IBAction)onClickApplyLeave:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *applyleaveBtn;

@end
