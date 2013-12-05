#import "StatusBarStyleANE.h"

FREContext StatusBarStyleANECtx = nil;


@implementation StatusBarStyleANE

#pragma mark - Singleton

static StatusBarStyleANE *sharedInstance = nil;

+ (StatusBarStyleANE *)sharedInstance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }

    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return self;
}

@end


#pragma mark - C interface

DEFINE_ANE_FUNCTION(StatusBarStyleANEIsSupported)
{
    NSLog(@"Entering IsSupported()");

    FREObject fo;

    FREResult aResult;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        aResult = FRENewObjectFromBool(NO, &fo);
    } else {
        aResult = FRENewObjectFromBool(YES, &fo);
    }
    
    if (aResult == FRE_OK)
    {
        //things are fine
        NSLog(@"Result = %d", aResult);
    }
    else
    {
        //aResult could be FRE_INVALID_ARGUMENT or FRE_WRONG_THREAD, take appropriate action.
        NSLog(@"Result = %d", aResult);
    }
    
    NSLog(@"Exiting IsSupported()");
    
    return fo;
}


DEFINE_ANE_FUNCTION(SetStatusBarStyle)
{
    NSLog(@"Entering SetStatusBarStyle()");
    
    FREObject fo;
    
    FREResult aResult = FRENewObjectFromBool(NO, &fo);
    
    // iOS6以上の時
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        if(argc > 0) {
            int statusStyleType;
            if(FRE_OK == FREGetObjectAsInt32(argv[0], &statusStyleType)) {
                NSLog(@"statusStyleType: %d", statusStyleType);
                
                switch (statusStyleType) {
                    case 1:
                        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                        break;
                    case 2:
                        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                        break;
                    default:
                        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                        break;
                }
                
                aResult = FRENewObjectFromBool(YES, &fo);
            } else {
                aResult = FRENewObjectFromBool(NO, &fo);
            }
        }
        
    }
    
    NSLog(@"Exiting SetStatusBarStyle()");
    
    return fo;
}


#pragma mark - ANE setup

void StatusBarStyleANEExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) 
{
    NSLog(@"Entering StatusBarStyleANEExtInitializer()");

    *extDataToSet = NULL;
    *ctxInitializerToSet = &StatusBarStyleANEContextInitializer;
    *ctxFinalizerToSet = &StatusBarStyleANEContextFinalizer;

    NSLog(@"Exiting StatusBarStyleANEExtInitializer()");
}

void StatusBarStyleANEExtFinalizer(void* extData) 
{
    NSLog(@"Entering StatusBarStyleANEExtFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting StatusBarStyleANEExtFinalizer()");
    return;
}

void StatusBarStyleANEContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering ContextInitializer()");

    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     * As a sample, the function isSupported is being provided.
     */
    *numFunctionsToTest = 2;

    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &StatusBarStyleANEIsSupported;
    func[1].name = (const uint8_t*) "setStatusBarStyle";
    func[1].functionData = NULL;
    func[1].function = &SetStatusBarStyle;

    *functionsToSet = func;

    StatusBarStyleANECtx = ctx;

    NSLog(@"Exiting ContextInitializer()");
}

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void StatusBarStyleANEContextFinalizer(FREContext ctx)
{
    NSLog(@"Entering ContextFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting ContextFinalizer()");
    return;
}


