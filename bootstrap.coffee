{exec} = require 'child_process'

config = require './config.json'

upgrade = (sn, bin) ->
    new Promise (resolve, reject) ->
        cmdline = "dfu-util -d 1d50:6018,:6017 -s 0x08002000:leave -S #{sn} -D #{bin}"
        exec cmdline, (err, stdout) ->
            if stdout.match 'File downloaded successfully'
                resolve()
            else
                reject(err)

Promise.all(upgrade(sn, 'blackmagic.bin') for sn of config)
    .then ->
        console.log "All done!"
