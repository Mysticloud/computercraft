---------------------------------------------
-- Change this to false to disable all discs 
-- from the more music discs mod
local enableMoreDiscs = false
---------------------------------------------

local arg = { ... }
local s = peripheral.find("speaker")
local width, height = term.getSize()
local radio = false
local radioType = "bl"
local displayTime = 5
local infoLines = 5
local toggleInfo = {}
local blacklist = {"5", "11", "13"}
local favorites = {"stal", "pigstep", "otherside"}
local m = {
    ["5"]                   = {"minecraft:music_disc.5", 178, 2},
    ["11"]                  = {"minecraft:music_disc.11", 71, 2},
    ["13"]                  = {"minecraft:music_disc.13", 178, 2},
    ["blocks"]              = {"minecraft:music_disc.blocks", 348, 2},
    ["cat"]                 = {"minecraft:music_disc.cat", 185, 2},
    ["chirp"]               = {"minecraft:music_disc.chirp", 185, 2},
    ["far"]                 = {"minecraft:music_disc.far", 174, 2},
    ["mall"]                = {"minecraft:music_disc.mall", 197, 2},
    ["mellohi"]             = {"minecraft:music_disc.mellohi", 96, 2},
    ["otherside"]           = {"minecraft:music_disc.otherside", 195, 2},
    ["pigstep"]             = {"minecraft:music_disc.pigstep", 148, 2},
    --["relic"]               = {"minecraft:music_disc.relic", 218, 2},
    ["stal"]                = {"minecraft:music_disc.stal", 150, 2},
    ["strad"]               = {"minecraft:music_disc.strad", 188, 2},
    ["wait"]                = {"minecraft:music_disc.wait", 238, 2},
    ["ward"]                = {"minecraft:music_disc.ward", 251, 2},
    ["daze"]                = {"alexsmobs:music_disc_daze", 191, 2},
    ["thime"]               = {"alexsmobs:music_disc_thime", 314, 2},
    ["aria_biblio"]         = {"ars_nouveau:aria_biblio", 245, 2},
    ["the_sound_of_glass"]  = {"ars_nouveau:thistle_the_sound_of_glass", 182, 2},
    ["the_wild_hunt"]       = {"ars_nouveau:firel_the_wild_hunt", 121, 2},
    ["kobblestone"]         = {"kobolds:music_kobblestone", 164, 2},
    ["mammoth"]             = {"undergarden:music.disc.mammoth", 194, 2},
    ["limax_maximus"]       = {"undergarden:music.disc.limax_maximus", 161, 2},
    ["relict"]              = {"undergarden:music.disc.relict", 187, 2},
    ["gloomper_anthem"]     = {"undergarden:music.disc.gloomper_anthem", 204, 2},
    ["pancake"]             = {"supplementaries:music.pancake", 228, 2},
    ["wanderer"]            = {"biomesoplenty:music_disc.wanderer", 290, 2},
    ["blinding_rage"]       = {"blue_skies:records.blinding_rage", 232, 2},
    ["defying_starlight"]   = {"blue_skies:records.defying_starlight", 147, 2},
    ["population"]          = {"blue_skies:records.population", 237, 2},
    ["venomous_encounter"]  = {"blue_skies:records.venomous_encounter", 153, 2},
    ["endure_emptiness"]    = {"botania:music.gaia1", 202, 2},
    ["fight_for_quiescence"] = {"botania:music.gaia2", 227, 2},
    ["wither_waltz"]        = {"bygonenether:wither_waltz", 253, 2},
    ["delve_deeper"]        = {"conjurer_illager:records.delve_deeper", 229, 2},
    ["the_bright_side"]     = {"create_confectionery:the_bright_side", 162, 2},
    ["parousia"]            = {"eidolon:parousia", 185, 2},
    ["feywild_soundtrack"]  = {"feywild:feywild_soundtrack", 94, 2},
    ["calidum"]             = {"idas:calidum", 196, 2},
    ["slither"]             = {"idas:slither", 120, 2},
    ["endermosh"]           = {"quark:music.endermosh", 190, 2},
    ["findings"]            = {"twilightforest:music_disc.twilightforest.findings", 197, 2},
    ["home"]                = {"twilightforest:music_disc.twilightforest.home", 216, 2},
    ["maker"]               = {"twilightforest:music_disc.twilightforest.maker", 208, 2},
    ["motion"]              = {"twilightforest:music_disc.twilightforest.motion", 170, 2},
    ["radiance"]            = {"twilightforest:music_disc.twilightforest.radiance", 124, 2},
    ["steps"]               = {"twilightforest:music_disc.twilightforest.steps", 196, 2},
    ["superstitious"]       = {"twilightforest:music_disc.twilightforest.superstitious", 193, 2},
    ["thread"]              = {"twilightforest:music_disc.twilightforest.thread", 202, 2},
    ["wayfarer"]            = {"twilightforest:music_disc.twilightforest.wayfarer", 174, 2},
}

