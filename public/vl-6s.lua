--6s alv-vl-uni
maxSwipeVPN = 4
dayDeleteRrs = 7

listBundle = { "com.puztheconty.vlgame01" }

//general

function killApp()
    for i, a in pairs(listBundle) do
        appKill(a)
    end
end

function openApp(bundle)
    repeat
        toast(bundle .. " - chờ 7s", 6)
        appRun(bundle)
        usleep(6000000)
    until frontMostAppId() == bundle
    return 1
end

---------------
--RANDOM BUNDLE
---------------

bundle = ""
openedBundle = {}
countBundle = 0
ok = 0

function resetCountBundle()
    for a = 1, #listBundle do
        openedBundle[a] = 0
    end
    countBundle = 0
end

resetCountBundle()

function randomBundle()
    if countBundle == #listBundle then
        resetCountBundle()
    end
    while true do
        i = math.random(1, #listBundle)
        if openedBundle[i] == 0 then
            bundle = listBundle[i]
            openedBundle[i] = 1
            countBundle = countBundle + 1
            break
        end
    end
end

function resetData()
    toast("Reset Data", 10)
    repeat
        openURL("XoaInfo://Reset")
        for a = 0, 40 do
            usleep(1000000)
            if frontMostAppId() == nil then
                return
            end
        end
    until frontMostAppId() == nil
end
-----------
--VPN ✓✓✓
-----------

function swipe()
    for a = 1, math.random(0, maxSwipeVPN) do touchDown(2, 192.96, 1231.37) usleep(67943.17) touchMove(2, 205.27, 1195.73) usleep(16728.54) touchMove(2, 214.51, 1152.98) usleep(16624.33) touchMove(2, 223.75, 1099.02) usleep(16528.46) touchMove(2, 228.88, 1026.72) usleep(16524.62) touchMove(2, 229.91, 951.38) usleep(16750.00) touchMove(2, 229.91, 860.76) usleep(16596.88) touchMove(2, 229.91, 767.11) usleep(16772.29) touchMove(2, 224.77, 672.41) usleep(16671.21) touchMove(2, 214.51, 585.86) usleep(16552.29) touchMove(2, 206.30, 509.51) usleep(16690.33) touchMove(2, 196.04, 440.28) usleep(16743.04) touchMove(2, 186.80, 387.34) usleep(16664.17) touchMove(2, 179.62, 349.66) usleep(16595.83) touchMove(2, 176.54, 331.34) usleep(16719.67) touchMove(2, 175.51, 324.22) usleep(16579.92) touchMove(2, 175.51, 322.18) usleep(50126.92) touchMove(2, 175.51, 324.22) usleep(16703.92) touchMove(2, 175.51, 327.27) usleep(16675.54) touchMove(2, 175.51, 330.32) usleep(15262.04) touchUp(2, 175.51, 334.40) usleep(60000)
    end
end

function vpn()
    toast("Kill all", 1)
    appRun("com.privax.hmaprovpn")
    usleep(4000000)
    while true do
        toast("Check", 1)
        if frontMostAppId() ~= "com.privax.hmaprovpn" then
            appRun("com.privax.hmaprovpn")
        end
        if getColor(539, 923) == 16777215 then
            ok = 1
            break
        else
            usleep(600000)
            tap(373, 827)
            usleep(600000)
            tap(370, 780)
            usleep(600000)
            tap(319, 740)
            usleep(600000)
        end
    end
    usleep(1700000)
    tap(627, 923)
    usleep(1500000)
    tap(620, 268)
    usleep(1300000)
    swipe()
    for a, b in pairs(findColor(0xA1B0BA, 1, { 682, 1323, 1, -1000 }, nil, true, false)) do
        y1 = b[2] - 10
    end
    for a, b in pairs(findColor(0xA1B0BA, 1, { 570, 1323, 1, -1000 }, nil, true, true)) do
        y2 = b[2] + 10
    end
    usleep(1000000)
    tap(450, math.random(y1, y2))
    usleep(1000000)
    ok = 0
    while true do
        if getColor(349, 530) == 16632367 then
            break
        else
            ok = ok + 1
            if ok == 9 then
                ok = 0
                tap(366, 656)
                usleep(600000)
            end
            tap(373, 827)
            usleep(600000)
            tap(319, 740)
            usleep(600000)
        end
    end
end

-----------
-- VUNGLE ✓✓✓
-----------
function impression()
    return math.random(2, 5)
end -- số impr chạy

function timeshow()
    return math.random(25, 65)
end -- tgian bấm show sau khi tắt quảng cáo

function checkHomeVl()
    if getColor(447, 667) == 3458905 and getColor(500, 676) == 16777215 then
        return 1
    else
        return -1
    end
end

function clickShowVl(count, max)
    time = timeshow()
    for i = time, 0, -1 do
        toast(count .. "/" .. max .. " Show: " .. i, 1)
        usleep(1000000)
        if frontMostAppId() == "com.privax.hmaprovpn" then
            return -1
        end
    end
    usleep(math.random(0, 1000000))
    for i = 1, 5 do
        tap(447, 667)
        toast("tap " .. i)
        usleep(2000000)
        if checkHomeVl() == -1 then
            return 1
        end
        if i == 5 then
            return -1
        end
    end
end

function closeAdVL()
    for i = math.random(23, 33), 1, -1 do
        toast("close " .. i, 1)
        usleep(1000000)
    end
    tap(704, 49)
    usleep(5500000)
    tap(704, 49)
    usleep(1000000)
    if frontMostAppId() ~= bundleVungle then
        openApp(bundleVungle)
    end
    if checkHomeVl() == -1 then
        toast("Close appstore")
        tap(74, 136)
        usleep(1000000)
        if frontMostAppId() ~= bundleVungle then
            openApp(bundleVungle)
        end
        if checkHomeVl() == -1 then
            usleep(5500000)
            tap(704, 49)
        end
        usleep(1000000)
    end
    if frontMostAppId() ~= bundleVungle then
        openApp(bundleVungle)
    end
    return checkHomeVl()
end

-----------
--MAIN ✓✓✓
-----------
while true do
    ::xoainfo::
    killApp()
    vpn()
    randomBundle()

    ::vungle::
    bundle = bundleVungle
    impr = impression()
    for i = 0, impr do
        if checkHomeVl() == 1 then
            if clickShowVl(i, impr) == 1 then
                if closeAdVL() == -1 then
                    killApp()
                    if openApp(bundle) == -1 then
                        goto xoainfo
                    end
                else
                    if i > 3 and math.random(0, 5) == 2 and i < impr then
                        appKill(bundle)
                        for i = math.random(20, 60), 1, -1 do
                            toast("Fake thoát app: " .. i, 1)
                            usleep(1000000)
                        end
                        openApp(bundle)
                    else
                        toast("Không văng")
                    end
                end
            else
                goto xoainfo
            end
        else
            killApp()
            if openApp(bundle) == -1 then
                goto xoainfo
            end
        end
    end
end
