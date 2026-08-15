hl.config({
    input = {
        kb_layout = "br",
    },
})

hl.monitor({
    output = "DP-2",
    mode = "1920x1080@165",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@179.96",
    position = "1920x0",
    scale = 1,
})

hl.bind(
    "SUPER + SHIFT + D",
    hl.dsp.exec_cmd("discord"),
    { description = "Abrir Discord" }
)

hl.bind(
    "SUPER + SHIFT + P",
    hl.dsp.exec_cmd("spotify"),
    { description = "Abrir Spotify" }
)
hl.unbind("SUPER + G")

hl.bind(
    "SUPER + G",
    hl.dsp.exec_cmd("steam"),
    { description = "Abrir Steam" }
)
