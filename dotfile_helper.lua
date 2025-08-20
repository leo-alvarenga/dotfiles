#!/bin/lua

-- region meta
local function get_abs_script_path()
    local info = debug.getinfo(1, "S")
    local source = info.source:sub(2)

    if source:sub(1, 1) ~= "/" then
        local pwd = io.popen("pwd"):read("*l")

        return pwd .. "/" .. source
    end

    return source
end

local function to_dev_dir_path(scope)
    local dev_dir = string.gsub(string.gsub(get_abs_script_path(), '/' .. dotfile_helper_name, ''), '%./', '')

    return dev_dir .. '/' .. scope
end

options_and_flags = {
    '-h',
    '--help',
    '-v',
    '--verbose',
    '-y',
    '--yes',
    'sync'
}

available_targets = {
    'eww',
    'fuzzel',
    'ghostty',
    'pictures',
    'scripts',
    'starship',
    'sway',
    'swayidle',
    'waybar'
}

dev_mode = os.getenv('DEV_MODE') == 'true'
dotfile_helper_name = 'dotfile_helper.lua'
log_file_name = os.getenv('LOG_FILE') or 'dotfile_helper.log'
is_verbose = false
mode = arg[1]
yes_always = false
yes_always_delay = tonumber(os.getenv('YES_ALWAYS_DELAY')) or 5

log_file = io.open(log_file_name, 'a+')

-- config dirs

default_generic_config_path = '~/.config'

source_dirs = {
    eww = to_dev_dir_path('eww'),
    fuzzel = to_dev_dir_path('fuzzel'),
    ghostty = to_dev_dir_path('ghostty'),
    pictures = to_dev_dir_path('pictures'),
    scripts = to_dev_dir_path('scripts'),
    starship = to_dev_dir_path('starship.toml'),
    sway = to_dev_dir_path('sway'),
    swayidle = to_dev_dir_path('swayidle'),
    waybar = to_dev_dir_path('waybar')
}

dest_dirs = {
    eww = os.getenv('EWW_DIR') or default_generic_config_path,
    fuzzel = os.getenv('FUZZEL_DIR') or default_generic_config_path,
    ghostty = os.getenv('GHOSTTY_DIR') or default_generic_config_path,
    pictures = os.getenv('PICTURES_DIR') or default_generic_config_path,
    scripts = os.getenv('SCRIPTS_DIR') or default_generic_config_path,
    starship = os.getenv('STARSHIP_DIR') or default_generic_config_path .. '/starship.toml',
    sway = os.getenv('SWAY_DIR') or default_generic_config_path,
    swayidle = os.getenv('SWAYIDLE_DIR') or default_generic_config_path,
    waybar = os.getenv('WAYBAR_DIR') or default_generic_config_path,
}

-- endregion

-- region utilities

local function get_timestamp()
    return tostring(os.date('%Y-%m-%d %H:%M:%S', os.time()))
end

local function inner_log(values, is_debug)
    local function ilog(value)
        if is_debug and log_file then
            log_file:write(get_timestamp(), ' ', tostring(value), '\n')
        end

        print(value)
    end

    if type(values) == 'string' then
        ilog(values)
    elseif type(values) == "table" then
        for _, v in ipairs(values) do
            ilog(v)
        end
    end
end

local function log(values, additional)
    inner_log(values)

    if is_verbose then
        inner_log(additional)
    end
end

local function sleep(seconds)
    if type(seconds) ~= 'number' or seconds <= 0 then
        return
    end

    for s = 1, math.abs(seconds) do
        log('Waiting for ' .. tostring(seconds + 1 - s) .. ' seconds')

        local input = io.popen('sleep 1')
        if input then
            local _ = input:read("a")
            input:close()
        end
    end
end

local function debug(values)
    if not dev_mode then
        return
    end

    inner_log(values, true)
end

