//
//  MenuBarView.m
//  MenuBarView
//
//  Created by niuben on 17/3/17.
//  Copyright © 2017年 TU YOU. All rights reserved.
//

#import "MenuBarView.h"
#import "MenuSubBarView.h"

@implementation MenuBarView

- (instancetype)initWithCenter:(CGPoint)center backgroudImage:(UIImage *) background animaImage:(UIImage *) aniImage subMenu:(NSArray *)menus{
    self = [super init];
    if (self) {
        self.center = center;
        self.bounds=CGRectMake(0, 0, background.size.width, background.size.height);
        [self initMainMenu:background animaImage:aniImage];
        [self initMask];
        [self initSubMenu:menus];
    }
    return self;
}

-(void)initMainMenu:(UIImage *) background animaImage:(UIImage *) aniImage{
    UIImageView *menuBg=[[UIImageView alloc] initWithImage:background];
    menuBg.userInteractionEnabled = YES;
    menuBg.tag=mainMenusTag;
    [menuBg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)]];
    
    UIImageView *menuAni=[[UIImageView alloc] initWithImage:aniImage];
    menuAni.center=CGPointMake(background.size.width/2, background.size.height/2);
    
    [self addSubview:menuBg];
    [self addSubview:menuAni];
    
    //TODO 动画使用
    _mainMenu=[[UIImageView alloc] initWithImage:background];
    _mainMenu.userInteractionEnabled = YES;
    _mainMenu.tag=mainMenusTag;
    _mainMenu.center=self.center;
    [_mainMenu addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)]];
    
    _aniImageView=[[UIImageView alloc] initWithImage:aniImage];
    _aniImageView.center=self.center;
}

-(void)initMask{
    _maskView=[[UIView alloc] init];
    _maskView.frame = CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
    _maskView.backgroundColor = [UIColor colorWithRed:(0.0f) green:(0.0f) blue:(0.0f) alpha:0.5f];
    _maskView.tag=otherMenuTag;
    [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)]];
}

- (void)initSubMenu:(NSArray *)menus{
    self.items = [NSMutableArray array];
    
    for (int i = 0; i < menus.count; i++) {
        MenuSubBarView *item =menus[i];
        item.center = self.center;
        item.tag = subMenusStartTag + item.tag;
        item.userInteractionEnabled = YES;
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)]];
        [self.items addObject:item];
    }
}

//点击主菜单,收起/弹出切换
-(void)clickMainMenu{
    if (self.expanded) {
        [self shrinkSubmenu:mainMenusTag];
    } else {
        [self expandSubmenu];
    }
}

- (void)tapped:(UITapGestureRecognizer *)gesture{
    int tag=(int)gesture.view.tag;
    if(mainMenusTag!=tag){//不是主菜单,收起
        [self shrinkSubmenu:tag];
        return;
    }
    [self clickMainMenu];
}


//展开
- (void)expandSubmenu{
    self.expanded = YES;
    [self addAnimatorView];
    [UIView animateWithDuration:0.5f animations:^{
        _aniImageView.transform = CGAffineTransformMakeRotation(M_PI/4);
        _maskView.alpha=1.0f;
        for (int i = 0; i < self.items.count; i++) {
            [self moveToPosition:(MenuSubBarView *)self.items[i]];
        }
    }];
}

-(void) moveToPosition:(MenuSubBarView*) view{
    view.center=self.expanded?view.movePoint:self.center;
    [self shakeAnimation:view];
}

- (void) shakeAnimation:(UIView *)view{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:+0.1];
    shake.toValue = [NSNumber numberWithFloat:-0.1];
    shake.duration = 0.1;
    shake.autoreverses = YES;
    shake.repeatCount = 3;
    [view.layer addAnimation:shake forKey:@"imageView"];
}


//收起
- (void)shrinkSubmenu:(int)index{
    self.expanded = NO;
    
    [UIView animateWithDuration:0.5f animations:^{
        _aniImageView.transform = CGAffineTransformMakeRotation(0);
        _maskView.alpha=0.0f;
        for (int i = 0; i < self.items.count; i++) {
            [self moveToPosition:(MenuSubBarView *)self.items[i]];
        }
    } completion:^(BOOL finished) {
        if(finished){
            if (self.menuCallBack){
                [self.menuCallBack subMenuSelected:index-subMenusStartTag];
            }
            [self removeAnimatorView];
        }
    }];
}

-(void)addAnimatorView{
    [self.window addSubview:_maskView];
    for (int i=0; i<self.items.count; i++) {
        [_maskView addSubview:_items[i]];
    }
    [self.window addSubview:_mainMenu];
    [self.window addSubview:_aniImageView];
}

-(void)removeAnimatorView{
    for (int i=0; i<self.items.count; i++) {
        [_items[i] removeFromSuperview];
    }
    [_mainMenu removeFromSuperview];
    [_aniImageView removeFromSuperview];
    [_maskView removeFromSuperview];
}

@end
