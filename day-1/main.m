#import <Foundation/Foundation.h>

// Function to read data from a file path into an array of NSStrings.
NSArray *readData(NSString *path) {
    NSError *error;
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSArray *array = @[]; // Empty array if there was an error.
    
    // I hate if this happens.
    if(error) {
        NSLog(@"There was an error reading file.\n");
        return array;
    }
    
    // Filter those which are empty.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF != ''"];
    return [[data componentsSeparatedByString:@"\n"] filteredArrayUsingPredicate:predicate];
}

// Convert a unichar to an int value.
int ord(unichar c) {
    return [[NSString stringWithFormat:@"%c", c] intValue];
}

// Look for a string in a string, and return the location and length of the string.
// If backwards is YES, then look backwards.
void searchRange(NSString *content, NSString *what, long *location, long *length, BOOL backwards) {
    NSRange range;
    if(backwards)
        range = [content rangeOfString:what options:NSBackwardsSearch];
    else
        range = [content rangeOfString:what];
    
    *location = (long)range.location;
    *length = (long)range.length;
}

// Update the leftmost and rightmost values.
// We use these to determine which one is the "first" digit and which one is the "last" digit.
void updateLeftRight(long *left, long *right, int *leftVal, int *rightVal, long location, long length, NSDictionary *dict, NSString *key) {
    if(length == 0 || location == NSNotFound)
        return;

    // Find the leftmost one.
    if(*left >= location) {
        *left = location;
        *leftVal = [[dict valueForKey:key] intValue];
    }
    
    // Find the rightmost one.
    if(*right <= location) {
        *right = location;
        *rightVal = [[dict valueForKey:key] intValue];
    }
}

// Get the first and last indices of a string.
// Returns through leftVal and rightVal AFTER conversion.
// If usesChars is YES, then we use the string keys ("one", "two") to determine the first and last digits.
void getFirstAndLastIndices(NSString *content, int *leftVal, int *rightVal, BOOL usesChars) {
    long left, right;
    left = [content length];
    right = -1;
    
    if(usesChars) {
        NSDictionary<NSString *, NSNumber *> *dict = @{
            @"one": @1,
            @"two": @2,
            @"three": @3,
            @"four": @4,
            @"five": @5,
            @"six": @6,
            @"seven": @7,
            @"eight": @8,
            @"nine": @9,
        };
        
        // Looks for string keys first.
        for(NSString *key in [dict allKeys]) {
            long location, length;
            
            // Forwards.
            searchRange(content, key, &location, &length, NO);
            updateLeftRight(&left, &right, leftVal, rightVal, location, length, dict, key);
            
            // Backwards
            searchRange(content, key, &location, &length, YES);
            updateLeftRight(&left, &right, leftVal, rightVal, location, length, dict, key);
        }
    }
    
    // Then look for integer keys.
    NSCharacterSet *set = [NSCharacterSet decimalDigitCharacterSet];
    
    // Forwards.
    NSRange range = [content rangeOfCharacterFromSet:set];
    long location = (long)range.location;
    if(range.length != 0 && left > location) {
        left = location;
        *leftVal = ord([content characterAtIndex:left]);
    }
    
    // Backwards.
    range = [content rangeOfCharacterFromSet:set options:NSBackwardsSearch];
    location = (long)range.location;
    if(range.length != 0 && right < location) {
        right = location;
        *rightVal = ord([content characterAtIndex:right]);
    }
}

// Runs the above function for all lines, and sums them up.
int sumOfAllLines(NSArray *data, BOOL usesCharsAsDigits) {
    int sum = 0;
    for(NSString *line in data) {
        int left, right;
        getFirstAndLastIndices(line, &left, &right, usesCharsAsDigits);
        sum += left * 10 + right;
    }
    return sum;
}

// For a line like 1asdanc2
// Read out the first ever digit, and the second ever digit -> 12. Twelve is the number.
// Sum of all those numbers in all lines.
void solvePartOne(NSArray *data) {
    int sum = sumOfAllLines(data, NO);
    NSLog(@"%d", sum);
}

// Similarly, for a line nine1three
// Now, "nine" is the first digit, (9) and "three" is the last digit -> 93.
// Sum of all those numbers.
void solvePartTwo(NSArray *data) {
    int sum = sumOfAllLines(data, YES);
    NSLog(@"%d", sum);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *filePath = @"input.txt";
        NSArray *data = readData(filePath);
        
        solvePartOne(data);
        solvePartTwo(data);
    }
    return 0;
}
