//
//  ApplyLeaveViewController.h
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 24/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyLeaveViewController : UIViewController<UITextFieldDelegate>{
    
    
    
    UIDatePicker *datepicKer;
    
}
@property (weak, nonatomic) IBOutlet UITextField *startdatatxt;

@property (weak, nonatomic) IBOutlet UITextField *enddatatxt;
@property (weak, nonatomic) IBOutlet UITextField *resontxt;
@property (nonatomic, retain) NSDictionary *data;
- (IBAction)onClickCancel:(id)sender;
- (IBAction)onClickApply:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end
