//
//  ViewController.m
//  Demo
//
//  Created by tobinchen on 16/3/14.
//  Copyright © 2016年 EZLoger. All rights reserved.
//

#import "ViewController.h"
#import "EZLoger.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    EZLog_Debug(@"viewDidLoad:%p",self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    EZLog_Debug(@"viewDidLoad:%p",self);
}

@end
