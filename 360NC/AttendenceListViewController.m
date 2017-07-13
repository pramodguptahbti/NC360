//
//  AttendenceListViewController.m
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 09/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import "AttendenceListViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface AttendenceListViewController ()
@end

@implementation AttendenceListViewController{
    
    GMSMapView *mapVieww;
    CLLocationCoordinate2D position;
    BOOL firstLocationUpdate_;
    
    NSArray *tableData;
    NSString *custID;
    NSString *markString;
    UIAlertView *alert;
    
     NSArray *dataList,*data;
     NSMutableArray *myindexNo;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"user"];
    
    
    
    custID=userID;
    
    NSLog(@"custID==%@",custID);
    
   
    self.title = @"Attendance";
    
    
    }


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
 
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async( dispatch_get_main_queue(), ^{
        
        [self sendDataToServerList];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    });
    
    
}



-(void)viewDidAppear:(BOOL)animated
{
    
    _AttendenceTableView.delegate=self;
    _AttendenceTableView.dataSource=self;
    
    
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"AttendenceListTableViewCell";
    
    AttendenceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AttendenceListTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
    
    cell.numberLbl.text= [myindexNo objectAtIndex:indexPath.row];
    cell.dataLbl.text=[[dataList objectAtIndex:indexPath.row] valueForKey:@"AttendanceDate"];
    cell.inTimeLbl.text=[[dataList objectAtIndex:indexPath.row] valueForKey:@"InTime"];
    cell.outTimeLbl.text=[[dataList objectAtIndex:indexPath.row] valueForKey:@"OutTime"];
    cell.stausLbl.text=[[dataList objectAtIndex:indexPath.row] valueForKey:@"AttendanceStatus"];
   
    cell.stausLbl.backgroundColor=[UIColor greenColor];
    return cell;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 78;
//}


//******************************************************************//
#pragma mark - KVO updates
//******************************************************************//

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (!firstLocationUpdate_) {
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapVieww.camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:14];
    }
}
//******************************************************************//
#pragma mark Getting LatLong
//******************************************************************//

- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    position.latitude = latitude;
    position.longitude = longitude;
    return position;
}

//******************************************************************//
#pragma mark CLLocation Method
//******************************************************************//

-(CLLocationCoordinate2D) getLocation{
    
    locationManager   = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    geocoder = [[CLGeocoder alloc] init];
    currentLocation= newLocation;
    if (currentLocation != nil)
        NSLog(@"longitude = %.8f\nlatitude = %.8f", currentLocation.coordinate.longitude,currentLocation.coordinate.latitude);
    lat  = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    lon  = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    lat1 = [lat doubleValue];
    lon1 = [lon doubleValue];
    
    [locationManager stopUpdatingLocation];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil && [placemarks count] > 0)
         {
             CLPlacemark * placemark = [placemarks lastObject];
             placemark = [placemarks lastObject];
             if ( placemark.subThoroughfare == NULL) {
                 addressTxt = [NSString stringWithFormat:@"%@\n",placemark.locality];
                 
             } else {
                 addressTxt = [NSString stringWithFormat:@"%@ %@\t%@\n",
                               placemark.subThoroughfare, placemark.thoroughfare,
                               placemark.locality];
             }
             NSLog(@"%@",addressTxt);
             strAdd   = nil;
             if ([placemark.subThoroughfare length] != 0)
                 strAdd = placemark.subThoroughfare;
             if ([placemark.thoroughfare length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
                 else
                 {
                     strAdd = placemark.thoroughfare;
                 }
             }
             if ([placemark.postalCode length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
                 else
                     strAdd = placemark.postalCode;
             }
             
             if ([placemark.locality length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
                 else
                     strAdd = placemark.locality;
             }
             
             if ([placemark.administrativeArea length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
                 else
                     strAdd = placemark.administrativeArea;
             }
             
             if ([placemark.country length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
                 else
                     strAdd = placemark.country;
             }
             
         }
     }];

    
    
    
    
   
}

-(void)sendDataToServerList
{
    
    NSString *urlLink;
    NSDictionary *params;
    
    
    @try {
        
        
        addressTxt=@"A90 sector 2 noida up india";
        NSLog(@"addressTxt==%@",addressTxt);
        
        urlLink= @"http://202.143.96.19:8080/NC360Android/attendance_info?";
        params = @{@"emp_code": custID };
            
            
       
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:urlLink parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            dataList = responseObject ;
            
            
           
            
            
            
            
            for (int i=0; i < dataList.count; i++)
            {
                
                
                
                if (!myindexNo) myindexNo = [[NSMutableArray alloc] init];
                [myindexNo addObject:[NSString stringWithFormat:@"%d.",i]];
                
            }
            
            [_AttendenceTableView reloadData];
            
            
            
           
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
            NSLog(@"Error: %@", myString);
        }];
        
        
        
        
    }
    @catch (NSException *exception) {
        
    }
    
    
}


