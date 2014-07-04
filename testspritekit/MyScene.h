//
//  MyScene.h
//  testspritekit
//

//  Copyright (c) 2014년 __MyCompanyName__. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

@interface MyScene : SKScene
{
    BOOL isFirst;
    float accX;
}
@property (strong, nonatomic) CMMotionManager *motionManager;
@end
