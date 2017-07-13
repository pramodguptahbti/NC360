//
//  AttendenceListTableViewCell.h
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 09/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendenceListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLbl;
@property (weak, nonatomic) IBOutlet UILabel *dataLbl;
@property (weak, nonatomic) IBOutlet UILabel *inTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *outTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *stausLbl;

@end