local more = {
    ["42"] = {"morediscs:music_disc_42_sound", 88},
    ["activate"] = {"morediscs:music_disc_activate_sound", 85},
    ["aether"] = {"morediscs:music_disc_aether_sound", 173},
    ["aggressionegression"] = {"morediscs:music_disc_aggressionegression_sound", 72},
    ["alternatedimension"] = {"morediscs:music_disc_alternatedimension_sound", 76},
    ["amethyzied"] = {"morediscs:music_disc_amethyzied_sound", 141},
    ["anchores"] = {"morediscs:music_disc_anchores_sound", 191},
    ["ancientruins"] = {"morediscs:music_disc_ancientruins_sound", 67},
    ["antiremake"] = {"morediscs:music_disc_antiremake_sound", 131},
    ["anti"] = {"morediscs:music_disc_anti_sound", 100},
    ["avian"] = {"morediscs:music_disc_avian_sound", 187},
    ["azometrall"] = {"morediscs:music_disc_azometrall_sound", 221},
    ["becomeadestructor"] = {"morediscs:music_disc_becomeadestructor_sound", 99},
    ["before"] = {"morediscs:music_disc_before_sound", 228},
    ["blazetrap"] = {"morediscs:music_disc_blazetrap_sound", 233},
    ["castle"] = {"morediscs:music_disc_castle_sound", 85},
    ["chill"] = {"morediscs:music_disc_chill_sound", 221},
    ["chop"] = {"morediscs:music_disc_chop_sound", 102},
    ["chorus"] = {"morediscs:music_disc_chorus_sound", 121},
    ["clouds"] = {"morediscs:music_disc_clouds_sound", 93},
    ["corrupte"] = {"morediscs:music_disc_corrupte_sound", 269},
    ["dear_diary"] = {"morediscs:music_disc_dear_diary_sound", 44},
    ["desert"] = {"morediscs:music_disc_desert_sound", 68},
    ["disc"] = {"morediscs:music_disc_disc_sound", 157},
    ["dive"] = {"morediscs:music_disc_dive_sound", 151},
    ["dreams"] = {"morediscs:music_disc_dreams_sound", 301},
    ["droopylovesjean"] = {"morediscs:music_disc_droopylovesjean_sound", 139},
    ["dropclouds"] = {"morediscs:music_disc_dropclouds_sound", 118},
    ["drowned_anthem"] = {"morediscs:music_disc_drowned_anthem_sound", 60},
    ["enderwalk"] = {"morediscs:music_disc_enderwalk_sound", 156},
    ["extrauosert"] = {"morediscs:music_disc_extrauosert_sound", 199},
    ["extrauoser"] = {"morediscs:music_disc_extrauoser_sound", 170},
    ["flight_of_the_voids_ship"] = {"morediscs:music_disc_flight_of_the_voids_ship_sound", 103},
    ["flyingship"] = {"morediscs:music_disc_flyingship_sound", 198},
    ["forest"] = {"morediscs:music_disc_forest_sound", 211},
    ["galacticloose"] = {"morediscs:music_disc_galacticloose_sound", 249},
    ["glitshymonum"] = {"morediscs:music_disc_glitshymonum_sound", 222},
    ["hue"] = {"morediscs:music_disc_hue_sound", 149},
    ["intothejungle"] = {"morediscs:music_disc_intothejungle_sound", 122},
    ["jungler"] = {"morediscs:music_disc_jungler_sound", 154},
    ["jungle"] = {"morediscs:music_disc_jungle_sound", 152},
    ["justyhebeginning"] = {"morediscs:music_disc_justyhebeginning_sound", 184},
    ["krushearz"] = {"morediscs:music_disc_krushearz_sound", 202},
    ["left_shift"] = {"morediscs:music_disc_left_shift_sound", 107},
    ["lgm"] = {"morediscs:music_disc_lgm_sound", 100},
    ["mangrove_swamp"] = {"morediscs:music_disc_mangrove_swamp_sound", 172},
    ["mesa_depth"] = {"morediscs:music_disc_mesa_depth_sound", 288},
    ["mush_roam"] = {"morediscs:music_disc_mush_roam_sound", 49},
    ["nostalg"] = {"morediscs:music_disc_nostalg_sound", 119},
    ["omen"] = {"morediscs:music_disc_omen_sound", 161},
    ["passion"] = {"morediscs:music_disc_passion_sound", 87},
    ["planettech"] = {"morediscs:music_disc_planettech_sound", 59},
    ["potion_of_swiftness"] = {"morediscs:music_disc_potion_of_swiftness_sound", 116},
    ["quithere"] = {"morediscs:music_disc_quithere_sound", 241},
    ["raid"] = {"morediscs:music_disc_raid_sound", 207},
    ["rainbows"] = {"morediscs:music_disc_rainbows_sound", 48},
    ["rain"] = {"morediscs:music_disc_rain_sound", 126},
    ["range"] = {"morediscs:music_disc_range_sound", 88},
    ["ravage"] = {"morediscs:music_disc_ravage_sound", 103},
    ["reloaded"] = {"morediscs:music_disc_reloaded_sound", 224},
    ["retri"] = {"morediscs:music_disc_retri_sound", 245},
    ["sand"] = {"morediscs:music_disc_sand_sound", 151},
    ["scopophobia"] = {"morediscs:music_disc_scopophobia_sound", 271},
    ["scorched"] = {"morediscs:music_disc_scorched_sound", 153},
    ["seeds"] = {"morediscs:music_disc_seeds_sound", 125},
    ["shallow"] = {"morediscs:music_disc_shallow_sound", 88},
    ["shroom"] = {"morediscs:music_disc_shroom_sound", 169},
    ["silence"] = {"morediscs:music_disc_silence_sound", 203},
    ["sky"] = {"morediscs:music_disc_sky_sound", 67},
    ["sleepz"] = {"morediscs:music_disc_sleepz_sound", 221},
    ["soul"] = {"morediscs:music_disc_soul_sound", 40},
    ["sound"] = {"morediscs:music_disc_sound_sound", 196},
    ["spiral"] = {"morediscs:music_disc_spiral_sound", 39},
    ["squidly"] = {"morediscs:music_disc_squidly_sound", 111},
    ["squiggles"] = {"morediscs:music_disc_squiggles_sound", 84},
    ["stridehop"] = {"morediscs:music_disc_stridehop_sound", 163},
    ["strikethemdown"] = {"morediscs:music_disc_strikethemdown_sound", 136},
    ["submerge"] = {"morediscs:music_disc_submerge_sound", 122},
    ["tall"] = {"morediscs:music_disc_tall_sound", 139},
    ["tearsofjoy"] = {"morediscs:music_disc_tearsofjoy_sound", 136},
    ["technobladeneverdiesatleastinourhearts"] = {"morediscs:music_disc_technobladeneverdiesatleastinourhearts_sound", 113},
    ["test"] = {"morediscs:music_disc_test_sound", 212},
    ["thebrightside"] = {"morediscs:music_disc_thebrightside_sound", 162},
    ["thedarkside"] = {"morediscs:music_disc_thedarkside_sound", 196},
    ["thelostsoul"] = {"morediscs:music_disc_thelostsoul_sound", 213},
    ["thespeedrunner"] = {"morediscs:music_disc_thespeedrunner_sound", 126},
    ["thesyndicate"] = {"morediscs:music_disc_thesyndicate_sound", 246},
    ["theunfinishedsymphony"] = {"morediscs:music_disc_theunfinishedsymphony_sound", 141},
    ["tide"] = {"morediscs:music_disc_tide_sound", 149},
    ["turfufact"] = {"morediscs:music_disc_turfufact_sound", 121},
    ["ucrism"] = {"morediscs:music_disc_ucrism_sound", 205},
    ["vengeful"] = {"morediscs:music_disc_vengeful_sound", 70},
    ["victory"] = {"morediscs:music_disc_victory_sound", 227},
    ["void"] = {"morediscs:music_disc_void_sound", 137},
    ["wardensprize"] = {"morediscs:music_disc_wardensprize_sound", 86},
    ["warden"] = {"morediscs:music_disc_warden_sound", 93},
    ["warped_forest"] = {"morediscs:music_disc_warped_forest_sound", 95},
    ["waves"] = {"morediscs:music_disc_waves_sound", 241},
    ["weepingsouls"] = {"morediscs:music_disc_weepingsouls_sound", 141},
    ["witherdance"] = {"morediscs:music_disc_witherdance_sound", 203},
    ["xziniron"] = {"morediscs:music_disc_xziniron_sound", 165},
    ["yarona"] = {"morediscs:music_disc_yarona_sound", 371},
    ["zayz"] = {"morediscs:music_disc_zayz_sound", 254},
}

