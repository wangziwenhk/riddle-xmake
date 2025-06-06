

task("riddle")
    set_category("plugin")
    on_run(function ()
        local find_program = import("lib.detect.find_program")
        local find_tool    = import("lib.detect.find_tool")

        -- ② 先找程序本身
        local python = find_program("riddlec")  -- 只关心路径的话足够
        if not python then
            raise("riddlec not found!")
        end
    end)
    set_menu {
                -- usage
                usage = "xmake riddle [options] [arguments]"

                -- description
            ,   description = "Riddle Complier Plugin for XMake"

                -- options
            ,   options = {}
            } 