//
//  WebHelperViewController.h
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 22/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

#define baseurl @"http://202.143.96.19:8080/NC360Android/";

@interface WebHelperViewController : UIViewController
@property(strong,nonatomic)NSString *dataUrl;

+(NSArray *)getEmployeDetail;

+(id)sharedManager;


@end