if enableMoreDiscs then
    for k,v in pairs(more) do m[k] = v end
end

local programName = arg[0] or fs.getName(shell.getRunningProgram())
local completion = require("cc.shell.completion")
shell.setCompletionFunction(programName, completion.build(
    {completion.choice, {"list", "play", "radio", "stop", "blacklist", "bl", "favorite", "fav"}},
    function(shell, text, previous)
        if previous[2] == "play" then
            keyset = getKeys(m)
            table.sort(keyset)
            return completion.choice(shell, text, previous, keyset)
        elseif previous[2] == "radio" or previous[2] == "testradio" then
            return completion.choice(shell, text, previous, {"shuffle", "loop"})
        elseif previous[2] == "blacklist" or previous[2] == "bl" or previous[2] == "favorite" or previous[2] == "fav" then
            return completion.choice(shell, text, previous, {"add", "remove", "list"})
        end
    end,
    function(shell, text, previous)
        if previous[2] == "blacklist" or previous[2] == "bl" then
            if previous[3] == "add" then
                init()
                table.sort(blacklist)
                for k, v in pairs(blacklist) do
                    m[v] = nil
                end
                keyset = getKeys(m)
                table.sort(keyset)
                return completion.choice(shell, text, previous, keyset)
            elseif previous[3] == "remove" then
                init()
                table.sort(blacklist)
                return completion.choice(shell, text, previous, blacklist)
            elseif previous[2] == "play" then
                return completion.choice(shell, text, previous, {"loop"})
            end
        elseif previous[2] == "favorite" or previous[2] == "fav" then
            if previous[3] == "add" then
                init()
                table.sort(favorites)
                for k, v in pairs(favorites) do
                    m[v] = nil
                end
                keyset = getKeys(m)
                table.sort(keyset)
                return completion.choice(shell, text, previous, keyset)
            elseif previous[3] == "remove" then
                init()
                table.sort(favorites)
                return completion.choice(shell, text, previous, favorites)
            elseif previous[2] == "play" then
                return completion.choice(shell, text, previous, {"loop"})
            end
        elseif previous[3] == "shuffle" or previous[3] == "loop" then
            return completion.choice(shell, text, previous, {"fav", "bl", "all"})
        end
    end
))

