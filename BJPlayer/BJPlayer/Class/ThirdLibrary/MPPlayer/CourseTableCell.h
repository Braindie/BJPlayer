//
//  CourseTableCell.h
//  MobileStudy
//
//  Created by chenxili on 14/12/23.
//
//

#import <UIKit/UIKit.h>
#import "RCLabel.h"

@interface CourseTableCell : UITableViewCell
#if ISMobile_Version
@property (nonatomic,strong) UILabel *titleLabel;
#else
@property (nonatomic,strong) RCLabel *titleLabel;
-(void) UpdateRtLabel:(RCLabel *)label;
#endif

@property (nonatomic,strong) UIImageView *stateImage;





@end
