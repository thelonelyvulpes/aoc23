const std = @import("std");

pub fn main() !void {
    var file = try std.fs.openFileAbsolute("/input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [128]u8 = undefined;
    var final_result: u64 = 0;
    var digit_pair = [2]u8{ 0, 0 };
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var digit_index: u8 = 0;
        var multi_digit = false;
        var i: usize = 0;
        while (i < line.len) {
            var value = line[i];
            if (std.ascii.isDigit(value)) {
                digit_pair[digit_index] = value - '0';
                if (digit_index == 0) {
                    digit_index = 1;
                } else {
                    multi_digit = true;
                }
            } else {
                var x: u8 = 0;
                var haystack = line[i..];
                if (std.mem.startsWith(u8, haystack, &[3]u8{ 'o', 'n', 'e' })) {
                    x = 1;
                } else if (std.mem.startsWith(u8, haystack, &[3]u8{ 't', 'w', 'o' })) {
                    x = 2;
                } else if (std.mem.startsWith(u8, haystack, &[5]u8{ 't', 'h', 'r', 'e', 'e' })) {
                    x = 3;
                } else if (std.mem.startsWith(u8, haystack, &[4]u8{ 'f', 'o', 'u', 'r' })) {
                    x = 4;
                } else if (std.mem.startsWith(u8, haystack, &[4]u8{ 'f', 'i', 'v', 'e' })) {
                    x = 5;
                } else if (std.mem.startsWith(u8, haystack, &[3]u8{ 's', 'i', 'x' })) {
                    x = 6;
                } else if (std.mem.startsWith(u8, haystack, &[5]u8{ 's', 'e', 'v', 'e', 'n' })) {
                    x = 7;
                } else if (std.mem.startsWith(u8, haystack, &[5]u8{ 'e', 'i', 'g', 'h', 't' })) {
                    x = 8;
                } else if (std.mem.startsWith(u8, haystack, &[4]u8{ 'n', 'i', 'n', 'e' })) {
                    x = 9;
                }

                if (x > 0) {
                    digit_pair[digit_index] = x;
                    if (digit_index == 0) {
                        digit_index = 1;
                    } else {
                        multi_digit = true;
                    }
                }
            }
            i += 1;
        }
        if (multi_digit) {
            std.debug.print("line: {s}\n", .{line});
            std.debug.print("0: {} 1: {}\n", .{ digit_pair[0], digit_pair[1] });
        }
        final_result += switch (multi_digit) {
            true => (digit_pair[0] * 10) + digit_pair[1],
            false => (digit_pair[0] * 10) + digit_pair[0],
        };
    }
    std.debug.print("res: {}\n", .{final_result});
}
