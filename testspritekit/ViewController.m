//
//  ViewController.m
//  testspritekit
//
//  Created by dongwheepark on 2014. 6. 12..
//  Copyright (c) 2014년 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import "MyScene2.h"
#import "AFAPIClient.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    int iX = 0;
    NSNumber *numRand;
    NSNumber *bNumRand;
    NSNumber *numBeforeY;
    NSNumber *bNumBeforeY;
    // Configure the view.
    for (int cnt = 1; cnt <= 6; cnt ++) {
        numRand = [NSNumber numberWithInt: arc4random() %11];
        bNumRand = [NSNumber numberWithInt: arc4random() %11];
        if (cnt == 1)
        {
            iX = self.viewGraphLine1.frame.origin.x;
            numBeforeY = [NSNumber numberWithInt: arc4random() %11];
            bNumBeforeY = [NSNumber numberWithInt: arc4random() %11];
        }
       
   
        [self drawGraph:@[@[numBeforeY,numRand],@[bNumBeforeY,bNumRand]] andXvalue:iX];
        numBeforeY = numRand;
        bNumBeforeY = bNumRand;
        iX += 44;
    }
   
//    [UIView animateWithDuration:<#(NSTimeInterval)#> delay:<#(NSTimeInterval)#> options:<#(UIViewAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>:4.0 animations:^{
//        
//        
//    }];
  
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager startUpdatingLocation];
    
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:CGSizeMake(skView.bounds.size.width *2, skView.bounds.size.height * 2)
                       ];
    scene.scaleMode = SKSceneScaleModeAspectFit;
    

    [skView presentScene:scene];
    }

- (void)drawGraph : (NSArray *)arrLevel andXvalue: (int)xValue
{
    CGFloat fLineHeight = self.viewGraphLine1.frame.size.height / 10.0f;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(xValue, fLineHeight * [arrLevel[0][0] integerValue])];
    [path addLineToPoint:CGPointMake(xValue + 44, fLineHeight *[arrLevel[0][1] integerValue])];
    [path addArcWithCenter:CGPointMake(xValue + 44, fLineHeight *[arrLevel[0][1] integerValue]) radius:3.0 startAngle:0 endAngle:360.f clockwise:YES];
    
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayer.lineWidth = 1.0;
    //shapeLayer.fillColor = [[UIColor orangeColor] CGColor];

    [path moveToPoint:CGPointMake(xValue , fLineHeight *[arrLevel[1][0] integerValue] )];
    [path addLineToPoint:CGPointMake(xValue + 44, fLineHeight * [arrLevel[1][1] integerValue] )];
    [path addArcWithCenter:CGPointMake(xValue + 44, fLineHeight * [arrLevel[1][1] integerValue]) radius:3.0 startAngle:0 endAngle:360.f clockwise:YES];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    shapeLayer.lineWidth = 1.0;
    shapeLayer.fillColor = [[UIColor orangeColor] CGColor];
    
//    [path moveToPoint:CGPointMake(xValue, fLineHeight * [arrLevel[0][0] integerValue])];
//    
//    [path addLineToPoint:CGPointMake(xValue + 44, fLineHeight *[arrLevel[0][1] integerValue])];
//    [path addLineToPoint:CGPointMake(xValue + 44, fLineHeight *[arrLevel[1][1] integerValue] )];
//    
//    [path addLineToPoint:CGPointMake(xValue, fLineHeight * [arrLevel[1][0] integerValue] )];
//    shapeLayer.lineWidth = 2.0;
//    shapeLayer.path = [path CGPath];
//    shapeLayer.strokeColor = [[UIColor clearColor] CGColor];
//    shapeLayer.fillColor = [[UIColor orangeColor] CGColor];
    
    
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 0.0;
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    [self.viewGraph.layer addSublayer:shapeLayer];
}

