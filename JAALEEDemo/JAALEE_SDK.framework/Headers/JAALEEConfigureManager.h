//
//  JAALEEConfigureManager.h
//  JAALEESDK
//
//  Created by jaalee on 15-8-22.
//  Copyright (c) 2015年 JAALEE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JAALEEDevice.h"


@class JAALEEConfigureManager;

/**
 
 The JAALEEConfigureManagerDelegate protocol defines the delegate methods to respond for related events.
 */

@protocol JAALEEConfigureManagerDelegate <NSObject>

@required

/**
 * Delegate method invoked to handle discovered
 * JAALEEDevice objects using CoreBluetooth framework.
 *
 * @param manager JAALEE CONFIGURE MANAGER
 * @param JAALEE discovered JAALEE
 *
 * @return void
 */
- (void)JAALEEConfigureManager:(JAALEEConfigureManager *)manager didDiscoverJAALEE:(JAALEEDevice *)JAALEE RSSI:(NSNumber *)RSSI;

/**
 * Delegate method invoked to handle network rrror
 *
 * @param manager JAALEE CONFIGURE MANAGER
 * @param JAALEE discovered JAALEE
 *
 * @return void
 */
- (void)JAALEEConfigureManager:(JAALEEConfigureManager *)manager networkError:(NSError *)error;

@optional

@end


@interface JAALEEConfigureManager : NSObject

@property (nonatomic, weak) id <JAALEEConfigureManagerDelegate> delegate;


/// @name CoreBluetooth based utility methods

/**
 * Start JAALEE discovery process based on CoreBluetooth
 * framework.
 *
 *
 * @return void
 */
-(BOOL)startDiscoveryJAALEE;

/**
 * Stops CoreBluetooth based JAALEE discovery process.
 *
 * @return void
 */
-(BOOL)stopJAALEEDiscovery;


/**
 * set JAALEE developer API KEY. you can get from https://cloud.jaalee.com/user/profile
 * 
 * @return void
 */
-(BOOL) setJAALEEDeveloperAPIKey:(NSString*)key;
@end
