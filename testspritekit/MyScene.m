//
//  MyScene.m
//  testspritekit
//
//  Created by dongwheepark on 2014. 6. 12..
//  Copyright (c) 2014년 __MyCompanyName__. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */

        SKSpriteNode *backNode = [SKSpriteNode spriteNodeWithImageNamed:@"날씨우중충bg"];
        backNode.position = CGPointMake(self.size.width / 2 , self.size.height / 2);
        [self addChild:backNode];
        NSLog(@"%@", NSStringFromCGSize(self.frame.size));
  


        [self.view setBackgroundColor:[UIColor clearColor]];
        [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(raindrop:) userInfo:nil repeats:YES];

        
        

//        self.motionManager = [[CMMotionManager alloc] init];
//        self.motionManager.accelerometerUpdateInterval = .2;
//        self.motionManager.gyroUpdateInterval = .2;
//        
//        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
//                                                 withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
//                                                     [self outputAccelertionData:accelerometerData.acceleration];
//                                                     if(error){
//                                                         
//                                                         NSLog(@"%@", error);
//                                                     }
//                                                 }];
    }
    return self;
}

-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    accX = acceleration.x * 1000.0f;
}
- (void)raindrop:(id)sender
{
    for (int a = 0; a < 50; a ++) {
        float alphaVal = ((arc4random() % 5)+ 5) / 10.0f ;
        int isLeft = arc4random() % 2;
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"빛방울"];
        [sprite setAlpha:alphaVal];
        int x = arc4random() % 640;
        int gotoX = arc4random() % 100;
        int y = arc4random()  % 1000;
        int side;
        if (isLeft == 0)
        {
            gotoX =  -gotoX;
            side = -x;
        }
        else
        {
            gotoX = gotoX;
            side = x;
        }
        int speed = arc4random() % 2;
        [sprite setScale:0.5f];
        sprite.position = CGPointMake(x + side, y + 1136);
        
        SKAction *action = [SKAction moveTo:CGPointMake(gotoX + x + accX, -1000) duration:speed ];
        [sprite runAction:[SKAction repeatAction:action count:1]];
        
        [self addChild:sprite];
        
        float backAlphaVal = (arc4random() % 5) / 10.0f;
        SKSpriteNode *backSprite = [SKSpriteNode spriteNodeWithImageNamed:@"빛방울"];
        int bisLeft = arc4random() % 2;
        [backSprite setAlpha:backAlphaVal];
        int bx = arc4random() % 640;
        int vgotoX = arc4random() % 100;
        int by = arc4random()  % 1000;
        
        int vspeed = arc4random() % 4;
        [backSprite setScale:0.5f];
        backSprite.position = CGPointMake(bx, by + 1136);
        if (bisLeft == 0)
        {
            vgotoX =  -vgotoX;
        }
        else
        {
            vgotoX = vgotoX;
        }
        SKAction *vaction = [SKAction moveTo:CGPointMake(gotoX + bx + accX, -39) duration:vspeed ];
        [backSprite runAction:[SKAction repeatAction:vaction count:1]];
        
        [self addChild:backSprite];
        
    }
    
    for (int a = 0; a < 20; a ++) {
        
        
    }

}
- (void)raindropBack:(id)sender
{
    
    
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
