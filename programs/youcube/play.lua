local arg1 = { ... }
local default = ""
if #arg1 > 0 then
    term.clear()
    term.setCursorPos(1,1)
    shell.run("youcube --lp --sh --nv "..table.concat(arg1, " "))
elseif default ~= "" then
    shell.run("youcube --lp --sh --nv "..default)
else
    print("Usage:")
    print("play <youtube link>")
    print("play <youtube search terms>")
end
