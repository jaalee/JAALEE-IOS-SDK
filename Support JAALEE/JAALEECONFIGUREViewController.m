//
//  JAALEECONFIGUREViewController.m
//  eBeacon
//
//  Created by jaalee on 15/9/8.
//  Copyright (c) 2015年 jaalee. All rights reserved.
//

#import "JAALEECONFIGUREViewController.h"
#import "JAALEEDATAConfigureViewController.h"
#import "JAALEEChannelSelectViewController.h"
#import "JAALEETXPOWERSETTINGViewController.h"
#import "WaitProgressShow.h"

@interface JAALEECONFIGUREViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation JAALEECONFIGUREViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.backBarButtonItem.title = @"BACK";
}
- (IBAction)OnTouchCallJAALEE:(id)sender {
    [_mConnectedBeacon callJAALEE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.mTableView reloadData];
}


#pragma mark tableView Methods
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 2;
            break;
        default:
            break;
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"CHANNEL DATA CONFIGURE";
            break;
        case 1:
            return @"BEACON MODE CONFIGURE";
            break;
        case 2:
            return @"JAALEE BASIC SETTING";
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

-(NSString*) ChannelStringeWithChannel:(JAALEE_CHANNEL_SELECT)channel
{
    switch (channel) {
        case JAALEE_CHANNEL_NONE:
            return @"None";
            break;
        case JAALEE_CHANNEL_IBEACON:
            return @"iBeacon Channel";
            break;
        case JAALEE_CHANNEL_CUSTOM_1:
            return @"Custom Channel 1";
            break;
        case JAALEE_CHANNEL_CUSTOM_2:
            return @"Custom Channel 2";
            break;
        default:
            return @"None";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    UILabel *Title, *SubTitle;
    UISwitch *Switch;
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell = [tv dequeueReusableCellWithIdentifier:@"JAALEETITLE"];
                    Title = (UILabel*) [cell viewWithTag:1];
                    [Title setText:@"iBeacon Channel"];
                    break;
                case 1:
                    cell = [tv dequeueReusableCellWithIdentifier:@"JAALEETITLE"];
                    Title = (UILabel*) [cell viewWithTag:1];
                    [Title setText:@"Custom Channel 1"];
                    break;
                case 2:
                    cell = [tv dequeueReusableCellWithIdentifier:@"JAALEETITLE"];
                    Title = (UILabel*) [cell viewWithTag:1];
                    [Title setText:@"Custom Channel 2"];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell = [tv dequeueReusableCellWithIdentifier:@"JAALEETITLESUBTITLE"];
                    Title = (UILabel*) [cell viewWithTag:1];
                    [Title setText:@"Always Broadcast Channel Select"];
                    
                    SubTitle = (UILabel*) [cell viewWithTag:2];
                    [SubTitle setText:[self ChannelStringeWithChannel:self.mConnectedBeacon.alwaysBroadcastChannel]];
                    break;
                case 1:
                    cell = [tv dequeueReusableCellWithIdentifier:@"JAALEETITLESUBTITLE"];
                    Title = (UILabel*) [cell viewWithTag:1];
                    [Title setText:@"Motion Trigger Channel Select"];
                    
                    SubTitle = (UILabel*) [cell viewWithTag:2];
                    [SubTitle setText:[self ChannelStringeWithChannel:self.mConnectedBeacon.motionTriggerChannel]];
                    break;
                case 2:
                    cell = [tv dequeueReusableCellWithIdentifier:@"JAALEETITLESUBTITLE"];
                    Title = (UILabel*) [cell viewWithTag:1];
                    [Title setText:@"Button Touch Trigger Channel Select"];
                    
                    SubTitle = (UILabel*) [cell viewWithTag:2];
                    [SubTitle setText:[self ChannelStringeWithChannel:self.mConnectedBeacon.buttonTouchTriggerChannel]];
                    break;
                case 3:
                    cell = [tv dequeueReusableCellWithIdentifier:@"JAALEETITLESUBTITLE"];
                    Title = (UILabel*) [cell viewWithTag:1];
                    [Title setText:@"Fall Trigger Channel Select"];
                    
                    SubTitle = (UILabel*) [cell viewWithTag:2];
                    [SubTitle setText:[self ChannelStringeWithChannel:self.mConnectedBeacon.fallTriggerChannel]];
                    break;
                case 4:
                    cell = [tv dequeueReusableCellWithIdentifier:@"JAALEETITLESWITCH"];
                    Title = (UILabel*) [cell viewWithTag:1];
                    [Title setText:@"Broadcast Mode Connectable"];
                    
                    Switch = (UISwitch*) [cell viewWithTag:2];
                    [Switch setOn:self.mConnectedBeacon.broadcastModeConnectable];
                    
                    [Switch addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventValueChanged];
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    cell = [tv dequeueReusableCellWithIdentifier:@"JAALEETITLESUBTITLE"];
                    Title = (UILabel*) [cell viewWithTag:1];
                    [Title setText:@"Device Name"];
                    
                    SubTitle = (UILabel*) [cell viewWithTag:2];
                    [SubTitle setText:self.mConnectedBeacon.name];
                    break;
                case 1:
                    cell = [tv dequeueReusableCellWithIdentifier:@"JAALEETITLESUBTITLE"];
                    Title = (UILabel*) [cell viewWithTag:1];
                    [Title setText:@"Tx Power"];
                    
                    SubTitle = (UILabel*) [cell viewWithTag:2];
                    [SubTitle setText:[self TxPowerString]];
                    break;
                default:
                    break;
            }
            break;
            
            
        default:
            break;
    }
    
    return cell;
}

