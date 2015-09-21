//
//  JAALEEdevice.h
//  JAALEESDK
//
//  Created by jaalee on 15-8-22.
//  Copyright (c) 2015年 JAALEE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "JAALEEDefinitions.h"



@class JAALEEDevice;

////////////////////////////////////////////////////////////////////
// JAALEE device delegate protocol


/**
 
 JAALEEDeviceDelegate defines JAALEE connection delegate mathods. Connection is asynchronous operation so you need to be prepared that eg. JAALEEDidDisconnect: method can be invoked without previous action.
 
 */

@protocol JAALEEDeviceDelegate <NSObject>

@optional

/**
 * Delegate method that indicates error in JAALEE connection.
 *
 * @param jaalee reference to JAALEE object
 * @param error information about reason of error
 *
 * @return void
 */
- (void)JAALEEConnectionDidFail:(JAALEEDevice*)jaalee withError:(NSError*)error;

/**
 * Delegate method that indicates success in JAALEE connection.
 *
 * @param jaalee reference to JAALEE object
 *
 * @return void
 */
- (void)JAALEEConnectionDidSucceeded:(JAALEEDevice*)jaalee;

/**
 * Delegate method that did disconnect with JAALEE.
 *
 * @param jaalee reference to JAALEE object
 * @param error information about reason of error
 *
 * @return void
 */
- (void)JAALEEDidDisconnect:(JAALEEDevice*)jaalee withError:(NSError*)error;


/**
 * Delegate method that JAALEE did update rssi.
 *
 * @param jaalee reference to JAALEE object
 * @param error information about reason of error
 *
 * @return void
 */
- (void)JAALEEDidUpdateRssi:(JAALEEDevice*)jaalee Error:(NSError*)error;


/**
 * Delegate method that JAALEE did Touched button.
 *
 * @param jaalee reference to JAALEE object
 * @param Data reference to JAALEE_BUTTON_TOUCH object
 * @param error information about reason of error
 *
 * @return void
 */
- (void)JAALEEDidUpdateButtonTouch:(JAALEEDevice*)jaalee withData:(JAALEE_BUTTON_TOUCH)Data Error:(NSError*)error;

/**
 * Delegate method that JAALEE Motion detected.
 *
 * @param jaalee reference to JAALEE object
 * @param Data reference to JAALEE_BUTTON_TOUCH object
 * @param error information about reason of error
 *
 * @return void
 */
- (void)JAALEEDidMotionDetected:(JAALEEDevice*)jaalee;

/**
 * Delegate method that JAALEE fall detected.
 *
 * @param jaalee reference to JAALEE object
 * @param Data reference to JAALEE_BUTTON_TOUCH object
 * @param error information about reason of error
 *
 * @return void
 */
- (void)JAALEEDidFallDetected:(JAALEEDevice*)jaalee;
@end

////////////////////////////////////////////////////////////////////
// Interface definition

/**
 
 It allows to connect with JAALEE to read / change its configurtion.
 
 */

@interface JAALEEDevice : NSObject


@property (nonatomic, weak)     id <JAALEEDeviceDelegate>  delegate;

/// @name Publicly available properties
/**
 *  rssi
 *
 *    Received signal strength in decibels of the specified JAALEE device.
 *    This value is an average of the RSSI samples collected since this beacon was last reported.
 *
 */
@property (nonatomic, readonly)           NSInteger               rssi;


/**
 *  JAALEEID
 *
 *  Discussion:
 *    ID of the JAALEE device.
 */
@property (nonatomic, strong, readonly)   NSString*               JAALEEID;


/**
 *  isConnectable
 *
 *    Whether the JAALEE can be connected
 *
 */
@property (nonatomic, readonly)           BOOL               isConnectable;

/**
 *  isConnected
 *
 *    Flag indicating connection status.
 */
@property (nonatomic, readonly)   BOOL                  isConnected;

/**
 *  name
 *
 *  Discussion:
 *    name of the JAALEE.
 */
@property (nonatomic, readonly)   NSString*               name;

/////////////////////////////////////////////////////
// @name Properties available after connection

/**
 *  batteryLevel
 *
 *    Battery strength in %. Battery level change from 100% - 0%. Value available after connection with the JAALEE
 */
@property (nonatomic, strong, readonly)   NSNumber*               batteryLevel;

