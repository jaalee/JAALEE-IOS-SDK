//
//  JAALEEDATAConfigureViewController.m
//  eBeacon
//
//  Created by jaalee on 15/9/10.
//  Copyright (c) 2015年 jaalee. All rights reserved.
//

#import "JAALEEDATAConfigureViewController.h"
#import "WaitProgressShow.h"
#import "AppDelegate.h"

@interface JAALEEDATAConfigureViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *BeaconDataMode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *EddystoneModeSelect;

@property (weak, nonatomic) IBOutlet UIView *iBeaconDataVIew;

@property (weak, nonatomic) IBOutlet UIView *EddystoneView;
@property (weak, nonatomic) IBOutlet UIView *Eddystone_UID_MODEVIEW;
@property (weak, nonatomic) IBOutlet UIView *Eddystone_URL_MODEVIEW;

@property (weak, nonatomic) IBOutlet UITextField *iBeacon_UUID_Input;
@property (weak, nonatomic) IBOutlet UITextField *iBeacon_MAJOr_Input;
@property (weak, nonatomic) IBOutlet UITextField *iBeacon_MINOR_Input;
@property (weak, nonatomic) IBOutlet UITextField *iBeacon_Power_Input;

@property (weak, nonatomic) IBOutlet UITextField *EDDY_Namespace_Input;
@property (weak, nonatomic) IBOutlet UITextField *EDDY_Inatance_Input;
@property (weak, nonatomic) IBOutlet UITextField *EDDY_UIDPower_Input;
@property (weak, nonatomic) IBOutlet UITextField *EDDY_URLPOWER_Input;
@property (weak, nonatomic) IBOutlet UITextField *EDDY_URL_Input;
@end

@implementation JAALEEDATAConfigureViewController
{
    AppDelegate *appDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (self.SELECT_ID == 0) {
        [_BeaconDataMode setSelectedSegmentIndex:0];
        [_BeaconDataMode setEnabled:false forSegmentAtIndex:1];
        
        [_iBeacon_UUID_Input setText:_mConnectedBeacon.proximityUUID];
        [_iBeacon_MAJOr_Input setText:[NSString stringWithFormat:@"%@", _mConnectedBeacon.major]];
        [_iBeacon_MINOR_Input setText:[NSString stringWithFormat:@"%@", _mConnectedBeacon.minor]];
        [_iBeacon_Power_Input setText:[NSString stringWithFormat:@"%@", _mConnectedBeacon.measuredPower]];
    }
    else{
        [_BeaconDataMode setSelectedSegmentIndex:0];
        [_BeaconDataMode setEnabled:true forSegmentAtIndex:1];
    }
    
    [_iBeaconDataVIew setAlpha:1];
    [_EddystoneView setAlpha:0];
    
    [_Eddystone_UID_MODEVIEW setAlpha:1];
    [_Eddystone_URL_MODEVIEW setAlpha:0];
    
//    self.navigationController.navigationItem.backBarButtonItem.title = @"back";
    
//    [self.navigationController set]
//    [self.navigationController set]
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_iBeacon_UUID_Input resignFirstResponder];
    [_iBeacon_MAJOr_Input resignFirstResponder];
    [_iBeacon_MINOR_Input resignFirstResponder];
    [_iBeacon_Power_Input resignFirstResponder];
    [_EDDY_Namespace_Input resignFirstResponder];
    [_EDDY_Inatance_Input resignFirstResponder];
    [_EDDY_UIDPower_Input resignFirstResponder];
    [_EDDY_URLPOWER_Input resignFirstResponder];
    [_EDDY_URL_Input resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) CheckiBeaconDataFomat
{
    if (self.iBeacon_UUID_Input.text.length != 36)
    {
        [WaitProgressShow showErrorWithStatus:@"UUID format is incorrect"];
        return false;
    }
    if ([self.iBeacon_MAJOr_Input.text intValue] < 1 || [self.iBeacon_MAJOr_Input.text intValue] > 65535)
    {
        [WaitProgressShow showErrorWithStatus:@"Major value out of range"];
        return false;
    }
    if ([self.iBeacon_MINOR_Input.text intValue] < 1 || [self.iBeacon_MINOR_Input.text intValue] > 65535)
    {
        [WaitProgressShow showErrorWithStatus:@"Minor value out of range"];
        return false;
    }
    if ([self.iBeacon_Power_Input.text intValue] < 128 || [self.iBeacon_Power_Input.text intValue] > 255)
    {
        [WaitProgressShow showErrorWithStatus:@"Power value out of range"];
        return false;
    }
    
    return true;
}

