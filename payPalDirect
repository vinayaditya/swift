//
//  ViewController.m
//  SGit
//
//  Created by vinayaditya on 5/23/16.
//  Copyright © 2016 vinayaditya. All rights reserved.
//

#import "ViewController.h"
#import "PayPalMobile.h"


#define kPayPalEnvironment PayPalEnvironmentSandbox
#define kPaypalClientIDSendBox @"*******ftLs3TkAszMMWdl6ixGCgVKmShu2kBycVksO_4z9KLrZG2YwDo__x-********"
#define kPaypalClientIProduction @"******38WfcLRu3PnGmDHeOBmGjn4BN2isel5uB9amI8mA81NzUTX9SBpgV6rBo-*****"

@interface ViewController ()<PayPalPaymentDelegate>

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong, readwrite) NSString *environment;
@end

@implementation ViewController

+ (void)initializePayPalMobileInAppDelegateDidFinishLaunch
{
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : kPaypalClientIProduction, PayPalEnvironmentSandbox : kPaypalClientIDSendBox}];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.merchantName = @"ramdev pansari";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];

    
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    self.environment = kPayPalEnvironment;
    
    UIButton* lButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [lButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:lButton];
    lButton.center = self.view.center;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // Preconnect to PayPal early
    [PayPalMobile preconnectWithEnvironment:self.environment];
}

- (void)pay
{
    // Optional: include multiple items
    PayPalItem *item1 = [PayPalItem itemWithName:@"item name 1"
                                    withQuantity:2
                                       withPrice:[NSDecimalNumber decimalNumberWithString:@"5.25"]
                                    withCurrency:@"USD"
                                         withSku:@"optional"];
    PayPalItem *item2 = [PayPalItem itemWithName:@"item name 2"
                                    withQuantity:1
                                       withPrice:[NSDecimalNumber decimalNumberWithString:@"11.00"]
                                    withCurrency:@"USD"
                                         withSku:@"optional"];
    PayPalItem *item3 = [PayPalItem itemWithName:@"item name 3"
                                    withQuantity:1
                                       withPrice:[NSDecimalNumber decimalNumberWithString:@"51.00"]
                                    withCurrency:@"USD"
                                         withSku:@"optional"];
    NSArray *items = @[item1, item2, item3];
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    // Optional: include payment details
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"1.25"];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0.25"];
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                               withShipping:shipping
                                                                                    withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = @"pansari";
    payment.items = items;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = YES;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment configuration:self.payPalConfig delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment
{
    NSLog(@"PayPal Payment Success!");
    [self sendCompletedPaymentToServer:completedPayment];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation
- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment
{
    // TODO: Send completedPayment.confirmation to server
}

@end
