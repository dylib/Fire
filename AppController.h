/*
 File: AppController.h
 Abstract: Create a fire effect using emitter layers
 Version: 1.1
 
 */

#import <Cocoa/Cocoa.h>
#import <QuartzCore/CoreAnimation.h>


@interface AppController : NSObject {
    //Outlets for the view and slider
    IBOutlet NSView *view;
    IBOutlet NSSlider *gasSlider;
    
    //Root layer and the two particle emitters
    CALayer *rootLayer;
    CAEmitterLayer *fireEmitter;
    CAEmitterLayer *smokeEmitter;
}

//Update the emitters when the slider value changes
-(IBAction)slidersChanged:(id)sender;

@end
