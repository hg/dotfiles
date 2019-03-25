-- vim: sts=4 sw=4 et

local utils = require 'mp.utils'

local function message(text)
    mp.msg.info(text)
    mp.osd_message(text)
end

function download_subs()
    message('Searching for subtitles…')

    args = {'subdl', '--output={m}.srt', mp.get_property('path')}
    proc = utils.subprocess({args = args})

    if proc.status == 0 then
        mp.commandv('rescan_external_files', 'reselect')
        message('Subtitles ready')
    else
        message('Subtitle search failed')
    end
end

mp.add_key_binding('d', 'download_subtitles', download_subs)

