//
//  UIView+Toast.m
//  LeoSegmentContol
//
//  Created by Eleven on 16/5/26.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "UIView+Toast.h"
#import "UIImage+GIF.h"

static const CGFloat CSToastCornerRadius        = 6.0;
static const BOOL    CSToastDisplayShadow       = NO;
static const CGFloat CSToastShadowOpacity       = 0.8;
static const CGFloat CSToastShadowRadius        = 2.0;
static const CGSize  CSToastShadowOffset        = { 4.0, 4.0 };
static const CGFloat CSToastOpacity             = 0.9;
static const CGFloat CSToastHorizontalPadding   = 10.0;
static const CGFloat CSToastVerticalPadding     = 10.0;
static const CGFloat CSToastImageViewWidth      = 80.0;
static const CGFloat CSToastImageViewHeight     = 80.0;
static const CGFloat CSToastMaxTitleLines       = 0;
static const CGFloat CSToastMaxMessageLines     = 0;
static const CGFloat CSToastFontSize            = 14.0;
static const CGFloat CSToastMaxWidth            = 0.8;
static const CGFloat CSToastMaxHeight           = 0.8;
static const CGFloat CSToastFadeDuration        = 0.2;
static const CGFloat CSToastDefaultDuration     = 1.5;
static const NSString * CSToastDefaultPosition  = @"center";

@implementation UIView (Toast)

- (void)showIndicatorView
{
    UIView *m_viewTip = (UIView *)[self viewWithTag:2901];
    
    if (!m_viewTip) {
        m_viewTip = [self createIndicatorView];
    }
    [self addSubview:m_viewTip];
}

-(UIView *)createIndicatorView{
    CGRect rcScreeno = [UIScreen mainScreen].bounds;
    CGRect rcScreen = CGRectMake(0, 0, rcScreeno.size.width, rcScreeno.size.height);
    
    UIView *m_viewTip = [[UIView alloc] initWithFrame:rcScreen];
    m_viewTip.autoresizingMask = (UIViewAutoresizingFlexibleHeight |  UIViewAutoresizingFlexibleWidth);
    m_viewTip.tag = 2901;
    m_viewTip.backgroundColor = [UIColor clearColor];
    
    UIImageView *launchAnimationView = [[UIImageView alloc] init];
    // 创建gifImage, 传入Gif图片名即可
    UIImage *gifImage = [UIImage sd_animatedGIFNamed:@"loading"];
    launchAnimationView.image = gifImage;
    launchAnimationView.tag = 103;
    launchAnimationView.frame = CGRectMake(0, 0, gifImage.size.width, gifImage.size.height);
    launchAnimationView.center = CGPointMake(m_viewTip.frame.size.width / 2.0, m_viewTip.frame.size.height / 2.0);
    [m_viewTip addSubview:launchAnimationView];
    
    return m_viewTip;
}

- (void)hideIndicatorView{
    UIView *m_viewTip = (UIView *)[self viewWithTag:2901];
    if (m_viewTip) {
        [m_viewTip removeFromSuperview];
    }
}

- (void)makeToast:(NSString *)message
{
    [self makeToast:message duration:CSToastDefaultDuration position:CSToastDefaultPosition];
}

- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position{
    UIView *toast = [self viewForMessage:message title:nil image:nil];
    [self showToast:toast duration:interval position:position];
}

- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    if ((message == nil) && (title == nil) && (image == nil)) return nil;
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = CSToastCornerRadius;
    
    if (CSToastDisplayShadow) {
        wrapperView.layer.shadowColor   = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = CSToastShadowOpacity;
        wrapperView.layer.shadowRadius  = CSToastShadowRadius;
        wrapperView.layer.shadowOffset  = CSToastShadowOffset;
    }
    
    wrapperView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:CSToastOpacity];
    
    if (image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(CSToastVerticalPadding, CSToastHorizontalPadding, CSToastImageViewWidth, CSToastImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    if (imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = CSToastHorizontalPadding;
    }else{
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = CSToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:CSToastFontSize];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        CGSize maxSizeTitle = CGSizeMake(self.bounds.size.width * CSToastMaxWidth - imageWidth, self.bounds.size.height * CSToastMaxHeight);
        
        CGSize requiredSize = CGSizeZero;
        CGSize boundingSize = CGSizeMake(maxSizeTitle.width, CGFLOAT_MAX);
        requiredSize = [title boundingRectWithSize:boundingSize options:NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:CSToastFontSize]} context:nil].size;
        titleLabel.frame = CGRectMake(0.0, 0.0, requiredSize.width, requiredSize.height);
        
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = CSToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:CSToastFontSize];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        CGSize requireSize = CGSizeZero;
        CGSize maxSizeMessage = CGSizeMake(self.bounds.size.width * CSToastMaxWidth - imageWidth, self.bounds.size.height * CSToastMaxHeight);
        CGSize boundingSize = CGSizeMake(maxSizeMessage.width, CGFLOAT_MAX);
        requireSize = [message boundingRectWithSize:boundingSize options:NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:CSToastFontSize]} context:nil].size;
        messageLabel.frame = CGRectMake(0.0, 0.0, requireSize.width, requireSize.height);
    }
    
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if (titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = CSToastVerticalPadding;
        titleLeft = imageLeft + imageWidth + CSToastHorizontalPadding;
    }else{
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    
    if (messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + CSToastHorizontalPadding;
        messageTop = titleTop + titleHeight + CSToastVerticalPadding;
    }else{
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }
    
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    CGFloat wrapperWidth = MAX((imageWidth + (CSToastHorizontalPadding * 2)), (longerLeft + longerWidth + CSToastHorizontalPadding));
    CGFloat wrapperHeight = MAX(messageTop + messageHeight + CSToastVerticalPadding, imageHeight + CSToastVerticalPadding * 2);
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if (titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if (messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if (imageView != nil) {
        [wrapperView addSubview:imageView];
    }
    
    return  wrapperView;
}

- (void)showToast:(UIView *)toast duration:(CGFloat)interval position:(id)point{
    toast.center = [self centerPointForPosition:point withToast:toast];
    toast.alpha = 0.0;
    [self addSubview:toast];
    toast.tag = 2876;
    
    [UIView animateWithDuration:CSToastFadeDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toast.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:CSToastFadeDuration delay:interval options:UIViewAnimationOptionCurveEaseOut animations:^{
            toast.alpha = 0.0;
        } completion:^(BOOL finished) {
            [toast removeFromSuperview];
        }];
        
    }];

}

