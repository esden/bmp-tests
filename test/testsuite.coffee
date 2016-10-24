config = require '../config.json'
GDB = require 'node-gdb'

{exec} = require 'child_process'
assert = require 'assert'
{CompositeDisposable} = require 'event-kit'

upgrade = (sn, bin) ->
    new Promise (resolve, reject) ->
        cmdline = "dfu-util -d 1d50:6018,:6017 -s 0x08002000:leave -S #{sn} -D #{bin}"
        exec cmdline, (err, stdout) ->
            if stdout.match 'File downloaded successfully'
                resolve()
            else
                reject new Error err

sleep = (ms) ->
    new Promise (resolve, reject) -> setTimeout resolve, ms

describe "Bootload all boards", ->
    it "bootload", ->
        this.timeout 60000
        Promise.all(upgrade(sn, 'blackmagic.bin') for board, sn of config)
            .then -> sleep(1000)

waitStop = (gdb, cmd) ->
    new Promise (resolve, reject) ->
        x = new CompositeDisposable
        x.add gdb.exec.onRunning ->
            x.add gdb.exec.onExited ->
                x.dispose()
                reject new Error 'Target exited'
            x.add gdb.exec.onStopped (result) ->
                x.dispose()
                resolve result.frame
        cmd()

for board, sn of config
    do (board, sn) -> describe "Test #{board} on BMP ##{sn}", ->
        port = "/dev/serial/by-id/usb-Black_Sphere_Technologies_Black_Magic_Probe_#{sn}-if00"
        gdb = new GDB('arm-none-eabi-gdb')
        gdb.setCwd(process.cwd())
        gdb.setFile("targets/#{board}/test.elf")
        #gdb.onGdbmiRaw (data) ->
        #    console.log data

        before "connect", ->
            gdb.connect()
                .then ->
                    gdb.setCwd(process.cwd())
                .then ->
                    gdb.setFile("targets/#{board}/test.elf")
                .then ->
                    gdb.send_mi "-target-select extended-remote #{port}"

        it "scan and attach", ->
            gdb.send_cli "mon tpwr enable"
            .then ->
                sleep(500)
            .then ->
                gdb.send_cli "mon swd"
            .then ->
                gdb.send_mi '-target-attach 1'

        it "load to flash", ->
            gdb.send_mi "-target-download"

        it "verify loaded image", ->
            gdb.send_cli "compare-sections"

        it "start target program", ->
            waitStop gdb, -> gdb.exec.start()

        it "read static memory", ->
            gdb.vars.evalExpression 'magic_string'
                .then (value) ->
                    assert value == '"This string is magic"'

        after "cleanup", ->
            gdb.send_mi '-gdb-exit'
