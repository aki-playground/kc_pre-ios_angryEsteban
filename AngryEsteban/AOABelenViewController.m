//
//  AOABelenViewController.m
//  AngryEsteban
//
//  Created by Akixe on 27/2/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AOABelenViewController.h"
#import "AOASystemSounds.h"

@interface AOABelenViewController ()

@property (strong, nonatomic) UIImageView *lastShot;

@property (strong, nonatomic) NSArray *showSprites;
@property (strong, nonatomic) NSArray *hideSprites;
@property (strong, nonatomic) UIImageView *tapeView;
@property (nonatomic) CGPoint lastTouch;
@end

@implementation AOABelenViewController


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //crear reconocedores
    self.title = @"Angry Esteban";
    self.showSprites = @[[UIImage imageNamed:@"tape1.png"], [UIImage imageNamed:@"tape2.png"], [UIImage imageNamed:@"tape3.png"], [UIImage imageNamed:@"tape4.png"]];
    self.hideSprites = @[[UIImage imageNamed:@"tape4.png"], [UIImage imageNamed:@"tape3.png"], [UIImage imageNamed:@"tape2.png"], [UIImage imageNamed:@"tape1.png"]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    
    //Añadir los reconocedores a la vista
    [self.view addGestureRecognizer:tap];
    [self.view addGestureRecognizer:pan];
    [self.view addGestureRecognizer:swipe];
}

#pragma mark - Actions

-(void) didTap:(UITapGestureRecognizer *) tap{
 
    if(tap.state == UIGestureRecognizerStateRecognized){
        
        
        UIImageView *crack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"crackedGlass.png"]];
        crack.center = [tap locationInView:self.belenView];
        [self.belenView addSubview:crack];
        
        //Añadir sonido
        [[AOASystemSounds sharedSystemSounds] punch];
    }
}

-(void) didPan:(UIPanGestureRecognizer *) pan{

    
    
    if(pan.state == UIGestureRecognizerStateChanged){
        
        //obtener el current poition
        CGPoint currentPosition = [pan locationInView:self.belenView];
        //Obtener el cgrect
        CGRect lastShotRect = self.lastShot.frame;
        
        //ver si el curren point esta dentro del cgrect del último shot
        if(!CGRectContainsPoint(lastShotRect, currentPosition)){
            //Si no, pintar imagen y guardar shot en lastshot
            UIImageView *shot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bloodWound.png"]];
            shot.center = [pan locationInView:self.belenView];
            [self.belenView addSubview:shot];
            self.lastShot =shot;
        }

    } else if (pan.state == UIGestureRecognizerStateBegan){
        [[AOASystemSounds sharedSystemSounds] startMachineGun];
    }else if (pan.state == UIGestureRecognizerStateEnded){
        [[AOASystemSounds sharedSystemSounds] stopMachineGun];
    }

    
}

-(void) didSwipe: (UISwipeGestureRecognizer *) swipe {
    
    if(swipe.state == UIGestureRecognizerStateRecognized){
        if (!self.tapeView){
            
            [[AOASystemSounds sharedSystemSounds] tape];
            self.tapeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tape4.png"]];
            self.tapeView.animationImages = self.showSprites;
            self.tapeView.animationRepeatCount = 1;
            self.tapeView.animationDuration = 0.2;
        
            self.tapeView.center = [swipe locationInView:self.belenView];
            [self.belenView addSubview:self.tapeView];
        
            [self.tapeView startAnimating];
        } else {
            [[AOASystemSounds sharedSystemSounds] untape];
            self.tapeView.animationImages = self.hideSprites;
            self.tapeView.image = nil;
        
            [self.tapeView startAnimating];
        
            double delayInSeconds = 0.4;
        
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.tapeView removeFromSuperview];
            });
        }
    }
}

-(void) motionEnded:(UIEventSubtype)motion
          withEvent:(UIEvent *)event {
    if(motion == UIEventSubtypeMotionShake){
        for(UIView *view in self.belenView.subviews){
            [view removeFromSuperview];
        }
        self.tapeView = nil;
    }
}

-(BOOL) canBecomeFirstResponder{
    return YES;
}
#pragma mark - Sounds
-(void) playPunch{
    
}
@end
