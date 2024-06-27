function love.conf(t)
    t.title = "shooting gallery project"       --the title of the window the game is in (string)
    t.version = "11.5"          -- the love 2d version the game is built on (string)
    t.console = true            -- attach a console (bool, windows only, dev mode)
    t.window.width = 1280       -- window width (number)
    t.window.height = 720       -- window height (number)
    t.window.vsync = 0          -- disable or enable vsync
end