- (IBAction)updateSwitchAtIndexPath:(id)sender {
    UISwitch *switchView = (UISwitch *)sender;
    [WaitProgressShow showWithStatus:@"Trying to change the JAALEE state"];
    [self.mConnectedBeacon configureJAALEEBroadcastAlwaysConnectable:switchView.isOn WithCompletion:^(BOOL value, NSError *error){
        
        [self.mTableView reloadData];
        if (value) {
            [WaitProgressShow showSuccessWithStatus:@"state change successfully"];
        }
        else
        {
            if (error != nil && error.code == 100) {
                [WaitProgressShow showErrorWithStatus:@"Network Error"];
            }
            else
            {
                [WaitProgressShow showErrorWithStatus:@"state change failed"];
            }
        }
    }];

}



-(NSString*) TxPowerString
{
    switch (self.mConnectedBeacon.txPower) {
        case JAALEEPowerLevel1:
            return @"+4 dBm";
            break;
        case JAALEEPowerLevel2:
            return @"0 dBm";
            break;
        case JAALEEPowerLevel3:
            return @"-4 dBm";
            break;
        case JAALEEPowerLevel4:
            return @"-8 dBm";
            break;
        case JAALEEPowerLevel5:
            return @"-12 dBm";
            break;
        case JAALEEPowerLevel6:
            return @"-16 dBm";
            break;
        case JAALEEPowerLevel7:
            return @"-20 dBm";
            break;
        case JAALEEPowerLevel8:
            return @"-30 dBm";
            break;
        case JAALEEPowerLevel9:
            return @"-40 dBm";
            break;
        default:
            return @"0 dBm";
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UISwitch *switchView;
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [self performSegueWithIdentifier:@"JAALEEDATACONFIGURE" sender:[NSNumber numberWithInteger:0]];
                    break;
                case 1:
                    [self performSegueWithIdentifier:@"JAALEEDATACONFIGURE" sender:[NSNumber numberWithInteger:1]];
                    break;
                case 2:
                    [self performSegueWithIdentifier:@"JAALEEDATACONFIGURE" sender:[NSNumber numberWithInteger:2]];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [self performSegueWithIdentifier:@"ChannelSelect" sender:[NSNumber numberWithInteger:0]];
                    break;
                case 1:
                    [self performSegueWithIdentifier:@"ChannelSelect" sender:[NSNumber numberWithInteger:1]];
                    break;
                case 2:
                    [self performSegueWithIdentifier:@"ChannelSelect" sender:[NSNumber numberWithInteger:2]];
                    break;
                case 3:
                    [self performSegueWithIdentifier:@"ChannelSelect" sender:[NSNumber numberWithInteger:3]];
                    break;
                case 4:
                    switchView = (UISwitch*)[cell.contentView viewWithTag:2];
                    [switchView setOn:!switchView.isOn animated:true];
                    [self updateSwitchAtIndexPath:switchView];
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    [self StartInPutName];
                    break;
                case 1:
                    [self performSegueWithIdentifier:@"JAALEECHANGETX" sender:nil];

                    break;
                default:
                    break;
            }
            break;
            
            
        default:
            break;
    }
}

-(void) StartInPutName
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please input the new name" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.delegate = self;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 55;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    printf("点击了%d", buttonIndex);
    
    if (alertView.tag == 55)
    {
        UITextField *temp = [alertView textFieldAtIndex:0];
        if (temp.text.length == 0) {
            [WaitProgressShow showErrorWithStatus:@"Please input the new name first"];
        }
        else if (temp.text.length>= 1 && temp.text.length <=18)
        {
            [WaitProgressShow showWithStatus:@"Trying to change the JAALEE name"];
            [self.mConnectedBeacon writeJAALEEName:temp.text withCompletion:^(BOOL value, NSError* error)
             {
                 [self.mTableView reloadData];
                 if (value) {
                     [WaitProgressShow showSuccessWithStatus:@"Name change successfully"];
                 }
                 else
                 {
                     if (error != nil && error.code == 100) {
                         [WaitProgressShow showErrorWithStatus:@"Network Error"];
                     }
                     else
                     {
                         [WaitProgressShow showErrorWithStatus:@"Name change failed"];
                     }
                 }
             }];
        }
    }
}

#pragma JAALEE DEVICE
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"JAALEEDATACONFIGURE"])
    {
        JAALEEDATAConfigureViewController *detailViewController = (JAALEEDATAConfigureViewController*) segue.destinationViewController;
        detailViewController.mConnectedBeacon = self.mConnectedBeacon;
        detailViewController.SELECT_ID = [sender integerValue];
    }
    else if ([segue.identifier isEqualToString: @"ChannelSelect"])
    {
        JAALEEChannelSelectViewController *detailViewController = (JAALEEChannelSelectViewController*) segue.destinationViewController;
        detailViewController.mConnectedBeacon = self.mConnectedBeacon;
        detailViewController.SELECT_ID = [sender integerValue];
    }
    else if ([segue.identifier isEqualToString: @"JAALEECHANGETX"])
    {
        JAALEETXPOWERSETTINGViewController *detailViewController = (JAALEETXPOWERSETTINGViewController*) segue.destinationViewController;
        detailViewController.mConnectedBeacon = self.mConnectedBeacon;
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
