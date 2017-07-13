//
//  AttendenceListViewController.h
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 09/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "AttendenceListTableViewCell.h"
#import "LoginViewController.h"

@interface AttendenceListViewController : UIViewController<GMSMapViewDelegate,NSXMLParserDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    
    
    NSMutableArray *arrmark;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    CLGeocoder *geocoder;
    NSString *lat;
    NSString *lon;
    NSString *strAdd;
    float lat1;
    float lon1;
    NSString *addressTxt;
    NSString *strcan;
    LoginViewController *logincustId;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *AttendenceTableView;
@property(strong,nonatomic) NSString *customerID;
- (IBAction)onClickIN:(id)sender;
- (IBAction)onClickOUT:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkinBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkoutBtn;

@end
