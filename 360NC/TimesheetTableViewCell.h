//
//  TimesheetTableViewCell.h
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 21/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimesheetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *noLbl;
@property (weak, nonatomic) IBOutlet UILabel *kraLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *starttimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *endtimeLbl;

@end
