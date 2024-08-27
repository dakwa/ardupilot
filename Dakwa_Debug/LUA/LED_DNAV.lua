--[[
 Script to use LED strips as position lights.
--]]
local num_leds = 4
local timer = 0
local update_rate = 88
-- Brightness for green or red light.
local br_color_0 = {
    color = 0,
    dire = false
}
local br_color_1 = {
    color = 30,
    dire = false
}
local br_color_2 = {
    color = 60,
    dire = false
}
local br_color_3 = {
    color = 90,
    dire = false
}
-- Brightness for flash light when armed.
local br_flash = 255

--[[
 Use SERVOn_FUNCTION 94 for LED strip
--]]
local chan = assert(SRV_Channels:find_channel(94), "LEDs : channel not set")

-- find_channel returns 0 to 15, convert to 1 to 16
chan = chan + 1

gcs:send_text(6, "LEDs strip: chan=" .. tostring(chan))

-- initialisation code
assert(serialLED:set_num_neopixel(chan, num_leds), "Failed LED setup")

function get_color(br_color)
    if (br_color.dire) then
        br_color.color = br_color.color - 10
    else
        br_color.color = br_color.color + 10
    end
    if (br_color.color > 120) then
        br_color.color = 120
        br_color.dire = true
    elseif (br_color.color < 0) then
        br_color.color = 0
        br_color.dire = false
    end
    return br_color
end

function setRGB(chanl, led, r, g, b)
    serialLED:set_RGB(chanl, led, g, r, b) --Neopixels I have are GRB for whatever reason?!
end

function preflight_check()
    if (ahrs:home_is_set()
            and battery:voltage(0) > 15
            and rc:get_pwm(12) > 1000
            and gcs:last_seen() > millis() - 2000) then
        return true;
    else
        return false;
    end
end

function preflight_set()
    if (ahrs:home_is_set()) then
        setRGB(chan, 0, 0, 0, 104)
    end
    if (battery:voltage(0) > 15) then
        setRGB(chan, 1, 0, 0, 104)
    end
    if (rc:get_pwm(12) > 1000) then
        setRGB(chan, 2, 0, 0, 104)
    end
    if (gcs:last_seen() > millis() - 2000) then
        setRGB(chan, 3, 0, 0, 104)
    end
end

function update_LEDs()
    if arming:is_armed() then
        if (vehicle:get_mode() == 13) then
            if (timer == 0) then
                setRGB(chan, 0, 0, 0, 0)
                setRGB(chan, 1, 0, 0, 0)
                setRGB(chan, 2, 0, 0, 0)
                setRGB(chan, 3, 0, 0, 0)
            elseif (timer == 1) then
                setRGB(chan, 0, br_flash, br_flash, br_flash)
                setRGB(chan, 1, br_flash, br_flash, br_flash)
                setRGB(chan, 2, br_flash, br_flash, br_flash)
                setRGB(chan, 3, br_flash, br_flash, br_flash)
            elseif (timer == 2) then
                setRGB(chan, 0, 0, 0, 0)
                setRGB(chan, 1, 0, 0, 0)
                setRGB(chan, 2, 0, 0, 0)
                setRGB(chan, 3, 0, 0, 0)
            elseif (timer == 3) then
                setRGB(chan, 0, br_flash, br_flash, br_flash)
                setRGB(chan, 1, br_flash, br_flash, br_flash)
                setRGB(chan, 2, br_flash, br_flash, br_flash)
                setRGB(chan, 3, br_flash, br_flash, br_flash)
            elseif (timer == 4) then
                setRGB(chan, 0, 0, 0, 0)
                setRGB(chan, 1, 0, 0, 0)
                setRGB(chan, 2, 0, 0, 0)
                setRGB(chan, 3, 0, 0, 0)
            elseif (timer == 5) then
                setRGB(chan, 0, br_flash, br_flash, br_flash)
                setRGB(chan, 1, br_flash, br_flash, br_flash)
                setRGB(chan, 2, br_flash, br_flash, br_flash)
                setRGB(chan, 3, br_flash, br_flash, br_flash)
            elseif (timer == 6) then
                setRGB(chan, 0, 0, 0, 0)
                setRGB(chan, 1, 0, 0, 0)
                setRGB(chan, 2, 0, 0, 0)
                setRGB(chan, 3, 0, 0, 0)
            elseif (timer == 7) then
                setRGB(chan, 0, br_flash, br_flash, br_flash)
                setRGB(chan, 1, br_flash, br_flash, br_flash)
                setRGB(chan, 2, br_flash, br_flash, br_flash)
                setRGB(chan, 3, br_flash, br_flash, br_flash)
            else
                setRGB(chan, 0, br_flash, 0, 0)
                setRGB(chan, 1, br_flash, 0, 0)
                setRGB(chan, 2, br_flash, 0, 0)
                setRGB(chan, 3, br_flash, 0, 0)
            end
            timer = timer + 1
            if (timer > 18) then
                timer = 0
            end
        else
            if (timer == 0) then
                setRGB(chan, 0, 0, 0, 0)
                setRGB(chan, 1, 0, 0, 0)
                setRGB(chan, 2, 0, 0, 0)
                setRGB(chan, 3, 0, 0, 0)
            elseif (timer == 1) then
                setRGB(chan, 0, br_flash, br_flash, br_flash)
                setRGB(chan, 1, br_flash, br_flash, br_flash)
                setRGB(chan, 2, br_flash, br_flash, br_flash)
                setRGB(chan, 3, br_flash, br_flash, br_flash)
            elseif (timer == 2) then
                setRGB(chan, 0, 0, 0, 0)
                setRGB(chan, 1, 0, 0, 0)
                setRGB(chan, 2, 0, 0, 0)
                setRGB(chan, 3, 0, 0, 0)
            elseif (timer == 3) then
                setRGB(chan, 0, br_flash, br_flash, br_flash)
                setRGB(chan, 1, br_flash, br_flash, br_flash)
                setRGB(chan, 2, br_flash, br_flash, br_flash)
                setRGB(chan, 3, br_flash, br_flash, br_flash)
            else
                setRGB(chan, 0, 0, br_flash, 0)
                setRGB(chan, 1, 0, br_flash, 0)
                setRGB(chan, 2, br_flash, 0, 0)
                setRGB(chan, 3, br_flash, 0, 0)
            end

            timer = timer + 1
            if (timer > 10) then
                timer = 0
            end
        end
    elseif arming:pre_arm_checks() and preflight_check() then
        br_color_0 = get_color(br_color_0)
        setRGB(chan, 0, 0, 0, br_color_0.color)
        br_color_1 = get_color(br_color_1)
        setRGB(chan, 1, 0, 0, br_color_1.color)
        br_color_2 = get_color(br_color_2)
        setRGB(chan, 2, 0, 0, br_color_2.color)
        br_color_3 = get_color(br_color_3)
        setRGB(chan, 3, 0, 0, br_color_3.color)
    else
        if (timer < 10) then
            setRGB(chan, -1, 100, 30, 0)
        else
            setRGB(chan, -1, 130, 10, 0)
        end
        
        preflight_set()

        timer = timer + 1
        if (timer > 20) then
            timer = 0
        end
    end
    serialLED:send(chan)
    return update_LEDs, update_rate
end

return update_LEDs()
