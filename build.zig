const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const module = b.addModule("x11-headers", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = b.addWriteFiles().add("empty.c", ""),
    });

    const lib = b.addLibrary(.{
        .name = "x11-headers",
        .root_module = module,
        .linkage = .static,
    });

    // contains only GLX headers!
    lib.installHeadersDirectory(b.path("GL"), "GL", .{});
    lib.installHeadersDirectory(b.path("X11"), "X11", .{});
    lib.installHeadersDirectory(b.path("xcb"), "xcb", .{});
    lib.installHeadersDirectory(b.path("xkbcommon"), "xkbcommon", .{});

    b.installArtifact(lib);
}
