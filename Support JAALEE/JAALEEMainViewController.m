//
//  JAALEEMainViewController.m
//  eBeacon
//
//  Created by jaalee on 15/9/7.
//  Copyright (c) 2015年 jaalee. All rights reserved.
//

#import "JAALEEMainViewController.h"
#import <JAALEE_SDK/JAALEESDK.h>
#import "WaitProgressShow.h"
#import "JAALEECONFIGUREViewController.h"


#define JAALEE_CURRENT_TEST_NO_SERVER false

//#define JAALEE_CLOUD_API_KEY @"YOUR DEVELOPER KEY"
#define JAALEE_CLOUD_API_KEY @"lM3Pdkxy5SWJRnwsaXpBVAvrKgHOiueq"


@interface JAALEEMainViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, JAALEEConfigureManagerDelegate, JAALEEDeviceDelegate>

@property (weak, nonatomic) IBOutlet UIView *mScanView;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIButton *mTotalCount;

@property (weak, nonatomic) IBOutlet UIButton *mBtnAbout;
@property (nonatomic, strong) JAALEEConfigureManager *JAALEEBLEManager;
@property (weak, nonatomic) IBOutlet UIImageView *mShowCycle;
@end

@implementation JAALEEMainViewController
{
    NSMutableArray *mCurrentScanedArray;
    
    JAALEEDevice *mConnectedBeacon;
}

- (IBAction)OnTouchBuyIt:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.jaalee.com/store/cart?id=16&count=1&color=black"]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem.title = @"BACK";
    
    [_mBtnAbout setTitle:@"Get It" forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
    self.mTableView.tableFooterView = [[UIView alloc]init];
    
    _JAALEEBLEManager = [[JAALEEConfigureManager alloc] init];
    _JAALEEBLEManager.delegate = self;
    

    mCurrentScanedArray = [[NSMutableArray alloc] init];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15,0,320,20)];
    
    //    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.opaque = NO;
    //    label.textColor = [UIColor lightGrayColor];
    label.highlightedTextColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    
    [label setBackgroundColor:[UIColor clearColor]];
    
    label.text = @"Scanning for JAALEE...";
    
    [self.mTableView addSubview:label];
}

-(void) ScanJAALEEBeacon:(BOOL)Scan
{
    _JAALEEBLEManager.delegate = self;
    if (Scan) {
        [_JAALEEBLEManager startDiscoveryJAALEE];
    }
    else
    {
        [_JAALEEBLEManager stopJAALEEDiscovery];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.JAALEEBLEManager setJAALEEDeveloperAPIKey:JAALEE_CLOUD_API_KEY];
    [self ScanJAALEEBeacon:true];
    
    [mCurrentScanedArray removeAllObjects];
    [_mTableView reloadData];
    [self.mTotalCount setTitle:[NSString stringWithFormat:@"Total:%d", mCurrentScanedArray.count] forState:UIControlStateNormal];
    
    if (mConnectedBeacon) {
        [mConnectedBeacon disconnectJAALEE];
        mConnectedBeacon = nil;
    }
}

#pragma mark JAALEEBeaconConfigManagerDelegate Methods
- (void)JAALEEConfigureManager:(JAALEEConfigureManager *)manager networkError:(NSError *)error
{
    NSLog(@"JAALEE ERROR:%@", error);
}

- (void)JAALEEConfigureManager:(JAALEEConfigureManager *)manager didDiscoverJAALEE:(JAALEEDevice *)JAALEE RSSI:(NSNumber *)RSSI
{
//    if ([RSSI intValue] > 0 || [RSSI intValue] <= -35)
//    {
//        return;//排除
//    }
    
    if (![mCurrentScanedArray containsObject:JAALEE]) {
        [mCurrentScanedArray addObject:JAALEE];
    }
    else
    {
        [mCurrentScanedArray replaceObjectAtIndex:[mCurrentScanedArray indexOfObject:JAALEE] withObject:JAALEE];
    }
    
    [self.mTableView reloadData];
    
    [self.mTotalCount setTitle:[NSString stringWithFormat:@"Total:%d", mCurrentScanedArray.count] forState:UIControlStateNormal];
}


#pragma mark tableView Methods
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return mCurrentScanedArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Scaning";
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*v =[[UIView alloc]init];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tv dequeueReusableCellWithIdentifier:@"JAALEETableCell"];
    
    JAALEEDevice *device = [mCurrentScanedArray objectAtIndex:indexPath.row];
    
    UILabel *Name = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *Rssi = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *ID = (UILabel *)[cell.contentView viewWithTag:3];
    UIImageView *Connectable = (UIImageView*) [cell.contentView viewWithTag:4];
    UIImageView *ConnectableState = (UIImageView*) [cell.contentView viewWithTag:5];
    
    
    if (device.isConnectable) {
        [Connectable setImage:[UIImage imageNamed:@"JAALEE_Img_Connectable.png"]];
        [ConnectableState setImage:[UIImage imageNamed:@"JAALEE_Connectable.png"]];
    }
    else
    {
        [Connectable setImage:[UIImage imageNamed:@"JAALEE_Img_Non_Connectable.png"]];
        [ConnectableState setImage:[UIImage imageNamed:@"JAALEE_Non_Connectable.png"]];
    }
    
    if (device.name.length != 0) {
        Name.text = device.name;
    }
    else
    {
        Name.text = @"Peripheral";
    }
    
    Rssi.text =  [NSString stringWithFormat:@"%d", device.rssi];
    ID.text = [device.JAALEEID uppercaseString];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
    JAALEEDevice *device = [mCurrentScanedArray objectAtIndex:indexPath.row];
    

    if (device.isConnectable)
    {
        [WaitProgressShow showWithStatus:@"Trying to connect JAALEE"];
        device.delegate = self;
        [device connectJAALEE];
    }
    else
    {
        [WaitProgressShow showErrorWithStatus:@"Current JAALEE is in Non-Connectable Mode"];
    }
}

#pragma JAALEE DEVICE
- (void)JAALEEConnectionDidSucceeded:(JAALEEDevice *)beacon
{
    [WaitProgressShow dismiss];
    [self performSegueWithIdentifier:@"JAALEECONFIGURE" sender:beacon];
}
- (void)JAALEEDidDisconnect:(JAALEEDevice *)beacon withError:(NSError *)error
{
    [self.navigationController popToRootViewControllerAnimated:true];
    [WaitProgressShow showErrorWithStatus:@"Failed to connect JAALEE"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     if ([segue.identifier isEqualToString: @"JAALEECONFIGURE"])
     {
         JAALEECONFIGUREViewController *detailViewController = (JAALEECONFIGUREViewController*) segue.destinationViewController;
         detailViewController.mConnectedBeacon = sender;
         
         mConnectedBeacon = sender;
     }
}

@end
