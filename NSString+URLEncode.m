//
//  NSString+URLEncode.m
//
//  Created by Scott James Remnant on 6/1/11.
//  Copyright 2011 Scott James Remnant <scott@netsplit.com>. All rights reserved.
//
//  encodeForURLFromData: addition by Victor C. Van Hee http://www.totagogo.com

#import "NSString+URLEncode.h"


@implementation NSString (NSString_URLEncode)

- (NSString *)encodeForURL
{
    // See http://en.wikipedia.org/wiki/Percent-encoding and RFC3986
    // Hyphen, Period, Understore & Tilde are expressly legal
    const CFStringRef legalURLCharactersToBeEscaped = CFSTR("!*'();:@&=+$,/?#[]<>\"{}|\\`^% ");
	
    return (__bridge NSString *)(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, legalURLCharactersToBeEscaped, kCFStringEncodingUTF8));
}

- (NSString *)encodeForURLReplacingSpacesWithPlus;
{
    // Same as encodeForURL, just without +
    const CFStringRef legalURLCharactersToBeEscaped = CFSTR("!*'();:@&=$,/?#[]<>\"{}|\\`^% ");
    
    NSString *replaced = [self stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return (__bridge NSString *)(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)replaced, NULL, legalURLCharactersToBeEscaped, kCFStringEncodingUTF8));
}

- (NSString *)decodeFromURL
{
    NSString *decoded = (__bridge NSString *)(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
    return [decoded stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}




@end