-(void)sendDataToServer
{
    
    
    NSString *urlLink;
    NSDictionary *params;
    
    
    @try {
        
        
        addressTxt=@"A90 sector 2 noida up india";
        NSLog(@"addressTxt==%@",addressTxt);
        
        
        if ([markString isEqualToString:@"1"])
        {
          
          urlLink=@"http://202.143.96.19:8080/NC360Android/mark_in?";
          params = @{@"emp_code": custID,
                       @"location":addressTxt,
                       @"manager_id":@""
                       
                       };
            
           
            
            
        }
        else if ([markString isEqualToString:@"2"])
        {
             urlLink=@"http://202.143.96.19:8080/NC360Android/mark_out?";
            params = @{@"emp_code": custID,
                       @"location": addressTxt,
                       @"manager_id":@""
                                     
                                     };
            
            
            
        }
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:urlLink parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            data = responseObject ;
            
            
            if (markString!=nil)
            {
            
             markString=nil;
            
             NSString *result=[data valueForKey:@"RESULT"];
            
            
            if ([result isEqualToString:@"ALREADY_OUT"])
            {
                
                alert = [[UIAlertView alloc] initWithTitle:nil
                                                   message:@"You are already marked out"
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
                [alert show];
                
                
            } if ([result isEqualToString:@"ALREADY_IN"])
            {
                
                alert = [[UIAlertView alloc] initWithTitle:nil
                                                   message:@"You are already marked in"
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
                [alert show];
                
                
                  }
                
            
                   
            if ([result isEqualToString:@"SUCCESS"])
            {
                
                [self sendDataToServerList];
                
                
                alert = [[UIAlertView alloc] initWithTitle:@"Attendence"
                                                   message:@"you have successfully marked your attendence for the day"
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
                [alert show];
                
                
            }

      }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *myString = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
            NSLog(@"Error: %@", myString);
        }];
        
      
        
        
    }
    @catch (NSException *exception) {
        
    }
 
    
}


- (IBAction)onClickIN:(id)sender
{
    [self getLocation];
    markString=@"1";
    
    alert = [[UIAlertView alloc] initWithTitle:@"Check In Time"
                                                              message:@"Are you sure you want to check In?"
                                                             delegate:self
                                                      cancelButtonTitle:@"NO"
                                                    otherButtonTitles:@"YES", nil];
                            [alert show];
    
    
    
    
   
}

- (IBAction)onClickOUT:(id)sender
{

    [self getLocation];
      markString=@"2";
   
    alert = [[UIAlertView alloc] initWithTitle:@"Check Out Time"
                                                                message:@"Are you sure you want to check Out?"
                                                           delegate:self
                                                   cancelButtonTitle:@"NO"
                                                      otherButtonTitles:@"YES", nil];
                           [alert show];
    
    
    
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
        [alert setHidden:YES];
        
        
        
    }
    if (buttonIndex == 1)
    {
       [self sendDataToServer];
    }
}




@end
