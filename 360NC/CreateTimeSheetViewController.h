//
//  CreateTimeSheetViewController.h
//  NC 360
//
//  Created by RAC IT SOLUTIONS PVT.LTD on 24/02/17.
//  Copyright © 2017 NetConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateTimeSheetViewController : UIViewController{
    
    
    UIDatePicker *datepicKer;
    
}
@property (weak, nonatomic) IBOutlet UITextField *selectkratxt;
@property (weak, nonatomic) IBOutlet UITextField *startdatetxt;
@property (weak, nonatomic) IBOutlet UITextField *enddatetxt;
@property (weak, nonatomic) IBOutlet UITextField *remarktxt;
- (IBAction)onClickCancel:(id)sender;
- (IBAction)onClickSave:(id)sender;
@property (nonatomic, retain) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end