-(BOOL) CheckEddystoneUIDFormat
{
    if (self.EDDY_Namespace_Input.text.length != 20)
    {
        [WaitProgressShow showErrorWithStatus:@"Namespace ID format is incorrect"];
        return false;
    }
    if (self.EDDY_Inatance_Input.text.length != 12)
    {
        [WaitProgressShow showErrorWithStatus:@"Instance ID format is incorrect"];
        return false;
    }
    if ([self.EDDY_UIDPower_Input.text intValue] < 128 || [self.EDDY_UIDPower_Input.text intValue] > 255)
    {
        [WaitProgressShow showErrorWithStatus:@"Power value out of range"];
        return false;
    }
    
    return true;
}

-(BOOL) CheckEddystoneURLFormat
{
    if (self.EDDY_URL_Input.text.length == 0)
    {
        [WaitProgressShow showErrorWithStatus:@"Please input the uri first"];
        return false;
    }
    if ([self.EDDY_URLPOWER_Input.text intValue] < 128 || [self.EDDY_URLPOWER_Input.text intValue] > 255)
    {
        [WaitProgressShow showErrorWithStatus:@"Power value out of range"];
        return false;
    }
    
    return true;
}

- (IBAction)OnTouchSend:(id)sender {
    
    if (self.SELECT_ID == 0) {
        if ([self CheckiBeaconDataFomat]) {
            [WaitProgressShow showWithStatus:@"Trying to configure JAALEE"];
            [self.mConnectedBeacon configureIBeaconChannel:self.iBeacon_UUID_Input.text Major:[self.iBeacon_MAJOr_Input.text intValue] Minor:[self.iBeacon_MINOR_Input.text intValue] measuredPowerValue:[self.iBeacon_Power_Input.text intValue] WithCompletion:^(BOOL value, NSError* error)
             {
                 if (value) {
                     [WaitProgressShow showSuccessWithStatus:@"Configure successfully"];
                 }
                 else
                 {
                     if (error != nil && error.code == 100) {
                         [WaitProgressShow showErrorWithStatus:@"Network Error"];
                     }
                     else
                     {
                         [WaitProgressShow showErrorWithStatus:@"Configure failed"];
                     }
                 }
             }];
        }
    }
    else if (self.SELECT_ID == 1)
    {
        if (_BeaconDataMode.selectedSegmentIndex == 0) {
            if ([self CheckiBeaconDataFomat]) {
                [WaitProgressShow showWithStatus:@"Trying to configure JAALEE"];
                [self.mConnectedBeacon configureCustomChannelOneAsIBeacon:self.iBeacon_UUID_Input.text Major:[self.iBeacon_MAJOr_Input.text intValue] Minor:[self.iBeacon_MINOR_Input.text intValue] measuredPowerValue:[self.iBeacon_Power_Input.text intValue] WithCompletion:^(BOOL value, NSError* error)
                 {
                     if (value) {
                         [WaitProgressShow showSuccessWithStatus:@"Configure successfully"];
                     }
                     else
                     {
                         if (error != nil && error.code == 100) {
                             [WaitProgressShow showErrorWithStatus:@"Network Error"];
                         }
                         else
                         {
                             [WaitProgressShow showErrorWithStatus:@"Configure failed"];
                         }
                     }
                 }];
            }
        }
        else
        {
            if (_EddystoneModeSelect.selectedSegmentIndex == 0) {
                if ([self CheckEddystoneUIDFormat]) {
                    [WaitProgressShow showWithStatus:@"Trying to configure JAALEE"];
                    [self.mConnectedBeacon configureCustomChannelOneAsEddystone:self.EDDY_Namespace_Input.text InstanceID:self.EDDY_Inatance_Input.text measuredPowerValue:[self.EDDY_UIDPower_Input.text intValue] WithCompletion:^(BOOL value, NSError* error)
                     {
                         if (value) {
                             [WaitProgressShow showSuccessWithStatus:@"Configure successfully"];
                         }
                         else
                         {
                             if (error != nil && error.code == 100) {
                                 [WaitProgressShow showErrorWithStatus:@"Network Error"];
                             }
                             else
                             {
                                 [WaitProgressShow showErrorWithStatus:@"Configure failed"];
                             }
                         }
                     }];
                }
            }
            else
            {
                if ([self CheckEddystoneURLFormat]) {
                    [WaitProgressShow showWithStatus:@"Trying to configure JAALEE"];
                    [self.mConnectedBeacon configureCustomChannelOneAsEddystone:[NSURL URLWithString:self.EDDY_URL_Input.text] measuredPowerValue:[self.EDDY_URLPOWER_Input.text intValue] WithCompletion:^(BOOL value, NSError* error)
                     {
                         if (value) {
                             [WaitProgressShow showSuccessWithStatus:@"Configure successfully"];
                         }
                         else
                         {
                             if (error != nil && error.code == 100) {
                                 [WaitProgressShow showErrorWithStatus:@"Network Error"];
                             }
                             else
                             {
                                 [WaitProgressShow showErrorWithStatus:@"Configure failed"];
                             }
                         }
                     }];
                }
            }
        }
    }
    else if (self.SELECT_ID == 2)
    {
        if (_BeaconDataMode.selectedSegmentIndex == 0) {
            if ([self CheckiBeaconDataFomat]) {
                [WaitProgressShow showWithStatus:@"Trying to configure JAALEE"];
                [self.mConnectedBeacon configureCustomChannelTwoAsIBeacon:self.iBeacon_UUID_Input.text Major:[self.iBeacon_MAJOr_Input.text intValue] Minor:[self.iBeacon_MINOR_Input.text intValue] measuredPowerValue:[self.iBeacon_Power_Input.text intValue] WithCompletion:^(BOOL value, NSError* error)
                 {
                     if (value) {
                         [WaitProgressShow showSuccessWithStatus:@"Configure successfully"];
                     }
                     else
                     {
                         if (error != nil && error.code == 100) {
                             [WaitProgressShow showErrorWithStatus:@"Network Error"];
                         }
                         else
                         {
                             [WaitProgressShow showErrorWithStatus:@"Configure failed"];
                         }
                     }
                 }];
            }
        }
        else
        {
            if (_EddystoneModeSelect.selectedSegmentIndex == 0) {
                if ([self CheckEddystoneUIDFormat]) {
                    [WaitProgressShow showWithStatus:@"Trying to configure JAALEE"];
                    [self.mConnectedBeacon configureCustomChannelTwoAsEddystone:self.EDDY_Namespace_Input.text InstanceID:self.EDDY_Inatance_Input.text measuredPowerValue:[self.EDDY_UIDPower_Input.text intValue] WithCompletion:^(BOOL value, NSError* error)
                     {
                         if (value) {
                             [WaitProgressShow showSuccessWithStatus:@"Configure successfully"];
                         }
                         else
                         {
                             if (error != nil && error.code == 100) {
                                 [WaitProgressShow showErrorWithStatus:@"Network Error"];
                             }
                             else
                             {
                                 [WaitProgressShow showErrorWithStatus:@"Configure failed"];
                             }
                         }
                     }];
                }
            }
            else
            {
                if ([self CheckEddystoneURLFormat]) {
                    [WaitProgressShow showWithStatus:@"Trying to configure JAALEE"];
                    [self.mConnectedBeacon configureCustomChannelTwoAsEddystone:[NSURL URLWithString:self.EDDY_URL_Input.text] measuredPowerValue:[self.EDDY_URLPOWER_Input.text intValue] WithCompletion:^(BOOL value, NSError* error)
                     {
                         if (value) {
                             [WaitProgressShow showSuccessWithStatus:@"Configure successfully"];
                         }
                         else
                         {
                             if (error != nil && error.code == 100) {
                                 [WaitProgressShow showErrorWithStatus:@"Network Error"];
                             }
                             else
                             {
                                 [WaitProgressShow showErrorWithStatus:@"Configure failed"];
                             }
                         }
                     }];
                }
            }
        }
    }
}

- (IBAction)OnSelectBeaconMode:(id)sender {
    if (_BeaconDataMode.selectedSegmentIndex == 0) {
        [_iBeaconDataVIew setAlpha:1];
        [_EddystoneView setAlpha:0];
    }
    else
    {
        [_iBeaconDataVIew setAlpha:0];
        [_EddystoneView setAlpha:1];
    }
}
- (IBAction)OnSelectEddystoneMode:(id)sender {
    
    if (_EddystoneModeSelect.selectedSegmentIndex == 0) {
        [_Eddystone_UID_MODEVIEW setAlpha:1];
        [_Eddystone_URL_MODEVIEW setAlpha:0];
    }
    else
    {
        [_Eddystone_UID_MODEVIEW setAlpha:0];
        [_Eddystone_URL_MODEVIEW setAlpha:1];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
