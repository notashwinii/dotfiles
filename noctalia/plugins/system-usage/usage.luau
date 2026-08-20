local REFRESH_MS = 2000

function update()
    noctalia.setUpdateInterval(REFRESH_MS)

    local stats = noctalia.systemStats()
    if stats == nil then
        barWidget.setVisible(false)
        return
    end

    local cpu = math.floor(stats.cpu.usagePercent + 0.5)
    local ram = math.floor(stats.ram.usagePercent + 0.5)
    local disk = noctalia.diskStats("/")
    local storage = disk and math.floor(disk.usagePercent + 0.5) or nil
    local usageText = string.format("CPU %d%% · RAM %d%%", cpu, ram)
    if storage ~= nil then
        usageText = usageText .. string.format(" · Disk %d%%", storage)
    end

    local container = barWidget.isVertical() and ui.column or ui.row
    barWidget.render(container({ gap = 3, align = "center" }, {
        ui.glyph({ name = "cpu", size = 12 }),
        ui.label({ text = usageText, fontSize = 11 }),
    }))
    barWidget.setTooltip(string.format(
        "System usage\nCPU: %d%%\nRAM: %d%% (%d / %d MiB)%s",
        cpu,
        ram,
        math.floor(stats.ram.usedMb + 0.5),
        math.floor(stats.ram.totalMb + 0.5),
        storage and string.format("\nDisk: %d%% used", storage) or ""
    ))
    barWidget.setVisible(true)
end
