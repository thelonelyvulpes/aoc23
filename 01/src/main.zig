const std = @import("std");

pub fn main() !void {
    var file = try std.fs.openFileAbsolute("/input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [1024]u8 = undefined;
    var final_result: u64 = 0;
    var digit_pair = [2]u16{ 0, 0 };
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |len| {
        var digit_index: u8 = 0;
        var multi_digit = false;
        for (len) |value| {
            if (std.ascii.isDigit(value)) {
                digit_pair[digit_index] = value - '0';
                if (digit_index == 0) {
                    digit_index = 1;
                } else {
                    multi_digit = true;
                }
            }
        }

        final_result += switch (multi_digit) {
            true => (digit_pair[0] * 10) + digit_pair[1],
            false => (digit_pair[0] * 10) + digit_pair[0],
        };
    }
    std.debug.print("res: {}\n", .{final_result});
}
