//
//  UIImage+GIF.h
//  LeoSegmentContol
//
//  Created by Eleven on 16/5/26.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GIF)

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;

+ (UIImage *)sd_animatedGIFWithData:(NSData *)data;

- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
