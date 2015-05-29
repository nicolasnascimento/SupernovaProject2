//
//  AppDelegate.m
//  SupernovaProject
//
//  Created by Nicolas Nascimento on 20/03/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

#import "AppDelegate.h"
#import "GameViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UnityAds sharedInstance] startWithGameId:@"39147"
                             andViewController: (GameViewController *)self.window.rootViewController];

    UIMutableUserNotificationAction* accept = [[UIMutableUserNotificationAction alloc] init];
    accept.title = @"Play";
    accept.identifier = @"acceptAction";
    accept.destructive = false;
    accept.activationMode = UIUserNotificationActionContextDefault;
    accept.authenticationRequired = NO;
    
    UIMutableUserNotificationCategory* category = [[UIMutableUserNotificationCategory alloc] init];
    [category setActions:@[accept] forContext:UIUserNotificationActionContextDefault];
    category.identifier = @"aCategory";
    
    NSMutableSet* categories = [[NSMutableSet alloc] initWithArray:@[category]];
    
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.alertTitle = @"OrbOrbits News";
    localNotification.alertBody = @"Your Orbits Are Missing You";
    localNotification.alertAction = @"open";
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10/*25200*/];
    localNotification.userInfo = @{@"notification Text" : @"Your Orbits Are Missing You!"};
    localNotification.category = @"aCategory";
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
//    NSUserActivity *activity = [[NSUserActivity alloc]initWithActivityType:@"com.supernova.OrbitAll.Glance"];
//    activity.userInfo = @{@"shouldProceedToGameCenter":@"false"};
//    [self application:application continueUserActivity:activity restorationHandler:nil ];
    
    return YES;
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
    NSLog(@"handling completion action");
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler{
    
    if( self.window != nil ) {
        GameViewController* viewController = (GameViewController *)self.window.rootViewController;

        [viewController restoreUserActivityState:userActivity];
    }
    
    return YES;
}

@end
