//
//  JAALEEChannelSelectViewController.m
//  eBeacon
//
//  Created by jaalee on 15/9/11.
//  Copyright (c) 2015年 jaalee. All rights reserved.
//

#import "JAALEEChannelSelectViewController.h"
#import "WaitProgressShow.h"
#import "AudioToolbox/AudioToolbox.h"

@interface JAALEEChannelSelectViewController ()<JAALEEDeviceDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mDetectButton;

@end

@implementation JAALEEChannelSelectViewController
{
    BOOL CanShowMessage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CanShowMessage = true;
    
    if (_SELECT_ID == 1 || _SELECT_ID == 2 || _SELECT_ID == 3) {
        [_mDetectButton setAlpha:1];        
        [_mDetectButton startAnimating];
    }
    else
    {
        [_mDetectButton setAlpha:0];
    }
    
    if (_SELECT_ID == 0)
    {
        self.navigationItem.title = @"BASIC";
    }
    else if (_SELECT_ID == 1) {
        self.navigationItem.title = @"MOTION";
        [self.mConnectedBeacon startNotifyMotion];
    }
    else if (self.SELECT_ID == 2)
    {
        self.navigationItem.title = @"BUTTON";
        [self.mConnectedBeacon startNotifyButtonTouch];
    }
    else if (self.SELECT_ID == 3)
    {
        self.navigationItem.title = @"FALL";
        [self.mConnectedBeacon startNotifyFall];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    self.mConnectedBeacon.JAALEEdelegate = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.mConnectedBeacon.JAALEEdelegate = nil;
}

-(void)JAALEEDidFallDetected:(JAALEEDevice *)beacon
{
    if (_SELECT_ID == 3) {
//        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Warn Tip" message:@"Detect JAALEE's fall" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [view show];
        if (CanShowMessage) {
            [WaitProgressShow showSuccessWithStatus:@"Detected that the JAALEE was dropped"];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    }
}

- (void)JAALEEDidUpdateButtonTouch:(JAALEEDevice *)beacon withData:(JAALEE_BUTTON_TOUCH)Data Error:(NSError *)error
{
    if (_SELECT_ID == 2) {
//        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Warn Tip" message:@"Detect JAALEE's button touched" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [view show];
        if (CanShowMessage) {
            [WaitProgressShow showSuccessWithStatus:@"Detected the JAALEE button press"];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    }
}

- (void)JAALEEDidMotionDetected:(JAALEEDevice *)beacon
{
    if (_SELECT_ID == 1) {
//        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Warn Tip" message:@"Detect JAALEE's Motion" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [view show];
        if (CanShowMessage) {
            [WaitProgressShow showSuccessWithStatus:@"Detected JAALEE had a movement"];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) GetSelectChannel
{
    JAALEE_CHANNEL_SELECT ID;
    switch (_SELECT_ID) {
        case 0:
            ID =  _mConnectedBeacon.alwaysBroadcastChannel;
            break;
        case 1:
            ID =  _mConnectedBeacon.motionTriggerChannel;
            break;
        case 2:
            ID =  _mConnectedBeacon.buttonTouchTriggerChannel;
            break;
        case 3:
            ID =  _mConnectedBeacon.fallTriggerChannel;
            break;
        default:
            ID =  JAALEE_CHANNEL_NONE;
            break;
    }
    
    switch (ID) {
        case JAALEE_CHANNEL_IBEACON:
            return 1;
            break;
        case JAALEE_CHANNEL_CUSTOM_1:
            return 2;
            break;
        case JAALEE_CHANNEL_CUSTOM_2:
            return 3;
            break;
        case JAALEE_CHANNEL_NONE:
            return 0;
            break;
        default:
            return 0;
            break;
    }
}


#pragma mark tableView Methods
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            if (_SELECT_ID == 0) {
                return 6;
            }
            return 3;
            break;
        default:
            break;
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    if (_SELECT_ID == 1 || _SELECT_ID == 3 || _SELECT_ID == 0) {
        return 2;
    }
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"CHANNEL SELECT";
            break;
        case 1:
            if (_SELECT_ID == 0)
            {
                return @"BROADCAST INTERVAL";
            }
            return @"SENSOR SENSITIVE";
            break;
        case 2:
            return @"BROADCAST RATE";
            break;
        default:
            break;
    }
    return nil;
}

//-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView*v =[[UIView alloc]init];
//    [v setBackgroundColor:[UIColor clearColor]];
//    return v;
//}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    cell = [tv dequeueReusableCellWithIdentifier:@"CHANNELIDENTIFIER"];
    UILabel *Title = (UILabel*) [cell viewWithTag:1];
    
    if (_SELECT_ID == 1) {
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                [Title setText:@"Highly Sensitive"];
            }
            else if (indexPath.row == 1) {
                [Title setText:@"Medium Sensitive"];
            }
            else if (indexPath.row == 2) {
                [Title setText:@"Low Sensitive"];
            }
            
            if (self.mConnectedBeacon.motionSensitive == JAALEE_SENSOR_SENSITIVE_HIGH && indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else if (self.mConnectedBeacon.motionSensitive == JAALEE_SENSOR_SENSITIVE_MEDIUM && indexPath.row == 1)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else if (self.mConnectedBeacon.motionSensitive == JAALEE_SENSOR_SENSITIVE_LOW && indexPath.row == 2)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            return cell;
        }
    }
    else if (_SELECT_ID == 3)
    {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                [Title setText:@"Highly Sensitive"];
            }
            else if (indexPath.row == 1) {
                [Title setText:@"Medium Sensitive"];
            }
            else if (indexPath.row == 2) {
                [Title setText:@"Low Sensitive"];
            }
            
            if (self.mConnectedBeacon.fallSensitive == JAALEE_SENSOR_SENSITIVE_HIGH && indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else if (self.mConnectedBeacon.fallSensitive == JAALEE_SENSOR_SENSITIVE_MEDIUM && indexPath.row == 1)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else if (self.mConnectedBeacon.fallSensitive == JAALEE_SENSOR_SENSITIVE_LOW && indexPath.row == 2)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
        }
    }
    else if (_SELECT_ID == 0 && indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
                [Title setText:@"1s"];
                break;
            case 1:
                [Title setText:@"2s"];
                break;
            case 2:
                [Title setText:@"3s"];
                break;
            case 3:
                [Title setText:@"4s"];
                break;
            case 4:
                [Title setText:@"5s"];
                break;
            case 5:
                [Title setText:@"6s"];
                break;
            default:
                break;
        }
        
        NSLog(@"%@", self.mConnectedBeacon.advInterval);
        
        
        if (indexPath.row+1 == (int)([self.mConnectedBeacon.advInterval integerValue]/1000)) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    
    if (indexPath.row == [self GetSelectChannel]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    switch (indexPath.row) {
        case 0:
            [Title setText:@"None"];
            break;
        case 1:
            [Title setText:@"iBeacon Channel"];
            break;
        case 2:
            [Title setText:@"Custom Channel 1"];
            break;
        case 3:
            [Title setText:@"Custom Channel 2"];
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
         [self WriteValueBySelectChannel:indexPath.row];
    }
    else if (indexPath.section == 1)
    {
        [self WriteSensorZhongliang:indexPath.row];
    }
}

- (void) WriteSensorZhongliang:(NSInteger)ID
{
    
    if (_SELECT_ID == 0) {
        
        int Value;
        switch (ID) {
            case 0:
                Value = 1000;
                break;
            case 1:
                Value = 2000;
                break;
            case 2:
                Value = 3000;
                break;
            case 3:
                Value = 4000;
                break;
            case 4:
                Value = 5000;
                break;
            case 5:
                Value = 6000;
                break;
            default:
                Value = 2000;
                break;
        }
        
        CanShowMessage = false;
        [WaitProgressShow showWithStatus:@"Trying to change the broadcast interval of JAALEE"];
        
        [self.mConnectedBeacon writeAdvInterval:Value withCompletion:^(BOOL value, NSError* error)
         {
             [self.mTableView reloadData];
             if (value) {
                 CanShowMessage = true;
                 [WaitProgressShow showSuccessWithStatus:@"Broadcast interval changed successfully"];
             }
             else
             {
                 CanShowMessage = true;
                 if (error != nil && error.code == 100) {
                     [WaitProgressShow showErrorWithStatus:@"Network Error"];
                 }
                 else
                 {
                     [WaitProgressShow showErrorWithStatus:@"Broadcast interval changed failed"];
                 }
             }
         }];
        
        return;
    }
    
    
    
    JAALEE_SENSOR_SENSITIVE Sensitive;
    
    switch (ID) {
        case 0:
            Sensitive = JAALEE_SENSOR_SENSITIVE_HIGH;
            break;
        case 1:
            Sensitive = JAALEE_SENSOR_SENSITIVE_MEDIUM;
            break;
        case 2:
            Sensitive = JAALEE_SENSOR_SENSITIVE_LOW;
            break;
        default:
            Sensitive = JAALEE_SENSOR_SENSITIVE_HIGH;
            break;
    }
    
    CanShowMessage = false;
    [WaitProgressShow showWithStatus:@"Trying to change the sensitive of sensor"];
    
    if (_SELECT_ID == 1) {
        [self.mConnectedBeacon setJAALEEMotionSensitive:Sensitive WithCompletion:^(BOOL value, NSError* error)
         {
             [self.mTableView reloadData];
             if (value) {
                 CanShowMessage = true;
                 [WaitProgressShow showSuccessWithStatus:@"Sensitive changed successfully"];
             }
             else
             {
                 CanShowMessage = true;
                 if (error != nil && error.code == 100) {
                     [WaitProgressShow showErrorWithStatus:@"Network Error"];
                 }
                 else
                 {
                     [WaitProgressShow showErrorWithStatus:@"Sensitive changed failed"];
                 }
                 
             }
         }];
    }
    else
    {
        [self.mConnectedBeacon setJAALEEFallSensitive:Sensitive WithCompletion:^(BOOL value, NSError* error)
         {
             [self.mTableView reloadData];
             if (value) {
                 CanShowMessage = true;
                 [WaitProgressShow showSuccessWithStatus:@"Sensitive changed successfully"];
             }
             else
             {
                 CanShowMessage = true;
                 if (error != nil && error.code == 100) {
                     [WaitProgressShow showErrorWithStatus:@"Network Error"];
                 }
                 else
                 {
                     [WaitProgressShow showErrorWithStatus:@"Sensitive changed failed"];
                 }
             }
         }];
    }

}

-(void) WriteValueBySelectChannel:(NSInteger)ID
{
    JAALEE_CHANNEL_SELECT channel;
    switch (ID) {
        case 0:
            channel = JAALEE_CHANNEL_NONE;
            break;
        case 1:
            channel = JAALEE_CHANNEL_IBEACON;
            break;
        case 2:
            channel = JAALEE_CHANNEL_CUSTOM_1;
            break;
        case 3:
            channel = JAALEE_CHANNEL_CUSTOM_2;
            break;
        default:
            channel = JAALEE_CHANNEL_NONE;
            break;
    }
    
    if (_SELECT_ID == 0) {
        CanShowMessage = false;
        [WaitProgressShow showWithStatus:@"Trying to change the channel"];
        [self.mConnectedBeacon selectJAALEEalwaysBroadcastChannel:channel WithCompletion:[self completion]];
    }
    else if (_SELECT_ID == 1)
    {
        CanShowMessage = false;
        [WaitProgressShow showWithStatus:@"Trying to change the channel"];
        [self.mConnectedBeacon selectJAALEEmotionTriggerChannel:channel WithCompletion:[self completion]];
    }
    else if (_SELECT_ID == 2)
    {
        CanShowMessage = false;
        [WaitProgressShow showWithStatus:@"Trying to change the channel"];
        [self.mConnectedBeacon selectJAALEEbuttonTouchTriggerChannel:channel WithCompletion:[self completion]];
    }
    else if (_SELECT_ID == 3)
    {
        CanShowMessage = false;
        [WaitProgressShow showWithStatus:@"Trying to change the channel"];
        [self.mConnectedBeacon selectJAALEEfallTriggerChannel:channel WithCompletion:[self completion]];
    }
}

-(JAALEEBoolCompletionBlock)completion
{
    return ^(BOOL value, NSError* error)
    {
        [self.mTableView reloadData];
        if (value) {
            [WaitProgressShow showSuccessWithStatus:@"Channel changed successfully"];
            CanShowMessage = true;
        }
        else
        {
            if (error != nil && error.code == 100) {
                [WaitProgressShow showErrorWithStatus:@"Network Error"];
            }
            else
            {
                [WaitProgressShow showErrorWithStatus:@"Channel changed failed"];
            }
            CanShowMessage = true;
        }
    };
}

@end