/**
 *  firmwareVersion
 *
 *    Battery strength in %. Battery level change from 100% - 0%. Value available after connection with the JAALEE
 */
@property (nonatomic, strong, readonly)   NSString*               firmwareVersion;

/**
 *  proximityUUID
 *
 *    Proximity UUID identifier read from the JAALEE device.
 *
 */
@property (nonatomic, strong, readonly)   NSString*                 proximityUUID;

/**
 *  major
 *
 *    major value read from the JAALEE device.
 *
 */
@property (nonatomic, strong, readonly)   NSNumber*               major;

/**
 *  minor
 *
 *    minor value read from the JAALEE device.
 *
 */
@property (nonatomic, strong, readonly)   NSNumber*               minor;

/**
 *  measuredPower
 *
 *    Measured Power value read from the JAALEE device.
 */
@property (nonatomic, strong, readonly)   NSNumber*               measuredPower;

/**
 *  txPower
 *
 *    Power of signal in dBm. Value available after connection with the JAALEE. It takes one of the values represented by JAALEETXPower .
 */
@property (nonatomic, readonly)   JAALEETXPower               txPower;

/**
 *  advInterval
 *
 *  Advertising interval of the JAALEE. Value change from 100ms to 10000ms. Value available after connection with the JAALEE
 */
@property (nonatomic, strong, readonly)   NSNumber*               advInterval;

/**
 *  alwaysBroadcastChannel
 *
 *  The channel choose for always broadcast
 */
@property (nonatomic, readonly)   JAALEE_CHANNEL_SELECT      alwaysBroadcastChannel;

/**
 *  motionTriggerChannel
 *
 *  The channel choose for motion trigger broadcast
 */
@property (nonatomic, readonly)   JAALEE_CHANNEL_SELECT      motionTriggerChannel;

/**
 *  buttonTouchTriggerChannel
 *
 *  The channel choose for button touch trigger broadcast
 */
@property (nonatomic, readonly)   JAALEE_CHANNEL_SELECT      buttonTouchTriggerChannel;

/**
 *  fallTriggerChannel
 *
 *  The channel choose for fall trigger broadcast
 */
@property (nonatomic, readonly)   JAALEE_CHANNEL_SELECT      fallTriggerChannel;


/**
 *  motionSensitive
 *
 *  The sensitive of motion detect, @see JAALEE_BEACON_SENSOR_SENSITIVE
 */
@property (nonatomic, readonly)   JAALEE_SENSOR_SENSITIVE    motionSensitive;


/**
 *  fallSensitive
 *
 *  The sensitive of fall detect, @see JAALEE_BEACON_SENSOR_SENSITIVE
 */
@property (nonatomic, readonly)   JAALEE_SENSOR_SENSITIVE    fallSensitive;


/**
 *  broadcastModeConnectable
 *
 *  The broadcast mode of JAALEE.
 *  true:Connectable false:Non-Connectable
 */
@property (nonatomic, readonly)   BOOL                              broadcastModeConnectable;


/// @name Connection handling methods


/**
 * Connect to particular JAALEE using bluetooth.
 * Connection is required to change values like
 * UUID, Major, Minor, Power, Advertising interval and so on.
 *
 * @return void
 */
-(void)connectJAALEE;

/**
 * Disconnect JAALEE device
 *
 * @return void
 */
-(void)disconnectJAALEE;

/// @name Methods for writing JAALEE configuration

/**
 * Writes Proximity UUID param to bluetooth connected JAALEE.
 *
 * @param pUUID new iBeacon channel Proximity UUID value
 * @param completion block handling operation completion
 *
 * @return void
 */
- (void)writeIBeaconChannelProximityUUID:(NSString*)pUUID withCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Writes major param to bluetooth connected JAALEE.
 *
 * @param major iBeacon channel major value
 * @param completion block handling operation completion
 *
 * @return void
 */
- (void)writeIBeaconChannelMajor:(unsigned short)major withCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Writes minor param to bluetooth connected JAALEE.
 *
 * @param minor iBeacon channel minor value
 * @param completion block handling operation completion
 *
 * @return void
 */
- (void)writeIBeaconChannelMinor:(unsigned short)minor withCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Writes measured power param to bluetooth connected JAALEE.
 *
 * @param measuredPower iBeacon channel measured power value
 * @param completion block handling operation completion
 *
 * @return void
 */
