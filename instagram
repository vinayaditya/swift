//
//  ViewController.m
//  SGit
//
//  Created by vinayaditya on 5/23/16.
//  Copyright © 2016 vinayaditya. All rights reserved.
//


#define KAUTHURL @"https://api.instagram.com/oauth/authorize/"
#define kAPIURl @"https://api.instagram.com/v1/users/"
#define KCLIENTID @"2539075*1e054f1c*6ea7b0e6*a591fe"
#define KCLIENTSERCRET @"24c9128e03a842fda97461af85be804d" //it is optional
#define kREDIRECTURI @"http://www.unknown.com" //registered in Instagram.

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSString *fullURL = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=code",KCLIENTID,kREDIRECTURI];
    
    UIWebView* lView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    lView.delegate = self;
    [lView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fullURL]]];
    [self.view addSubview:lView];
}

-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* urlString = [[request URL] absoluteString];
    NSArray *UrlParts = [urlString componentsSeparatedByString:[NSString stringWithFormat:kREDIRECTURI]];
    if ([UrlParts count] > 1)
    {
        urlString = [UrlParts objectAtIndex:1];
        NSRange verifierRange = [urlString rangeOfString: @"code="];
        if (verifierRange.location != NSNotFound)
        {
            NSString* lVerifier = [urlString substringFromIndex: NSMaxRange(verifierRange)];
            if (lVerifier)
                [self getAccessTokenWithVerifier:lVerifier];
            
            return NO;
        }
    }
    return YES;
}

- (void)getAccessTokenWithVerifier:(NSString*)verifier
{
    NSString *data2 = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",KCLIENTID,KCLIENTSERCRET,kREDIRECTURI,verifier];
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/access_token"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data2 dataUsingEncoding:NSUTF8StringEncoding]];


    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *tokenData = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
        
        
        // get user info using token... 
        
        NSString* lUrl2 = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/?access_token=%@",[tokenData objectForKey:@"access_token"]];
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:lUrl2] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           
            NSString *response2 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",response2);
            
        }] resume];
        
    }] resume];
}

@end
