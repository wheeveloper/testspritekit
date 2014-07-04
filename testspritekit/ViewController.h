//
//  ViewController.h
//  testspritekit
//

//  Copyright (c) 2014년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    NSDictionary *dicCurrentWeatherInfo;
    NSDictionary *dicYesterdayWeatherInfo;
}
@property (weak, nonatomic) IBOutlet UIImageView *myBackImage;
@property (weak, nonatomic) IBOutlet UILabel *lbCurrentTmp;
@property (weak, nonatomic) IBOutlet UILabel *lbYesterdayTmp;
@property (weak, nonatomic) IBOutlet UILabel *lbCompTmp;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (weak, nonatomic) IBOutlet UILabel *lbWeatherInfoMent;
@property (weak, nonatomic) IBOutlet UIView *viewGraph;
@property (weak, nonatomic) IBOutlet UIView *viewGraphLine1;
@property (weak, nonatomic) IBOutlet UIView *viewGraphLine2;
@property (weak, nonatomic) IBOutlet UIView *viewGraphLine3;
@property (weak, nonatomic) IBOutlet UIView *viewGraphLine4;
@property (weak, nonatomic) IBOutlet UIView *viewGraphLine5;
@property (weak, nonatomic) IBOutlet UIView *viewGraphLine6;
@property (weak, nonatomic) IBOutlet UIView *viewGraphLine7;

@end
