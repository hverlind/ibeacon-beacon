//
//  ViewController.m
//  Beacon
//
//  Created by Hannes Verlinde on 08/03/14.
//  Copyright (c) 2014 In the Pocket. All rights reserved.
//

@import CoreBluetooth;
@import CoreLocation;

#import "ViewController.h"

@interface ViewController () <CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager *manager;

@property (nonatomic, weak) IBOutlet UISwitch *toggle;

- (IBAction)toggle:(UISwitch *)toggle;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.toggle.transform = CGAffineTransformMakeScale(18, 18);
    
    self.manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    self.toggle.enabled = peripheral.state == CBPeripheralManagerStatePoweredOn;
}

- (IBAction)toggle:(UISwitch *)toggle
{
    if (toggle.isOn)
    {
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E65B38E7-BEBE-4C8F-B754-B16A83DEF4F0"];
        
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:2014 minor:33 identifier:@"My region"];
        
        [self.manager startAdvertising:[region peripheralDataWithMeasuredPower:nil]];
    }
    else
    {
        [self.manager stopAdvertising];
    }
}

@end
