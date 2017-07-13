//
//  ListViewController.h
//  360NC
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 02/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewCell.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

#import "DetailViewController.h"

@interface ListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