- (void)getWeather :(float)lan :(float)lon
{
    
   
    NSDate *dateEnd=[NSDate dateWithTimeInterval:-3600 sinceDate:[NSDate date]];
    NSDate *dateStart = [NSDate dateWithTimeInterval:-10000 sinceDate:dateEnd];
        NSLog(@"%@",[NSDate dateWithTimeIntervalSince1970:1419980400]);

    [[AFAPIClient sharedClient] GET:[@"http://api.openweathermap.org/data/2.5/weather"  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                         parameters:@{@"lat":[NSString stringWithFormat:@"%f",lan],@"lon":[NSString stringWithFormat:@"%f", lon],@"APPID":[@"78d31a7c1ec75b5d7a7160292d4e661a" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"units":@"metric"}
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                               [locationManager stopUpdatingLocation];
                                dicCurrentWeatherInfo = responseObject;
    
                                [[AFAPIClient sharedClient] GET:[@"http://api.openweathermap.org/data/2.5/history/city"  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                                     parameters:@{@"id":@"6800516",@"type":@"hour",@"start":[NSString stringWithFormat:@"%d",(int)[dateStart timeIntervalSince1970]], @"end":[NSString stringWithFormat:@"%d",(int)[dateEnd timeIntervalSince1970]]}
                                                        success:^(NSURLSessionDataTask *task, id responseObject) {
                                                           
                                                            dicYesterdayWeatherInfo = responseObject;
                                                            [self showWeatherInfo];
                                                        }
                                                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                            
                                                            // 통신 실패 시 처리
                                                            NSLog(@"Connection faile");
                                                            NSLog(@"Function : %s  Source Line : %d" , __FUNCTION__, __LINE__);
                                                            
                                                        }];

                            }
                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                
                                // 통신 실패 시 처리
                                NSLog(@"Connection faile");
                                NSLog(@"Function : %s  Source Line : %d" , __FUNCTION__, __LINE__);
                                
                            }];
}
- (void)showWeatherInfo
{
    int iYestTmp = roundf([[dicYesterdayWeatherInfo[@"list"] lastObject][@"temp"][@"v"] floatValue] - 273.15f);
    int iCurTmp = roundf([dicCurrentWeatherInfo[@"main"][@"temp"] floatValue]);
    
    int iCompTmp = iCurTmp - iYestTmp;
    NSString *strDescript;
    NSString *strPlusMinus;
    if (iCompTmp > 0)
    {
        strDescript = @"높아요";
        strPlusMinus = @"+";
    }
    else
    {
        strDescript = @"낮아요";
        strPlusMinus = @"-";
    }
    
    
    NSString *strYesterdayTmp = [NSString stringWithFormat:@"%d",iYestTmp];
    [self.lbCurrentTmp setText:[NSString stringWithFormat:@"%d°",iCurTmp]];
    [self.lbYesterdayTmp setText:[NSString stringWithFormat:@"%@°",strYesterdayTmp]];
    [self.lbCompTmp setText:[NSString stringWithFormat:@"%@%d°",strPlusMinus,iCompTmp]];
    [self.lbDescription setText:[NSString stringWithFormat:@"어제보다 %d°C %@",iCompTmp,strDescript]];
    [self.lbWeatherInfoMent setText:dicCurrentWeatherInfo[@"weather"][0][@"description"]];
}
- (void)getWeather: (NSString *)strWOEID
{
    //x9zsf33emne25gpu4snutr7h
    if (strWOEID)
    {
        [[AFAPIClient sharedClient] GET:[@"http://weather.yahooapis.com/forecastjson"  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                         parameters:@{@"w":strWOEID,@"u":@"c"}
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                
                              
                                
                            }
                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                
                                // 통신 실패 시 처리
                                NSLog(@"Connection faile");
                                NSLog(@"Function : %s  Source Line : %d" , __FUNCTION__, __LINE__);
                                
                            }];
    }
}
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self getWeather:manager.location.coordinate.latitude :manager.location.coordinate.longitude];
    
}
@end