--- Loads all global variables
--- @return boolean
local function load_vars()
    debug('[Function] load_vars -> Set variables')

    is_verbose = not not table_find(arg, function(v)
        return v == '--verbose' or v == '-v'
    end)

    local is_there_mode = type(mode) == 'string'
    local is_help_mode = table_find(arg, function(v)
        return v == '--help' or v == '-h'
    end) or false

    yes_always = not not table_find(arg, function(v)
        return v == '--yes' or v == '-y'
    end)

    debug('[Function] load_vars -> Variables set (is_verbose : ' ..
        tostring(is_verbose) ..
        ', mode: ' ..
        tostring(mode) .. ', is_help_mode: ' .. tostring(is_help_mode) .. ', yes_always: ' .. tostring(yes_always) .. ')')

    if yes_always then
        log('\nWARNING: Yes always is enabled...')

        sleep(yes_always_delay)
        log('')
    end

    if not is_there_mode and not is_help_mode then
        debug('[Function] load_vars -> Early exit (mode: ' ..
            tostring(mode) .. ', is_help_mode: ' .. tostring(is_help_mode) .. ')')
        log('A mode must be included', 'Access the HELP (--help or -h) menu for more info')

        return false
    end

    return true
end

function table_find(table, comparison)
    if type(table) ~= 'table' or type(comparison) ~= 'function' then
        return nil
    end

    local found = false
    for _, v in ipairs(table) do
        found = comparison(v)

        if found then
            return v
        end
    end

    return nil
end

local function is_file_or_dir(file_path)
    debug('[Function] is_file_or_dir -> Start')

    if type(file_path) ~= 'string' then
        debug('[Function] is_file_or_dir -> ' .. file_path .. ' is not a string')

        return nil
    end

    debug('[Function] is_file_or_dir -> Using io to open it as file')
    local file = io.open(file_path, 'r')

    if file and file:read('l') ~= nil then
        debug('[Function] is_file_or_dir -> ' .. file_path .. ' is file')
        file:close()

        return 'File'
    end

    debug('[Function] is_file_or_dir -> Using io check if its a directory')
    local possible_dir = io.popen('cd ' .. file_path .. ' 2>/dev/null && echo dir')

    if not possible_dir then
        debug('[Function] is_file_or_dir -> Something when wrong')

        return nil
    end

    local result = possible_dir:read("l")
    possible_dir:close()

    if result == 'dir' then
        debug('[Function] is_file_or_dir -> ' .. file_path .. ' is dir')

        return 'Dir'
    end

    debug('[Function] is_file_or_dir -> ' .. file_path .. ' does not exist')
    return nil
end

local function is_valid_target(candidate)
    local comparison = function(value)
        return value == tostring(candidate)
    end

    local candidate_is_option_or_flag = table_find(options_and_flags, comparison)
    local candidate_is_valid_target = table_find(available_targets, comparison)

    return not candidate_is_option_or_flag and candidate_is_valid_target
end

local function get_targets()
    local targets = {}

    for _, value in ipairs(arg) do
        if is_valid_target(value) then
            table.insert(targets, value)
        elseif value == '*' or value == 'all' then
            targets = available_targets
            break
        end
    end

    return targets
end

local function confirm(message, callback)
    if callback and type(callback) ~= 'function' then
        return false
    end

    local answer = ''
    if not yes_always then
        log(message)
        answer = io.stdin:read("l")

        log('')
    end

    if callback then
        callback(answer)
    else
        return yes_always or string.lower(answer) == 'y'
    end

    return true
end

local function move_file_or_directory(path, new_path, scope)
    debug('[Function] move_file_or_directory -> Start (path: ' ..
        tostring(path) .. ', dest: ' .. tostring(new_path) .. ')')

    log('Syncing "' .. path .. '"...')

    if type(path) ~= 'string' or type(new_path) ~= 'string' or type(scope) ~= 'string' then
        debug('[Function] move_file_or_directory -> path is not a string')
        return 1
    end

    local command_flags = ''

    local dest = new_path
    local src_path = source_dirs[scope]
    local test_dest = dest

    if test_dest == default_generic_config_path then
        test_dest = test_dest .. '/' .. scope
    end

    local path_kind = is_file_or_dir(test_dest)
    debug('[Function] move_file_or_directory -> Path type is "' .. (path_kind or 'NULL') .. '"')
    if path_kind then
        debug('[Function] move_file_or_directory -> Asking for permission')

        if yes_always then
            debug('[Function] move_file_or_directory -> Yes always is enabled, skipping')
        end

        local should_continue = confirm({ '\n(' .. path_kind .. ') "' ..
        test_dest .. '" already exists. If you continue, its contents will be OVERWRITTEN.',
            'Are you sure you want to continue? (y/N)' })

        if not should_continue then
            debug('[Function] move_file_or_directory -> User has declined. Skipping "' .. path .. '"')
            log('Skipping "' .. path .. "'\n")

            return 0
        end
    end

    if not string.match(src_path, '%.') then
        command_flags = '-r'
    end

    local command = table.concat({ 'cp', command_flags, src_path, dest }, ' ')

    debug('[Function] move_file_or_directory -> Moving files (path: ' .. path .. ', dest: ' .. dest .. ')')
    debug('[Function] move_file_or_directory -> Command: "' .. command .. '"')

    os.execute(command)

    debug('[Function] move_file_or_directory -> Finish (path: ' .. path .. ')')
    return 0
