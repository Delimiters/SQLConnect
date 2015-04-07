//
//  SQLTableController.m
//  Mobile585
//
//  Created by Ability585 on 4/25/14.
//  Copyright (c) 2014 Ability585. All rights reserved.
//

#import "SQLTableController.h"
#import "SQLManager.h"


@interface SQLTableController ()

@end

@implementation SQLTableController {
    NSMutableString *__error_string;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)sqlConnectionDidSucceed:(SQLConnection *)connection {
#if DEBUG
    NSLog(@"SQL Connection (tag:%ld) did succeed",(long)connection.tag);
#endif
}

- (void)sqlConnection:(SQLConnection *)connection executeDidCompleteWithResults:(NSArray *)results {
    [connection disconnect];
#if DEBUG
    NSLog(@"SQL Connection (tag:%ld) did execute...",(long)connection.tag);
    NSLog(@"...with results: %@", results);
#endif
}

- (void)sqlConnection:(SQLConnection *)connection didReceiveServerMessage:(NSString *)message {
#if DEBUG
    if (![message hasPrefix:@"Changed database context to "]) {
        NSLog(@"SQL Message: %@", message);
    }
#endif
    if (!__error_string) {
        __error_string = [NSMutableString string];
    }
    if (![message hasPrefix:@"Changed database context to"]) {
        [__error_string appendFormat:@"%@ \n\r", message];
    }
}

- (void)sqlConnection:(SQLConnection *)connection didReceiveServerError:(NSString *)error code:(int)code severity:(int)severity {
#if DEBUG
    NSLog(@"SQL Error (%d): %@ - Severity: %d", code, error, severity);
    NSLog(@"SQLController %@ - Open Connections: %ld", self, (long)[SQLManager manager].connections);
#endif
    if (!__error_string) {
        __error_string = [NSMutableString string];
    }
    [__error_string appendFormat:@"SQL Error (%d): %@ \r\n", code, error];
}

- (void)sqlConnection:(SQLConnection *)connection connectionDidFailWithError:(NSError *)error {
    [connection disconnect];
#if DEBUG
    NSLog(@"SQL Connection (tag:%ld) did fail with error: %@",(long)connection.tag, error);
#endif
}

- (void)sqlConnection:(SQLConnection *)connection executeDidFailWithError:(NSError *)error {
    [connection disconnect];
#if DEBUG
    NSLog(@"SQL Connection (tag:%ld) execute did fail with error: %@", (long)connection.tag, error);
#endif
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

@end
