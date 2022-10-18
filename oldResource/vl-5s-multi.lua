-- vl5s green button
maxSwipeVPN = 4

listBundle = {"com.BubbleShot.game", "com.BubbleTea.game", "com.Crown-SolitaireCardGame.game"}
---------------
--RANDOM BUNDLE
---------------

bundle = ""
openedBundle = {}
countBundle = 0
ok = 0

function resetCountBundle()
    for a = 1, #listBundle do openedBundle[a] = 0 end
    countBundle = 0
end

resetCountBundle()
function randomBundle()
    if countBundle == #listBundle then resetCountBundle() end
    while true do
        i = math.random(1, #listBundle)
        if openedBundle[i] == 0 then
            bundle = listBundle[i]
            openedBundle[i] = 1;
            countBundle = countBundle + 1;
            break
        end
    end
end
-----------
-- VUNGLE ✓✓✓
-----------
function impression() return math.random(3, 7) end -- số impr chạy
function timefirstshow() return math.random(8, 14) end -- tgian bấm show LẦN ĐẦU
function timeshow() return math.random(8, 14) end -- tgian bấm show sau khi tắt quảng cáo

function killApp() for i, a in pairs(listBundle) do appKill(a) end end

function checkHome()
    if getColor(447, 602) == 3458905 and getColor(496, 591) == 16777215 then
        return 1
    else
        return -1
    end
end

function openApp(bundle)
    repeat
        toast(bundle.." - chờ 9s", 9)
		appRun(bundle)
        usleep(9000000)
    until frontMostAppId() == bundle
    if getColor(225,487)==15019525 and getColor(392,487)==15019525 then
		return -1
	else
		return 1
	end
end

function clickshow(count, max)
    if count == 1 then
        time = timefirstshow()
    else
        time = timeshow()
    end
    for i = time, 0, -1 do

        toast(count .. "/" .. max .. " Show: " .. i, 1)
        usleep(1000000)
        if frontMostAppId() == "com.privax.hmaprovpn" then return -1 end
    end
    usleep(math.random(0, 1000000))
    for i = 1, 5 do
        tap(447, 602)
        toast("tap " .. i)
        usleep(1000000)
        if checkHome() == -1 then return 1 end
        if i == 5 then return -1 end
    end
end

function closead()
    for i = math.random(23, 33), 1, -1 do
        toast("close " .. i, 1)
        usleep(1000000)
    end
    tap(582, 55)
    usleep(5500000)
    tap(582, 55)
    usleep(1000000)
    if frontMostAppId() == "com.apple.AppStore" then
        appRun(bundle)
        usleep(1000000)
    end
    if checkHome() == -1 then
        for i = 1, 10 do
            toast("Close appstore")
            if getColor(80, 88) == getColor(80, 89) and getColor(80, 88) ~=
                getColor(77, 72) then
                tap(80, 88)
                usleep(1000000)
                if checkHome() == -1 then
                    usleep(5500000)
                    tap(582, 55)
                end
                break
            end
            usleep(1000000)
        end
    end
    return checkHome()
end

-----------
--MAIN ✓✓✓
-----------
function checkvpnstatus()ok=0;while true do toast("Check",1)if frontMostAppId()~="com.privax.hmaprovpn"then appRun("com.privax.hmaprovpn")end;if getColor(476,956)==16777215 then ok=1;break else usleep(600000)tap(333,733)usleep(600000)tap(323,650)usleep(600000)end end;return ok end;function swipe()for a=1,math.random(0,maxSwipeVPN)do touchDown(2,340.35,953.82)usleep(16549)touchMove(2,340.35,911.26)usleep(16502)touchMove(2,340.35,835.27)usleep(16781)touchMove(2,343.40,748.15)usleep(16468)touchMove(2,349.50,669.13)usleep(16587)touchMove(2,356.61,593.13)usleep(16984)touchMove(2,364.74,529.31)usleep(16395)touchMove(2,369.81,487.76)usleep(16758)touchMove(2,372.87,473.58)usleep(16756)touchMove(2,373.89,466.49)usleep(16560)touchMove(2,373.89,465.47)usleep(33463)touchMove(2,373.89,468.52)usleep(16630)touchMove(2,369.81,492.82)usleep(16328)touchUp(2,365.75,496.88)usleep(60000)end end;function vpn()appRun("com.privax.hmaprovpn")ok=0;usleep(4500000)checkvpnstatus()usleep(1700000)tap(244.85,947.74)usleep(1500000)tap(559.81,256.77)usleep(1300000)swipe()for a,b in pairs(findColor(0xA1B0BA,1,{570,1134,1,-820},nil,true,false))do y1=b[2]-10 end;for a,b in pairs(findColor(0xA1B0BA,1,{570,1134,1,-820},nil,true,true))do y2=b[2]+10 end;usleep(1000000)tap(300,math.random(y1,y2))usleep(1000000)ok=0;while true do if getColor(417,539)==1797555 then break else ok=ok+1;if ok==9 then ok=0;tap(221,470)usleep(600000)end;tap(323,650)usleep(600000)tap(320,732)usleep(600000)tap(282,1090)usleep(600000)end end;ok=0;repeat openURL("XoaInfo://Reset")for a=0,40 do usleep(1000000)if frontMostAppId()==nil then ok=1;break end end until ok==1 end
statusAds=true;countCheckAdsFail=0;countAlv=0;errCB=0

while true do
    ::xoainfo::
    killApp()
  	randomBundle()
    vpn()
    usleep(3000000)

    ::vungle::
    impr = impression()
    for i = 1, impr do
        if checkHome() == 1 then
            if clickshow(i, impr) == 1 then
                if closead() == -1 then
                    killApp()
                    if openApp(bundle)==-1 then goto xoainfo end
                end
            else
                goto  xoainfo
            end
        else
            killApp()
            if openApp(bundle)==-1 then goto xoainfo end
        end
    end
end
