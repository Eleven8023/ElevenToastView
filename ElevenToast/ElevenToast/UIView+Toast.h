//
//  UIView+Toast.h
//  LeoSegmentContol
//
//  Created by Eleven on 16/5/26.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define BAD_NETWORK @"badNetwork"
#define NOT_LOGIN_STATE @"notLoginState"
@interface UIView (Toast)
/**
 * @brief show ActivityIndicatorView
 **/
- (void)showIndicatorView;
/**
 * @brief hidden ActiveIndicatorView
 **/
- (void)hideIndicatorView;
/**
 * @brief show submit message
 * @param message
 */
- (void)makeToast: (NSString *)message;
/**
 * @brief show no network PageView
 * @param position
 */
- (void)showBadNetworkView:(CGRect)viewFrame;
/**
 * @brief net resume hidden networkPageView
 **/
- (void)hiddenNetworkView;



@end