-(CGPoint)centerPointForPosition:(id)point withToast:(UIView *)toast{
    if ([point isKindOfClass:[NSString class]]) {
        if ([point caseInsensitiveCompare:@"top"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, (toast.frame.size.height / 2) + CSToastVerticalPadding);
        }else if ([point caseInsensitiveCompare:@"bottom"] == NSOrderedSame){
            return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - CSToastVerticalPadding);
        }else if ([point caseInsensitiveCompare:@"center"] == NSOrderedSame){
            return CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        }
        }else if ([point isKindOfClass:[NSValue class]]){
        return [point CGPointValue];
    }
    return [self centerPointForPosition:CSToastDefaultPosition withToast:toast];
}

- (void)showBadNetworkView:(CGRect)viewFrame
{
    UIView * badNetView = (UIView *)[self viewWithTag:2903];
    if (!badNetView) {
        badNetView = [self creatBadNetworkView:viewFrame];
    }
    [self addSubview:badNetView];
}

- (UIView *)creatBadNetworkView:(CGRect)viewFrame{
    UIView * badNetworkView = [[UIView alloc] initWithFrame:viewFrame];
    badNetworkView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    badNetworkView.tag = 2903;
    badNetworkView.backgroundColor = [UIColor colorWithRed:241.0 / 255.0 green:245.0 / 255.0 blue:246.0 / 255.0 alpha:1.0];
    
    UIImage *loadFailedIcon = [UIImage imageNamed:@"loadFailedIcon"];
    
    UIImageView *loadFailedView = [[UIImageView alloc] initWithFrame:CGRectMake((viewFrame.size.width - loadFailedIcon.size.width) / 2.0, 90, loadFailedIcon.size.width, loadFailedIcon.size.height)];
    loadFailedView.image = loadFailedIcon;
    [badNetworkView addSubview:loadFailedView];
    
    UILabel *badNetworkTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, loadFailedView.frame.origin.y + loadFailedView.frame.size.height + 15, viewFrame.size.width, 14)];
    badNetworkTipsLabel.text = @"加 载 失 败, 请 检 查 你 的 网 络 设 置";
    badNetworkTipsLabel.textColor = [UIColor redColor];
    badNetworkTipsLabel.font = [UIFont systemFontOfSize:16];
    badNetworkTipsLabel.textAlignment = NSTextAlignmentCenter;
    [badNetworkView addSubview:badNetworkTipsLabel];
    
    UIImage *reloadBtnIcon = [UIImage imageNamed:@"reloadBtnIcon"];
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshBtn setTitle:@"重 新 加 载 " forState:UIControlStateNormal];
    [refreshBtn setTitle:@"重 新 加 载" forState:UIControlStateHighlighted];
    [refreshBtn setBackgroundImage:reloadBtnIcon forState:UIControlStateNormal];
    [refreshBtn setBackgroundImage:reloadBtnIcon forState:UIControlStateHighlighted];
    [refreshBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    refreshBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    refreshBtn.frame = CGRectMake((viewFrame.size.width - reloadBtnIcon.size.width) / 2.0, badNetworkTipsLabel.frame.origin.y + badNetworkTipsLabel.frame.size.height + 45, reloadBtnIcon.size.width, reloadBtnIcon.size.height);
    [refreshBtn addTarget:self action:@selector(refreshButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [badNetworkView addSubview:refreshBtn];
    
    return badNetworkView;
}

- (void)refreshButtonPressed:(UIButton *)button{
    [[NSNotificationCenter defaultCenter] postNotificationName:BAD_NETWORK object:nil];
}

- (void)hiddenNetworkView
{
    UIView * badNetView = (UIView *)[self viewWithTag:2903];
    if (badNetView) {
        [badNetView removeFromSuperview];
    }
}


@end
