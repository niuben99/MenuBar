#import <UIKit/UIKit.h>

@protocol MenuCallBack <NSObject>

//点击子菜单的回调,与子菜单的tag对应起来
- (BOOL)subMenuSelected:(NSInteger)subTag;

@end

static const int subMenusStartTag = 1001;
static const int mainMenusTag = 0;
static const int otherMenuTag = 1;

@interface MenuBarView : UIView

- (instancetype)initWithCenter:(CGPoint)center backgroudImage:(UIImage *) background animaImage:(UIImage *) aniImage subMenu:(NSArray *)menu;

@property (nonatomic, weak) id<MenuCallBack> menuCallBack;//点击submenu的回调

@property (nonatomic, strong) UIView *maskView;//遮罩层
@property (nonatomic, strong) UIImageView *mainMenu;//主菜单背景
@property (nonatomic, strong) UIImageView *aniImageView;//主菜单内旋转动画

@property (nonatomic, strong) NSMutableArray *items;//子菜单

@property (nonatomic, assign) BOOL expanded;//是否展开

-(void)clickMainMenu;//切换展开/闭合
@end
