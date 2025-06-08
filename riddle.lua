rule("riddle")
    set_extensions(".rid")

    on_build_file(function (target, sourcefile, opt)
        local objectdir  = target:objectdir()
        local suffix     = is_plat("windows") and ".obj" or ".o"
        local objectfile = path.join(objectdir,
                                     path.basename(sourcefile) .. suffix)
        os.mkdir(path.directory(objectfile))
        local argv = {"-c", sourcefile, "-o", objectfile}
        table.join2(argv, target:get("ridflags") or {})

        target:add("objectfiles",objectfile)

        os.vrunv("riddlec", argv)
        return objectfile
    end)

    on_link(function (target, opt)
        local objectfiles = target:get("objectfiles")
        
        if #objectfiles == 0 then
            return
        end
        local argv = {"-o", target:targetfile()}
        table.join2(argv, target:get("ridflags") or {})
        table.join2(argv, objectfiles)
        os.vrunv("clang", argv)
    end)