- (void)writeIBeaconChannelMesauredPower:(unsigned short)measuredPower withCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Writes advertising interval (in milisec) of connected JAALEE. Note that the value is valid only for the alwaysBroadcastMode
 *
 * @param advertising interval of beacon (1000 - 10000 ms)
 * @param completion block handling operation completion
 *
 * @return void
 */
- (void)writeAdvInterval:(unsigned short)interval withCompletion:(JAALEEBoolCompletionBlock)completion;


/**
 * Writes txPower of bluetooth connected JAALEE.
 *
 * @param txPower advertising JAALEE power (can take value from JAALEEBeaconPowerLevel1 / waak to JAALEEBeaconPowerLevel9 / strong)
 * @param completion block handling operation completion
 *
 * @return void
 */
- (void)writeJAALEETxPower:(JAALEETXPower)txPower withCompletion:(JAALEEBoolCompletionBlock)completion;


/**
 * Writes device name of bluetooth connected JAALEE.
 *
 * @param name JAALEE device name (lenth <= 15), For example @“jaalee”.
 * @param completion block handling operation completion
 *
 * @return void
 */
- (void)writeJAALEEName:(NSString*)name withCompletion:(JAALEEBoolCompletionBlock)completion;


/**
 * Configure JAALEE based iBeacon channel data with ProximityUUID,Major,Minor and so on, you can also change UUID use writeBeaconProximityUUID method;
 *
 * @param ProximityUUID new iBeacon channel Proximity UUID value.
 * @param major new iBeacon channel major value.
 * @param minor new iBeacon channel minor value.
 * @param measuredPowerValue new iBeacon channel measured power value.
 * @param completion block handling operation completion.
 *
 * @return void
 */
- (void) configureIBeaconChannel:(NSString*)ProximityUUID Major:(short int)major Minor:(short int)minor measuredPowerValue:(int)measuredPowerValue WithCompletion:(JAALEEBoolCompletionBlock)completion;


/**
 * Configure JAALEE Custom channel one's data as iBeacon Data;
 *
 * @param ProximityUUID new iBeacon channel Proximity UUID value.
 * @param major new iBeacon channel major value.
 * @param minor new iBeacon channel minor value.
 * @param measuredPowerValue new iBeacon channel measured power value.
 * @param completion block handling operation completion.
 *
 * @return void
 */
- (void) configureCustomChannelOneAsIBeacon:(NSString*)ProximityUUID Major:(short int)major Minor:(short int)minor measuredPowerValue:(int)measuredPowerValue WithCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Configure JAALEE Custom channel one's data as Eddystone-UID Data;
 *
 * @param namespaceID Eddystone-UID namespace ID, Lenth = 10 bytes.example @"EBEFD08370A247C89837"
 * @param InstanceID Eddystone-UID instance ID, Lenth = 6 bytes.example @"E7B5634DF524"
 * @param measuredPowerValue Eddystone-UID measured power value. example 203
 * @param completion block handling operation completion.
 *
 * @return void
 */
- (void) configureCustomChannelOneAsEddystone:(NSString*)namespaceID InstanceID:(NSString*)InstanceID measuredPowerValue:(int)measuredPowerValue WithCompletion:(JAALEEBoolCompletionBlock)completion;


/**
 * Configure JAALEE Custom channel one's data as Eddystone-URL Data;
 *
 * @param URL Eddystone-URL. example @"www.jaalee.com"
 * @param measuredPowerValue Eddystone-URL measured power value. example 203
 * @param completion block handling operation completion.
 *
 * @return void
 */
- (void) configureCustomChannelOneAsEddystone:(NSURL*)URL measuredPowerValue:(int)measuredPowerValue WithCompletion:(JAALEEBoolCompletionBlock)completion;


/**
 * Configure JAALEE Custom channel two's data as iBeacon Data;
 *
 * @param ProximityUUID new iBeacon channel Proximity UUID value.
 * @param major new iBeacon channel major value.
 * @param minor new iBeacon channel minor value.
 * @param measuredPowerValue new iBeacon channel measured power value.
 * @param completion block handling operation completion.
 *
 * @return void
 */
- (void) configureCustomChannelTwoAsIBeacon:(NSString*)ProximityUUID Major:(short int)major Minor:(short int)minor measuredPowerValue:(int)measuredPowerValue WithCompletion:(JAALEEBoolCompletionBlock)completion;


