//
//  LeaveTableViewCell.h
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 21/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *noLbl;
@property (weak, nonatomic) IBOutlet UILabel *leavedateLbl;
@property (weak, nonatomic) IBOutlet UILabel *leavereasonLbl;
@property (weak, nonatomic) IBOutlet UILabel *stausLbl;

@end