function save(t, name, serialize)
    serialize = serialize or true
    local file = fs.open(name, "w")
    if serialize then t = textutils.serialize(t) end
    file.write(t)
    file.close()
end

function load(name)
    local file = fs.open(name, "r")
    local data = file.readAll()
    file.close()
    return textutils.unserialise(data)
end

function init()
    if not fs.exists("blacklist") then save(blacklist, "blacklist") else blacklist = load("blacklist") end
    if not fs.exists("favorite") then save(favorites, "favorite") else favorites = load("favorite") end
end

function has_key(arr, key)
    for k,v in pairs(arr) do
        if key == k then
            return true
        end
    end
    return false
end

function has_value(arr, value)
    for k,v in pairs(arr) do
        if value == v then
            return true
        end
    end
    return false
end

function getKeys(arr)
    local keyset = {}
    for k in pairs(arr) do
        table.insert(keyset, k)
    end
    return keyset
end

function get_key(arr, value)
    for k,v in pairs(arr) do
        if value == v then
            return k
        end
    end
end

function capitalize(str)
    local sentence

    str = str:gsub("_", " ")
    sentence = ""
    for word in string.gmatch(str, "[^%s]+") do
        if sentence == "" then sentence = word:gsub("^%l", string.upper) else sentence = sentence .." ".. word:gsub("^%l", string.upper) end
    end
    return sentence