end

-- endregion

-- region Help option

function help()
    log('Dotfile Helper')
    log('')

    log('Usage: "' .. '/' .. ' <mode> <flags>"')
    log('')

    log('Modes:')
    log('    - "setup": Setup dotfiles')
    log('    - "sync": Sync dotfile changes in the "~/.config" dir')
    log('')

    log('Flags:')
    log('    --help or -h       This menu')
    log('    --verbose or -v    Include more verbose logging')

    return 0
end

-- endregion

-- region Sync option

function chmod_scripts(update_scripts, dev_dir)
    debug('[Function] chmod_scripts -> Start')

    if update_scripts then
        log('Ensuring your user has "execute" permission for the scripts...')

        debug('[Function] chmod_scripts -> Adding "execute" permission to all dest scripts')
        os.execute('chmod a+x ' .. dest_dirs.scripts .. '/*')
    end

    if type(dev_dir) ~= 'string' then
        debug('[Function] chmod_scripts -> Early finish. "dev_dir" is not valid (dev_dir: "' .. tostring(dev_dir) .. '")')
        return 1
    end

    log('Ensuring your user has "execute" permission for this script...')
    debug('[Function] chmod_scripts -> Adding "execute" permission to all local repo scripts')
    os.execute('chmod a+x ' .. dev_dir .. '/scripts/*')
    os.execute('chmod a+x ' .. dev_dir .. '/' .. dotfile_helper_name)

    debug('[Function] chmod_scripts -> Finish')
    return 0
end

function sync()
    debug('\n[Function] sync -> Start')

    log('Determining the root of this directory...')
    debug('[Function] sync -> Getting the root of this directory')


    debug('[Function] sync -> Getting targets')
    local targets = get_targets()
    local target_list = '[' .. table.concat(targets, ', ') .. ']'

    debug('[Function] sync -> Targets set (targets: ' .. target_list .. ' )')
    log(nil, 'Targets: ' .. target_list)

    debug('[Function] sync -> Starting to copy files over')
    for _, domain in ipairs(targets) do
        local scope = tostring(domain)
        local new_dir = dest_dirs[scope]

        if new_dir then
            debug('[Function] sync -> Copying from domain "' .. scope .. '"')
            move_file_or_directory(source_dirs[scope], new_dir, scope)
        end
    end

    local update_scripts = table_find(targets, function(val)
        return val == 'scripts'
    end) ~= nil

    local dev_dir = string.gsub(get_abs_script_path(), '/' .. dotfile_helper_name, '')
    chmod_scripts(update_scripts, dev_dir)

    debug('[Function] sync -> Finish')
    log('All done!')
    return 0
end

-- endregion

-- region Main loop

local function main()
    log('Dotfile manager\n')

    debug('[Loop] main -> Start')

    local ok = load_vars()
    if not ok then
        return 1
    end

    local case = {
        ['--help'] = help,
        ['-h'] = help,
        sync = sync
    }

    if not case[mode] then
        debug('[Loop] main -> Invalid mode (mode: ' .. tostring(mode) .. ')')
        log('"' .. mode .. '" is not a valid mode', 'Access the HELP (--help or -h) menu for more info')

        return 1
    end

    debug('[Loop] main -> Hand-off')
    return case[mode]()
end

-- endregion

main()
