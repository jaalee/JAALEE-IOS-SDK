//
//  JAALEEChannelSelectViewController.h
//  eBeacon
//
//  Created by jaalee on 15/9/11.
//  Copyright (c) 2015年 jaalee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JAALEE_SDK/JAALEESDK.h>

@interface JAALEEChannelSelectViewController : UIViewController

@property (nonatomic) NSInteger SELECT_ID;//Beacon
@property (strong, nonatomic) JAALEEDevice *mConnectedBeacon;//Beacon

@end
