//
//  AOASystemSounds.h
//  AngryEsteban
//
//  Created by Akixe on 28/2/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AOASystemSounds : NSObject

+(instancetype) sharedSystemSounds;

-(void) punch;
-(void) startMachineGun;
-(void) stopMachineGun;
-(void) binLaden;
-(void) tape;
-(void) untape;

@end
