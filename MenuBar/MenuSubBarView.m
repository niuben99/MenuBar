//
//  MenuSubBarView.m
//  YangFan
//
//  Created by niuben on 17/3/21.
//  Copyright © 2017年 北京红云融通技术有限公司. All rights reserved.
//

#import "MenuSubBarView.h"

@implementation MenuSubBarView

-(instancetype)initWithMenuImages:(UIImage *)image
                             Name:(NSString *)name
                     MovePosition:(CGPoint)point
                              TAG:(NSInteger)tag{
    self=[super init];
    if (self){
        _icon=[[UIImageView alloc]initWithImage:image];
        _icon.center=CGPointMake(image.size.width/2, image.size.height/2);
        self.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
        [self addSubview:_icon];
        
        _name=[[UILabel alloc] init];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = [UIFont boldSystemFontOfSize:12.0f];
        _name.numberOfLines = 1;
        _name.textColor = [UIColor whiteColor];
        _name.frame=CGRectMake(0, image.size.width-8.0f, image.size.width, 20);
        _name.text = name;
        [self addSubview:_name];
        self.tag=tag;
        _movePoint=point;
        
    }
    return self;
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
}

-(void)updateIconImage:(UIImage *) iconImage{
    _icon.image=iconImage;
}

-(void)updateNameText:(NSString *) text{
    _name.text = text;
}

@end