/**
 * Configure JAALEE Custom channel two's data as Eddystone-UID Data;
 *
 * @param namespaceID Eddystone-UID namespace ID, Lenth = 10 bytes.example @"EBEFD08370A247C89837"
 * @param InstanceID Eddystone-UID instance ID, Lenth = 6 bytes.example @"E7B5634DF524"
 * @param measuredPowerValue Eddystone-UID measured power value. example 203
 * @param completion block handling operation completion.
 *
 * @return void
 */
- (void) configureCustomChannelTwoAsEddystone:(NSString*)namespaceID InstanceID:(NSString*)InstanceID measuredPowerValue:(int)measuredPowerValue WithCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Configure JAALEE Custom channel two's data as Eddystone-URL Data;
 *
 * @param URL Eddystone-URL. example @"www.jaalee.com"
 * @param measuredPowerValue Eddystone-URL measured power value. example 203
 * @param completion block handling operation completion.
 *
 * @return void
 */
- (void) configureCustomChannelTwoAsEddystone:(NSURL*)URL measuredPowerValue:(int)measuredPowerValue WithCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Configure JAALEE broadcast mode
 *
 * @param connectable connectable mode or non-connectable mode
 * @param completion block handling operation completion.
 *
 * @return void
 */
-(void) configureJAALEEBroadcastAlwaysConnectable:(BOOL)connectable WithCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Select a channel to broadcast always
 *
 * @param channel the channel want to choose @see JAALEE_BEACON_CHANNEL_SELECT
 * @param completion block handling operation completion.
 *
 * @return void
 */
-(void) selectJAALEEalwaysBroadcastChannel:(JAALEE_CHANNEL_SELECT)channel WithCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Select a channel to broadcast when JAALEE have a motion;
 *
 * @param channel the channel want to choose @see JAALEE_BEACON_CHANNEL_SELECT
 * @param completion block handling operation completion.
 *
 * @return void
 */
-(void) selectJAALEEmotionTriggerChannel:(JAALEE_CHANNEL_SELECT)channel WithCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Select a channel to broadcast when touched JAALEE button;
 *
 * @param channel the channel want to choose @see JAALEE_BEACON_CHANNEL_SELECT
 * @param completion block handling operation completion.
 *
 * @return void
 */
-(void) selectJAALEEbuttonTouchTriggerChannel:(JAALEE_CHANNEL_SELECT)channel WithCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Select a channel to broadcast when detect JAALEE droped;
 *
 * @param channel the channel want to choose @see JAALEE_BEACON_CHANNEL_SELECT
 * @param completion block handling operation completion.
 *
 * @return void
 */
-(void) selectJAALEEfallTriggerChannel:(JAALEE_CHANNEL_SELECT)channel WithCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * set JAALEE motion sensitive;
 *
 * @param sensitive the sensitive want to choose @see JAALEE_BEACON_SENSOR_SENSITIVE
 * @param completion block handling operation completion.
 *
 * @return void
 */
-(void) setJAALEEMotionSensitive:(JAALEE_SENSOR_SENSITIVE)sensitive WithCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * set JAALEE fall sensitive;
 *
 * @param sensitive the sensitive want to choose @see JAALEE_BEACON_SENSOR_SENSITIVE
 * @param completion block handling operation completion.
 *
 * @return void
 */
-(void) setJAALEEFallSensitive:(JAALEE_SENSOR_SENSITIVE)sensitive WithCompletion:(JAALEEBoolCompletionBlock)completion;

/**
 * Call JAALEE.
 *
 * @return void
 */
- (BOOL) callJAALEE;


/**
 * read RSSI from JAALEE.
 *
 * @return void
 */
-(void) readRSSI;


/**
 * start notify button touch, when JAALEE button touched JAALEEDidUpdateButtonTouch method will be called.
 *
 * @return void
 */
-(BOOL) startNotifyButtonTouch;

/**
 * start notify fall, when JAALEE droped JAALEEDidFallDetected method will be called.
 *
 * @return void
 */
- (BOOL) startNotifyFall;

/**
 * start notify motion, when JAALEE have a motion JAALEEDidMotionDetected method will be called.
 *
 * @return void
 */
- (BOOL) startNotifyMotion;
@end