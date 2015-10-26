//
//  JAALEETXPOWERSETTINGViewController.m
//  eBeacon
//
//  Created by jaalee on 15/9/11.
//  Copyright (c) 2015年 jaalee. All rights reserved.
//

#import "JAALEETXPOWERSETTINGViewController.h"
#import "WaitProgressShow.h"

@interface JAALEETXPOWERSETTINGViewController ()<JAALEEDeviceDelegate>

@property (weak, nonatomic) IBOutlet UIButton *mRssiValue;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@end

@implementation JAALEETXPOWERSETTINGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    self.mConnectedBeacon.JAALEEdelegate = self;
    [self.mConnectedBeacon readRSSI];
}

 -(void)viewDidDisappear:(BOOL)animated
{
    self.mConnectedBeacon.JAALEEdelegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)JAALEEDidUpdateRssi:(JAALEEDevice *)beacon Error:(NSError *)error
{
    [beacon readRSSI];
    [_mRssiValue setTitle:[NSString stringWithFormat:@"RSSI:%d", beacon.rssi] forState:UIControlStateNormal];
}

#pragma mark tableView Methods
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"TX POWER";
            break;
        default:
            break;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    UILabel *Title;
    
    cell = [tv dequeueReusableCellWithIdentifier:@"CHANNELIDENTIFIER"];
    Title = (UILabel*) [cell viewWithTag:1];
    
    switch (indexPath.row) {
        case 0:
            [Title setText:@"+4 dBm"];
            break;
        case 1:
            [Title setText:@"0 dBm"];
            break;
        case 2:
            [Title setText:@"-4 dBm"];
            break;
        case 3:
            [Title setText:@"-8 dBm"];
            break;
        case 4:
            [Title setText: @"-12 dBm"];
            break;
        case 5:
            [Title setText: @"-16 dBm"];
            break;
        case 6:
            [Title setText: @"-20 dBm"];
            break;
        case 7:
            [Title setText: @"-30 dBm"];
            break;
        case 8:
            [Title setText: @"-40 dBm"];
            break;
        default:
            [Title setText: @"0 dBm"];
            break;
    }
    
    if (self.mConnectedBeacon.txPower == [self GETIDByTXPower:indexPath.row])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(JAALEETXPower) GETIDByTXPower:(NSInteger)ID
{
    JAALEETXPower Power;
    switch (ID) {
        case 0:
            Power = JAALEEPowerLevel1;
            break;
        case 1:
            Power = JAALEEPowerLevel2;
            break;
        case 2:
            Power = JAALEEPowerLevel3;
            break;
        case 3:
            Power = JAALEEPowerLevel4;
            break;
        case 4:
            Power = JAALEEPowerLevel5;
            break;
        case 5:
            Power = JAALEEPowerLevel6;
            break;
        case 6:
            Power = JAALEEPowerLevel7;
            break;
        case 7:
            Power = JAALEEPowerLevel8;
            break;
        case 8:
            Power = JAALEEPowerLevel9;
            break;
    }
    return Power;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    [self HanleSelect:indexPath.row];
}

- (void) HanleSelect:(NSInteger)ID
{
    JAALEETXPower Power;
    switch (ID) {
        case 0:
            Power = JAALEEPowerLevel1;
            break;
        case 1:
            Power = JAALEEPowerLevel2;
            break;
        case 2:
            Power = JAALEEPowerLevel3;
            break;
        case 3:
            Power = JAALEEPowerLevel4;
            break;
        case 4:
            Power = JAALEEPowerLevel5;
            break;
        case 5:
            Power = JAALEEPowerLevel6;
            break;
        case 6:
            Power = JAALEEPowerLevel7;
            break;
        case 7:
            Power = JAALEEPowerLevel8;
            break;
        case 8:
            Power = JAALEEPowerLevel9;
            break;
        default:
            Power = JAALEEPowerLevel2;
            break;
    }
    
    [WaitProgressShow showWithStatus:@"Trying to change the txPower of JAALEE"];
    
    [self.mConnectedBeacon writeJAALEETxPower:Power withCompletion:^(BOOL value, NSError *error){
        if (value) {
            [self.mTableView reloadData];
            [WaitProgressShow showSuccessWithStatus:@"TxPower changed successfully"];
        }
        else
        {
            if (error != nil && error.code == 100) {
                [WaitProgressShow showErrorWithStatus:@"Network Error"];
            }
            else
            {
                [WaitProgressShow showErrorWithStatus:@"TxPower changed failed"];
            }
        }
    }];
}


@end
