//
//  MenuSubBarView.h
//  YangFan
//
//  Created by niuben on 17/3/21.
//  Copyright © 2017年 北京红云融通技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSubBarView : UIView
-(instancetype)initWithMenuImages:(UIImage *)image
                             Name:(NSString *)name
                     MovePosition:(CGPoint)point
                              TAG:(NSInteger)tag;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;

@property (nonatomic, assign) CGPoint movePoint;
@end
