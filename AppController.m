/*
 File: AppController.m
 Abstract: Create a fire effect using emitter layers
 Version: 1.1
 
 */

#import "AppController.h"

@interface AppController (Internal)
-(CGImageRef)CGImageNamed:(NSString*)name;
@end

@implementation AppController

-(void)awakeFromNib {
    //Create the root layer
    rootLayer = [CALayer layer];
    
    //Set the root layer's background color to black
    rootLayer.backgroundColor = CGColorGetConstantColor(kCGColorClear);
    
    //Create the fire emitter layer
    fireEmitter = [CAEmitterLayer layer];
    fireEmitter.emitterPosition = CGPointMake(225, 50);
    fireEmitter.emitterMode = kCAEmitterLayerOutline;
    fireEmitter.emitterShape = kCAEmitterLayerLine;
    fireEmitter.renderMode = kCAEmitterLayerAdditive;
    fireEmitter.emitterSize = CGSizeMake(0, 0);
    
    //Create the smoke emitter layer
    smokeEmitter = [CAEmitterLayer layer];
    smokeEmitter.emitterPosition = CGPointMake(225, 50);
    smokeEmitter.emitterMode = kCAEmitterLayerPoints;
    
    //Create the fire emitter cell
    CAEmitterCell* fire = [CAEmitterCell emitterCell];
    fire.emissionLongitude = M_PI;
    fire.birthRate = 0;
    fire.velocity = 80;
    fire.velocityRange = 30;
    fire.emissionRange = 1.1;
    fire.yAcceleration = 200;
    fire.scaleSpeed = 0.3;
    CGColorRef color = CGColorCreateGenericRGB(0.8, 0.4, 0.2, 0.10);
    fire.color = color;
    CGColorRelease(color);
    fire.contents = (id) [self CGImageNamed:@"fire.png"];
    
    //Name the cell so that it can be animated later using keypaths
    [fire setName:@"fire"];
    
    //Add the fire emitter cell to the fire emitter layer
    fireEmitter.emitterCells = [NSArray arrayWithObject:fire] ;
    
    //Create the smoke emitter cell
    CAEmitterCell* smoke = [CAEmitterCell emitterCell];
    smoke.birthRate = 11;
    smoke.emissionLongitude = M_PI / 2;
    smoke.lifetime = 0;
    smoke.velocity = 40;
    smoke.velocityRange = 20;
    smoke.emissionRange = M_PI / 4;
    smoke.spin = 1;
    smoke.spinRange = 6;
    smoke.yAcceleration = 160;
    smoke.contents = (id) [self CGImageNamed:@"smoke.png"];
    smoke.scale = 0.1;
    smoke.alphaSpeed = -0.12;
    smoke.scaleSpeed = 0.7;
    
    //Name the cell so that it can be animated later using keypaths
    [smoke setName:@"smoke"];
    
    //Add the smoke emitter cell to the smoke emitter layer
    smokeEmitter.emitterCells = [NSArray arrayWithObject:smoke];
    
    //Add the two emitter layers to the root layer
    [rootLayer addSublayer:smokeEmitter];
    [rootLayer addSublayer:fireEmitter];
    
    //Set the view's layer to the base layer
    [view setLayer:rootLayer];
    [view setWantsLayer:YES];
    
    //Set the fire simulation to reflect the initial slider position
    [self slidersChanged:self];
    
    //Force the view to update
    [view setNeedsDisplay:YES];
}

//Update the emitters when the slider value changes
-(IBAction)slidersChanged:(id)sender {
    //Query the gasSlider's value
    float gas = [gasSlider intValue] / 100.0;
    
    //Update the fire properties
    [fireEmitter setValue:[NSNumber numberWithInt:(gas * 1000)] forKeyPath:@"emitterCells.fire.birthRate"];
    [fireEmitter setValue:[NSNumber numberWithFloat:gas] forKeyPath:@"emitterCells.fire.lifetime"];
    [fireEmitter setValue:[NSNumber numberWithFloat:(gas * 0.35)] forKeyPath:@"emitterCells.fire.lifetimeRange"];
    fireEmitter.emitterSize = CGSizeMake(50 * gas, 0);
    
    //Update the smoke properites
    [smokeEmitter setValue:[NSNumber numberWithInt:gas * 4] forKeyPath:@"emitterCells.smoke.lifetime"];
    CGColorRef color = CGColorCreateGenericRGB(1, 1, 1, gas * 0.3);
    [smokeEmitter setValue:(__bridge id)color forKeyPath:@"emitterCells.smoke.color"];
    CGColorRelease(color);
}

//Return a CGImageRef from the specified image file in the app's bundle
-(CGImageRef)CGImageNamed:(NSString*)name {
    CFURLRef url = (__bridge CFURLRef) [[NSBundle mainBundle] URLForResource:name withExtension:nil];
    CGImageSourceRef source = CGImageSourceCreateWithURL(url, NULL);
    CGImageRef image = CGImageSourceCreateImageAtIndex(source, 0, NULL);
    CFRelease(source);
    return (CGImageRef) image;
}

@end