end

function formatTime(length)
    local sec, min

    sec = length % 60
    min = (length - sec) / 60
    return min..":"..string.format("%02d",sec)
end

function list(list, header)
    table.sort(list)
    if #list > height - 2 then
        term.clear()
        term.setCursorPos(1,1)
        term.write(header)
        term.setCursorPos(1,2)
        term.write(string.rep("-", width))
        term.setCursorPos(1, height-1)
        term.write(string.rep("-", width))
        term.setCursorPos(1, height)
        term.write("scroll: up/down | exit: e")

        startLine = 3
        stopLine = height - 2
        listLength = stopLine - startLine
        listStart = 1
        listMax = #list
        listStopMax = listMax - listLength

        for i = startLine, stopLine, 1 do
            term.setCursorPos(1, i)
            term.clearLine()
            term.write(list[listStart + i - startLine])
        end

        while true do
            ---@diagnostic disable-next-line: undefined-field
            os.startTimer(1); local event, p1, p2, p3 = os.pullEventRaw()
            if event == "key_up" then
                if keys.getName(p1) == "e" then term.setCursorPos(1, height); term.clearLine(); break end
            elseif event == "key" then
                if keys.getName(p1) == "down" then
                    listStart = math.min(listStart + 1, listStopMax)
                elseif keys.getName(p1) == "up" then
                    listStart = math.max(listStart - 1, 1)
                end
                for i = startLine, stopLine, 1 do
                    song = list[listStart + i - startLine]
                    term.setCursorPos(1, i)
                    term.clearLine()
                    if has_value(favorites, song) then term.blit("\003 ", "50", "ff") end
                    if has_value(blacklist, song) then term.blit("\042 ", "e0", "ff") end
                    term.write(song)
                end
            elseif event == "terminate" then term.setCursorPos(1, height); term.clearLine(); break end
        end
    else
        term.clear()
        term.setCursorPos(1,1)
        term.write(header)
        term.setCursorPos(1,2)
        term.write(string.rep("-", width))
        term.setCursorPos(1,3)
        for i = 1, #list, 1 do
            song = list[i]
            if has_value(favorites, song) then term.blit("\003 ", "50", "ff") end
            if has_value(blacklist, song) then term.blit("\042 ", "e0", "ff") end
            term.write(song)
            term.setCursorPos(1, i+3)
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function math.clamp(x, min, max)
    if x < min then return min end
    if x > max then return max end
    return x
end

