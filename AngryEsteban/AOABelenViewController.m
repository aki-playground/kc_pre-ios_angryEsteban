//
//  AOABelenViewController.m
//  AngryEsteban
//
//  Created by Akixe on 27/2/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AOABelenViewController.h"

@interface AOABelenViewController ()

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
    
}

-(void) didPan:(UIPanGestureRecognizer *) pan{
    
}

-(void) didSwipe: (UISwipeGestureRecognizer *) swipe {
    
}
@end
