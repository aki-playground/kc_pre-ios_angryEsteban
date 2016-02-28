//
//  AOASystemSounds.m
//  AngryEsteban
//
//  Created by Akixe on 28/2/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AOASystemSounds.h"
#define FOREVER -1
@import AVFoundation;

@interface AOASystemSounds ()
@property (strong, nonatomic) AVAudioPlayer *player;

@end
@implementation AOASystemSounds


+(instancetype) sharedSystemSounds{
    
    static AOASystemSounds *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[AOASystemSounds alloc] init];
    });
    return shared;
}

-(void) punch{
    [self playFileNamed:@"punch" withExtension:@"wav" withNumberOfLoops:0];
}
-(void) startMachineGun{
    [self playFileNamed:@"machineGunLoop" withExtension:@"wav" withNumberOfLoops:FOREVER];
}
-(void) stopMachineGun{
    [self.player stop];
}
-(void) binLaden{
    [self playFileNamed:@"niQueFueraYoBinLaden" withExtension:@"m4a" withNumberOfLoops:0];
}
-(void) tape{
    [self playFileNamed:@"tape" withExtension:@"caf" withNumberOfLoops:0];
}
-(void) untape{
    [self playFileNamed:@"untape" withExtension:@"caf" withNumberOfLoops:0];
}

-(void) playFileNamed:(NSString *) fileName
        withExtension: (NSString *) extension
    withNumberOfLoops: (NSInteger) loops {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:extension];
    NSError *error = nil;
    
    
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    if(self.player){
        self.player.numberOfLoops = loops;
        [self.player play];
    } else {
        NSLog(@"Error reading %@: %@", url, error);
    }
}
@end