function toggle(type, song)
    local time = math.floor(os.epoch("utc")/1000) + displayTime

    if type == "bl" then
        if has_value(blacklist, song) then
            blacklist[get_key(blacklist, song)] = nil
            toggleInfo = {
                time = time,
                text  =   "- ".. song .. " blacklist",
                color =   "e0".. string.rep("0", #song+10),
                bgColor = "ff".. string.rep("f", #song+10)
            }
        else
            table.insert(blacklist, song)
            toggleInfo = {
                time = time,
                text  =   "+ ".. song .. " blacklist",
                color =   "50".. string.rep("0", #song+10),
                bgColor = "ff".. string.rep("f", #song+10)
            }
        end
        save(blacklist, "blacklist")
    elseif type == "fav" then
        if has_value(favorites, song) then
            favorites[get_key(favorites, song)] = nil
            toggleInfo = {
                time = time,
                text  =   "- ".. song .. " favorites",
                color =   "e0".. string.rep("0", #song+10),
                bgColor = "ff".. string.rep("f", #song+10)
            }
        else
            table.insert(favorites, song)
            toggleInfo = {
                time = time,
                text  =   "+ ".. song .. " favorites",
                color =   "50".. string.rep("0", #song+10),
                bgColor = "ff".. string.rep("f", #song+10)
            }
        end
        save(favorites, "favorite")
    end
end

function shortenInfo()

end

function play(song, pitch)
    pitch = pitch or 1
    pitch = math.clamp(pitch, 0.5, 2)
    local length, pos, startTime, time, startInfo, stopInfo, lineInfo, info

    length = (m[song][2] / pitch) + 3
    if arg[1] == "testradio" then length = 5 end

    term.clear()
    term.setCursorPos(1, height-2)
    term.write(string.rep("-", width))
    term.setCursorPos(1, height-1)
    term.write("fav: f | bl: b")
    term.setCursorPos(1, height)
    if arg[1] == "play"  then term.write("stop: s") else term.write("next: n | stop: s") end
    term.setCursorPos(1,1)
    term.write(capitalize(arg[1]).." | Now playing:")
    term.setCursorPos(1,2)
    term.write(string.rep("-", width))
    term.setCursorPos(1,3)
    if has_value(favorites, song) then term.blit("\003 ", "50", "ff") end
    if has_value(blacklist, song) then term.blit("\042 ", "e0", "ff") end
    term.write(capitalize(song))
    term.setCursorPos(1,4)
    pos = { term.getCursorPos() }
    startTime = math.floor(os.epoch("utc")/1000)
    s.playSound(m[song][1], m[song][3], pitch)
    while startTime + length > math.floor(os.epoch("utc")/1000) do
        time = math.floor(os.epoch("utc")/1000)
        if toggleInfo["time"] ~= nil then
            term.setCursorPos(pos[1], pos[2]+1)
                term.clearLine()
            if toggleInfo["time"] > time then
                term.blit(toggleInfo["text"], toggleInfo["color"], toggleInfo["bgColor"])
            end
        end
        term.setCursorPos(pos[1], pos[2])
        term.clearLine()
        term.write(formatTime(time-startTime).." / "..formatTime(length))

        ---@diagnostic disable-next-line: undefined-field
        os.startTimer(0); local event, p1, p2, p3 = os.pullEventRaw()
        if event == "key" then
            if arg[1] ~= "play" then
                if keys.getName(p1) == "n" then
                    length = 0
                end
            end
        elseif event == "key_up" then
            if keys.getName(p1) == "s" then
                s.stop(); radio = false; length = 0; term.clear(); term.setCursorPos(1,1)
            elseif keys.getName(p1) == "f" or keys.getName(p1) == "b" then
                if keys.getName(p1) == "f" then toggleType = "fav" else toggleType = "bl" end
                toggle(toggleType, song)
                term.setCursorPos(1,3)
                term.clearLine()
                if has_value(favorites, song) then term.blit("\003 ", "50", "ff") end
                if has_value(blacklist, song) then term.blit("\042 ", "e0", "ff") end
                term.write(capitalize(song))
            end
        elseif event == "terminate" then
            s.stop(); radio = false; length = 0; term.clear(); term.setCursorPos(1,1)
        end
    end
end

init()

if arg[1] ~= nil then
    if arg[1] == "play" then
        if arg[2] ~= nil then
            if has_key(m, arg[2]) then
                if arg[3] == "loop" then
                    radio = true
                    while radio do
                        play(arg[2])
                    end
                else
                    if arg[3] == nil then arg[3] = 1 else arg[3] = tonumber(arg[3]) end
                    play(arg[2], arg[3])
                end
                --s.playSound(m[arg[2]][1], 3, arg[3])
            else
                print("Song not found.")
            end
        else
            print("Song not found.")
        end
        term.clear(); term.setCursorPos(1,1)
    elseif arg[1] == "radio" or arg[1] == "testradio" then
        radio = true
        if arg[3] == "fav" then
            radioType = "fav"
            m2 = m
            m = {}
            for _, v in pairs(favorites) do
                m[v] = m2[v]
            end
            m2 = nil
        elseif arg[3] == "bl" or arg[3] == nil then
            radioType = "bl"
            for k, v in pairs(blacklist) do
                m[v] = nil
            end
        elseif arg[3] == "all" then
            radioType = "all"
        end
        local keyset = getKeys(m)
        if type(tonumber(arg[2])) == "number" then arg[3] = arg[2]; arg[2] = nil end
        if arg[2] == nil then arg[2] = "shuffle" end
        if arg[3] == nil then arg[3] = 1 else arg[3] = tonumber(arg[3]) end
        if arg[2] ~= nil then
            if arg[2] == "loop" then
                table.sort(keyset)
                while radio do
                    for _, v in pairs(keyset) do
                        if not radio then return end
                        --s.playSound(song, 3, arg[3])
                        play(v, arg[3])
                    end
                end
            else
                previous = ""
                while radio do
                    --s.playSound(song, 3, arg[3])
                    song = keyset[math.random(#keyset)]
                    if #m > 1 then while song == previous do song = keyset[math.random(#keyset)] end end
                    play(song, arg[3])
                    previous = song
                end
            end
        end
        term.clear(); term.setCursorPos(1,1)
    elseif arg[1] == "list" then
        local keys = {}
        for k, _ in pairs(m) do
            table.insert(keys, k)
        end
        table.sort(keys)
        list(keys, "Songlist")
    elseif arg[1] == "stop" then
        s.stop()
    elseif arg[1] == "blacklist" or arg[1] == "bl" then
        if arg[2] ~= nil then
            if arg[2] == "add" then
                if arg[3] ~= nil then
                    if has_key(m, arg[3]) then table.insert(blacklist, arg[3]); save(blacklist, "blacklist"); print("Added "..arg[3].." to blacklist.") else print("Song not found.") end
                end
            elseif arg[2] == "remove" then
                if arg[3] ~= nil then
                    if has_value(blacklist, arg[3]) then table.remove(blacklist, get_key(blacklist, arg[3])); save(blacklist, "blacklist"); print("Removed "..arg[3].." to blacklist.") else print("Song not found.") end
                end
            elseif arg[2] == "list" then
                table.sort(blacklist)
                list(blacklist, "Blacklist")
            end
        end
    elseif arg[1] == "favorite" or arg[1] == "fav" then
        if arg[2] ~= nil then
            if arg[2] == "add" then
                if arg[3] ~= nil then
                    if has_key(m, arg[3]) then table.insert(favorites, arg[3]); save(favorites, "favorite"); print("Added "..arg[3].." to favorites.") else print("Song not found.") end
                end
            elseif arg[2] == "remove" then
                if arg[3] ~= nil then
                    if has_value(favorites, arg[3]) then table.remove(favorites, get_key(favorites, arg[3])); save(favorites, "favorite"); print("Removed "..arg[3].." from favorites.") else print("Song not found.") end
                end
            elseif arg[2] == "list" then
                table.sort(favorites)
                list(favorites, "Favorites")
            end
        end
    end
else
    print("Usages:")
    print(programName)
    print("\157 list")
    print("\157 play <song> [loop]")
    print("\157 stop")
    print("\157 radio")
    print("\149 \157 shuffle <fav/bl/all>")
    print("\149 \141 loop <fav/bl/all>")
    print("\157 favorite/fav")
    print("\149 \157 list")
    print("\149 \157 add <song>")
    print("\149 \141 remove <song>")
    print("\141 blacklist/bl")
    print("  \157 list")
    print("  \157 add <song>")
    print("  \141 remove <song>")
end