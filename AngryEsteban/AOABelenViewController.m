//
//  AOABelenViewController.m
//  AngryEsteban
//
//  Created by Akixe on 27/2/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AOABelenViewController.h"

@interface AOABelenViewController ()

@property (strong, nonatomic) UIImageView *lastShot;
@end

@implementation AOABelenViewController


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //crear reconocedores
    
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
        [self playPunch];
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

        //Añadir sonido
        [self playPunch];
    }

    
}

-(void) didSwipe: (UISwipeGestureRecognizer *) swipe {
    
}


#pragma mark - Sounds
-(void) playPunch{
    
}
@end
