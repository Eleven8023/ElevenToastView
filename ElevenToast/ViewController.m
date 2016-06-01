//
//  ViewController.m
//  ElevenToast
//
//  Created by Eleven on 16/6/1.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Toast.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshRequest) name:BAD_NETWORK object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)ShowIndicatorBtn:(id)sender {
    [self.view showIndicatorView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view hideIndicatorView];
    });
}

- (IBAction)ShowBadNetPage:(id)sender {
    [self.view showBadNetworkView:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100)];
}

- (IBAction)ShowMessage:(id)sender {
    [self.view makeToast:@"展示当前信息"];
}

- (void)refreshRequest{
    [self.view hiddenNetworkView];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BAD_NETWORK object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
