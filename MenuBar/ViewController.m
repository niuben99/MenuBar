//
//  ViewController.m
//  MenuBar
//
//  Created by niuben on 17/3/23.
//  Copyright © 2017年 butel. All rights reserved.
//

#import "ViewController.h"
#import "MenuBarView.h"
#import "MenuSubBarView.h"

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMenu];
}


-(void)initMenu{
    CGFloat width=CGRectGetWidth(self.view.frame);
    CGFloat height=CGRectGetHeight(self.view.frame);
    
    NSArray *menus = @[
                       [[MenuSubBarView alloc]initWithMenuImages:[UIImage imageNamed:@"icon_open_live_telecast"] Name:@"发直播" MovePosition:CGPointMake(width/4, height-130) TAG:0],
                       [[MenuSubBarView alloc]initWithMenuImages:[UIImage imageNamed:@"icon_red_envelopes"] Name:@"喊红包"  MovePosition:CGPointMake(width*3/4, height-130)TAG:1]
                       ];
    
    UIImage *mainMenu=[UIImage imageNamed:@"icon_main_menu"];//背景
    UIImage *aniImage=[UIImage imageNamed:@"icon_ani_menu"];//旋转
    
    MenuBarView *menu=[[MenuBarView alloc] initWithCenter:CGPointMake(width / 2, height-mainMenu.size.height/2) backgroudImage:mainMenu animaImage:aniImage subMenu:menus];
    menu.menuCallBack = self;
    
    [self.view addSubview:menu];
}

- (BOOL)subMenuSelected:(NSInteger)subTag{
    //TODO 选中view的tag处理
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
