rule("riddle")
    set_extensions(".rid")
    on_build_file(function (target, sourcefile, opt)
        local objectdir = target:objectdir()
        local objectfile = path.join(objectdir, path.basename(sourcefile) .. ".exe")
        os.mkdir(path.directory(objectfile))
        local argv = {}
        table.insert(argv, "riddlec")
        for _, includedir in ipairs(target:get("includedirs")) do
            table.insert(argv, "-I" .. includedir)
        end

        table.insert(argv, sourcefile)
        table.insert(argv, "-o")
        table.insert(argv, objectfile)
    
        os.vrunv("riddlec", table.slice(argv, 2))
        
        print(table.concat(argv, " "))

        return objectfile
    end)

    on_link(function (target)
        -- 禁用链接
    end)
