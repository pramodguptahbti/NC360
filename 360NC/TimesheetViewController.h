//
//  TimesheetViewController.h
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 21/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimesheetViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
- (IBAction)onCreateTimesheet:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *TimesheetTableView;
@property (weak, nonatomic) IBOutlet UIButton *createtimesheetBtn;
@end
