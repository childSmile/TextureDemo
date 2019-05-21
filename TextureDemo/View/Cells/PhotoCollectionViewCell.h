//
//  PhotoCollectionViewCell.h
//  TextureDemo
//
//  Created by zqp on 2019/5/17.
//  Copyright © 2019年 zqp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionViewCell : UICollectionViewCell

- (void)configWith:(UIImage *)image ;
@property (nonatomic , strong) RACSignal *deleteSingal;

@end

@interface TitleCollectionViewCell : UICollectionViewCell

- (void)configWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
