
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (IBAction)button1:(id)sender
{
    NSString *url = @"returnUrl=http://www.abc.com&cancelUrl=http://www.abc.com&startingDate=2016-08-24T10:48:52Z&endingDate=2017-02-02T20:40:52Z&maxAmountPerPayment=100&maxNumberOfPayments=1&maxTotalAmountOfAllPayments=200.00&currencyCode=USD&senderEmail=ajysrm@gmail.com&requestEnvelope.errorLanguage=en_US";
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://svcs.sandbox.paypal.com/AdaptivePayments/Preapproval"]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"jb-us-seller_api1.paypal.com" forHTTPHeaderField:@"X-PAYPAL-SECURITY-USERID"];
    [request addValue:@"WX4WTU3S8MY44S7F" forHTTPHeaderField:@"X-PAYPAL-SECURITY-PASSWORD"];
    [request addValue:@"AFcWxV21C7fd0v3bYYYRCpSSRl31A7yDhhsPUU2XhtMoZXsWHFxu-RWy" forHTTPHeaderField:@"X-PAYPAL-SECURITY-SIGNATURE"];
    [request addValue:@"APP-80W284485P519543T" forHTTPHeaderField:@"X-PAYPAL-APPLICATION-ID"];
    [request addValue:@"NV" forHTTPHeaderField:@"X-PAYPAL-REQUEST-DATA-FORMAT"];
    [request addValue:@"JSON" forHTTPHeaderField:@"X-PAYPAL-RESPONSE-DATA-FORMAT"];
    [request setHTTPBody:[url dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                       {
                                           NSString* lStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                           NSLog(@"%@",lStr);
                                           if(!error && response)
                                           {
                                               
                                           }
                                           else
                                           {
                                               NSLog(@"%@",error);
                                           }
                                       }];
    [dataTask resume];
}

- (IBAction)button2:(id)sender
{
    NSString *url = @"actionType=PAY&currencyCode=USD&feesPayer=EACHRECEIVER&memo=Example&preapprovalKey=PA-9UY96511BV8590820&receiverList.receiver(0).amount=7.00&receiverList.receiver(0).email=srksrm@gmail.com&receiverList.receiver(1).amount=2.00&receiverList.receiver(1).email=vjysrm@gmail.com&senderEmail=ajysrm@gmail.com&returnUrl=http://www.abc.com&cancelUrl=http://www.abc.com&requestEnvelope.errorLanguage=en_US";
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://svcs.sandbox.paypal.com/AdaptivePayments/Pay"]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"jb-us-seller_api1.paypal.com" forHTTPHeaderField:@"X-PAYPAL-SECURITY-USERID"];
    [request addValue:@"WX4WTU3S8MY44S7F" forHTTPHeaderField:@"X-PAYPAL-SECURITY-PASSWORD"];
    [request addValue:@"AFcWxV21C7fd0v3bYYYRCpSSRl31A7yDhhsPUU2XhtMoZXsWHFxu-RWy" forHTTPHeaderField:@"X-PAYPAL-SECURITY-SIGNATURE"];
    [request addValue:@"APP-80W284485P519543T" forHTTPHeaderField:@"X-PAYPAL-APPLICATION-ID"];
    [request addValue:@"NV" forHTTPHeaderField:@"X-PAYPAL-REQUEST-DATA-FORMAT"];
    [request addValue:@"JSON" forHTTPHeaderField:@"X-PAYPAL-RESPONSE-DATA-FORMAT"];
    [request setHTTPBody:[url dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                       {
                                           NSString* lStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                           NSLog(@"%@",lStr);
                                           if(!error && response)
                                           {
                                               
                                           }
                                           else
                                           {
                                               NSLog(@"%@",error);
                                           }
                                       }];
    [dataTask resume];
}

- (IBAction)button3:(id)sender
{
     [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.sandbox.paypal.com/webscr?cmd=_ap-preapproval&preapprovalkey=PA-9UY96511BV8590820"]]]];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.sandbox.paypal.com/webapps/adaptivepayment/flow/pay?paykey=%@&expType=mini",@"[PA-2L436119UA137750A]"]]]];
}

#pragma mark - UIWebView Delgate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"\n\n-- %@\n--%@\n\n",request.URL,[request.URL absoluteString]);
    if([[request.URL absoluteString] isEqualToString:@"https://www.sandbox.paypal.com/webapps/adaptivepayment/flow/closewindow"])
    {
       // [self validatePayment];
        return YES;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start %@",webView.request);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"End %@",webView.request);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"End %@",error);
}
@end

