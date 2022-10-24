-- IR 5s + Vl autoshow
bundleIr = 'com.BattleMage.iss'
bundleVl = ''
maxSwipeVPN = 9

openApp = function(bdl)
        toast(bdl)
		appRun(bdl)
        usleep(6000000)
end
killApp = function() appKill(bundleIr) appKill(bundleVl) end

waiting = function(time, message)
    for i = time, 0, -1 do
        toast(message .. ": " .. i, 1)
        usleep(1000000)
    end
end

checkStore = function()
    -- for a,b in pairs(findColor(0x007AFF,1,{34,37,77,14}))do tap(b[1], b[2]) usleep(2000000) return true end
    tap(45,45)
end

checkvpnstatus = function()ok=0;while true do toast("Check",1)if frontMostAppId()~="com.privax.hmaprovpn"then appRun("com.privax.hmaprovpn")end;if getColor(476,956)==16777215 then ok=1;break else usleep(600000)tap(333,733)usleep(600000)tap(323,650)usleep(600000)end end;return ok end;function swipe()for a=1,math.random(0,maxSwipeVPN)do touchDown(2,340.35,953.82)usleep(16549)touchMove(2,340.35,911.26)usleep(16502)touchMove(2,340.35,835.27)usleep(16781)touchMove(2,343.40,748.15)usleep(16468)touchMove(2,349.50,669.13)usleep(16587)touchMove(2,356.61,593.13)usleep(16984)touchMove(2,364.74,529.31)usleep(16395)touchMove(2,369.81,487.76)usleep(16758)touchMove(2,372.87,473.58)usleep(16756)touchMove(2,373.89,466.49)usleep(16560)touchMove(2,373.89,465.47)usleep(33463)touchMove(2,373.89,468.52)usleep(16630)touchMove(2,369.81,492.82)usleep(16328)touchUp(2,365.75,496.88)usleep(60000)end end;function vpn()appRun("com.privax.hmaprovpn")ok=0;usleep(4500000)checkvpnstatus()usleep(1700000)tap(244.85,947.74)usleep(1500000)tap(559.81,256.77)usleep(1300000)swipe()for a,b in pairs(findColor(0xA1B0BA,1,{570,1134,1,-820},nil,true,false))do y1=b[2]-10 end;for a,b in pairs(findColor(0xA1B0BA,1,{570,1134,1,-820},nil,true,true))do y2=b[2]+10 end;usleep(1000000)tap(300,math.random(y1,y2))usleep(1000000)ok=0;while true do if getColor(417,539)==1797555 then break else ok=ok+1;if ok==9 then ok=0;tap(221,470)usleep(600000)end;tap(323,650)usleep(600000)tap(320,732)usleep(600000)tap(282,1090)usleep(600000)end end;ok=0;repeat openURL("XoaInfo://Reset")for a=0,40 do usleep(1000000)if frontMostAppId()==nil then ok=1;break end end until ok==1 end

-----------
-- IRON ✓✓✓
-----------
ir = {
    impr = function() return math.random(6, 8) end, -- số impr chạy
    timeShow = function() return math.random(4,6) end, -- tgian bam show sau khi tắt quảng cáo
    checkHome = function()
        if (getColor(143,361)==10066329) then tap(323,654) usleep(100000) end
        return getColor(164, 64) == 16777215 and getColor(194, 44) == 196693    
    end,

    clickShow = function(isReward)
        for i = 1, 2 do
            if isReward then tap(313, 258)
            else tap(438, 646) end

            toast("tap show " .. i)
            usleep(2000000)

            if not ir.checkHome() then return true end
            if i == 5 then return false end
        end
    end,

    isFinishAd = function()
        f = getColor(10,1130)
        return (
            f == getColor(366,1130)
            and f == getColor(628,1130)
            and f ~= getColor(10, 1120)
            and f ~= getColor(366,1120)
            and f ~= getColor(628,1120)
        )
    end,

    closeAd = function()
        tap(611, 27)

        waiting(10, 'Check Store')
        checkStore()

        waiting(10, 'Close last ad')
        tap(611, 27)

        waiting(3, '')
        return ir.checkHome()
    end,
}

-----------
--MAIN ✓✓✓
-----------
while true do
    ::xoainfo::
    --killApp()
    --vpn()
    --waiting(3, '')

    ::joinIR::
    openApp(bundleIr)

    for i = 40, 1, -1 do
        toast(i)
        usleep(1000000)
        if not ir.checkHome() then break end
        if i==1 then goto outIR end
    end

    for i=60, 1, -1 do
        toast('Check finish ad: '..i)
        usleep(1000000)
        if ir.isFinishAd() then waiting(10, 'Tap skip') break end
        if i==1 then goto joinIRLoop end
    end

    ir.closeAd()

    ::joinIRLoop::

    impr = ir.impr()
    for i = 2, impr do
        ::reloadIR::
        if not ir.checkHome() then
            killApp()
            openApp(bundleIr)
            goto reloadIR
        end

        waiting(ir.timeShow(), 'show')

        if not ir.clickShow(math.random(1,100) <= 80) then
            goto xoainfo
        end
        
        for i=60, 1, -1 do
            toast('Check finish ad: '..i)
            usleep(1000000)
            if ir.isFinishAd() then waiting(7, 'Tap skip') break end
            if i==1 then goto continueIR end
        end

        if not ir.closeAd() then
            goto continueIR
        end
        ::continueIR::
    end
    ::outIR::
end