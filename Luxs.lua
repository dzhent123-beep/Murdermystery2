local TweenService=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Lighting=game:GetService("Lighting")
local HttpService=game:GetService("HttpService")
local VU=game:GetService("VirtualUser")
local LP=Players.LocalPlayer

local PURPLE=Color3.fromRGB(150,80,255)
local BG=Color3.fromRGB(18,16,26)
local BG2=Color3.fromRGB(26,23,38)
local BG3=Color3.fromRGB(36,32,52)
local WHITE=Color3.fromRGB(255,255,255)
local GRAY=Color3.fromRGB(160,155,180)
local BODY_GRAY=Color3.fromRGB(150,150,156)
local AIM_RED=Color3.fromRGB(255,40,40)
local VALID_KEY="DRHUB_NURHUB_BEST"

local PALETTE={["Фиолетовый"]=Color3.fromRGB(150,80,255),["Красный"]=Color3.fromRGB(255,60,60),["Оранжевый"]=Color3.fromRGB(255,150,40),["Жёлтый"]=Color3.fromRGB(255,225,60),["Зелёный"]=Color3.fromRGB(70,230,110),["Голубой"]=Color3.fromRGB(70,200,255),["Синий"]=Color3.fromRGB(70,100,255),["Розовый"]=Color3.fromRGB(255,110,200),["Белый"]=Color3.fromRGB(255,255,255),["Золотой"]=Color3.fromRGB(255,200,80)}
local COLOR_NAMES={"Радужный","Фиолетовый","Красный","Оранжевый","Жёлтый","Зелёный","Голубой","Синий","Розовый","Белый","Золотой"}
local WING_COLORS={"Белый","Золотой","Радужный","Фиолетовый","Голубой","Розовый","Красный"}
local ROLE_COLORS={Murderer=Color3.fromRGB(255,60,60),Sheriff=Color3.fromRGB(70,130,255),Innocent=Color3.fromRGB(70,230,110)}
local ROLE_NAMES={"Murderer","Sheriff","Innocent"}

local function getColor(n,t,o) if n=="Радужный" then return Color3.fromHSV((((t or 0)*0.2)+(o or 0))%1,0.85,1) end return PALETTE[n] or PURPLE end
local connections={} local function track(c) connections[#connections+1]=c; return c end
local function tween(o,ti,p,s,d) local tw=TweenService:Create(o,TweenInfo.new(ti,s or Enum.EasingStyle.Quint,d or Enum.EasingDirection.Out),p); tw:Play(); return tw end
local function corner(o,r) local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r); c.Parent=o; return c end
local function stroke(o,col,th,tr) local s=Instance.new("UIStroke"); s.Color=col; s.Thickness=th or 1; s.Transparency=tr or 0; s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border; s.Parent=o; return s end

local Flags,Setters,Defaults={},{},{} local function register(k,d,s) Flags[k]=d; Defaults[k]=d; Setters[k]=s end

local gui=Instance.new("ScreenGui")
gui.Name="luxxs"; gui.ResetOnSpawn=false; gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; gui.IgnoreGuiInset=true
local okP,parent=pcall(function() return (gethui and gethui()) or game:GetService("CoreGui") end)
if not okP or not parent then parent=LP:WaitForChild("PlayerGui") end
if parent:FindFirstChild("luxxs") then parent.luxxs:Destroy() end
if parent:FindFirstChild("luxxsKey") then parent.luxxsKey:Destroy() end
gui.Parent=parent

do
    local sg=Instance.new("ScreenGui"); sg.Name="luxxsKey"; sg.ResetOnSpawn=false; sg.IgnoreGuiInset=true; sg.DisplayOrder=999; sg.Parent=parent
    local bg=Instance.new("Frame"); bg.Size=UDim2.new(1,0,1,0); bg.BackgroundColor3=Color3.fromRGB(10,8,16); bg.BorderSizePixel=0; bg.Parent=sg
    local gr=Instance.new("UIGradient"); gr.Color=ColorSequence.new(Color3.fromRGB(22,14,44),Color3.fromRGB(6,4,12)); gr.Rotation=90; gr.Parent=bg
    local tl=Instance.new("TextLabel"); tl.BackgroundTransparency=1; tl.AnchorPoint=Vector2.new(0.5,0.5); tl.Position=UDim2.new(0.5,0,0.42,0); tl.Size=UDim2.new(0,700,0,130); tl.RichText=true; tl.Font=Enum.Font.GothamBlack; tl.TextSize=90; tl.TextColor3=WHITE; tl.Text='<b>lu<font color="rgb(150,80,255)">xxs</font></b>'; tl.TextTransparency=1; tl.Parent=bg
    local gl=Instance.new("TextLabel"); gl.BackgroundTransparency=1; gl.AnchorPoint=Vector2.new(0.5,0.5); gl.Position=UDim2.new(0.5,0,0.42,0); gl.Size=UDim2.new(0,700,0,130); gl.Font=Enum.Font.GothamBlack; gl.TextSize=90; gl.TextColor3=PURPLE; gl.Text="luxxs"; gl.TextTransparency=1; gl.ZIndex=-1; gl.Parent=bg
    local sl=Instance.new("TextLabel"); sl.BackgroundTransparency=1; sl.AnchorPoint=Vector2.new(0.5,0.5); sl.Position=UDim2.new(0.5,0,0.42,72); sl.Size=UDim2.new(0,500,0,30); sl.Font=Enum.Font.Gotham; sl.TextSize=15; sl.TextColor3=GRAY; sl.Text=""; sl.TextTransparency=1; sl.Parent=bg
    local kp=Instance.new("Frame"); kp.AnchorPoint=Vector2.new(0.5,0.5); kp.Position=UDim2.new(0.5,0,0.56,0); kp.Size=UDim2.new(0,400,0,52); kp.BackgroundColor3=BG2; kp.BorderSizePixel=0; kp.Visible=false; kp.Parent=bg; corner(kp,12); stroke(kp,PURPLE,1.5,0.3)
    local ki=Instance.new("TextBox"); ki.BackgroundTransparency=1; ki.Position=UDim2.new(0,18,0,0); ki.Size=UDim2.new(1,-110,1,0); ki.Font=Enum.Font.Gotham; ki.TextSize=15; ki.TextColor3=WHITE; ki.PlaceholderText="Введите ключ..."; ki.PlaceholderColor3=Color3.fromRGB(110,105,130); ki.Text=""; ki.TextXAlignment=Enum.TextXAlignment.Left; ki.ClearTextOnFocus=false; ki.Parent=kp
    local kb=Instance.new("TextButton"); kb.AnchorPoint=Vector2.new(1,0.5); kb.Position=UDim2.new(1,-8,0.5,0); kb.Size=UDim2.new(0,88,0,36); kb.BackgroundColor3=PURPLE; kb.Text="ВОЙТИ"; kb.Font=Enum.Font.GothamBold; kb.TextSize=13; kb.TextColor3=WHITE; kb.AutoButtonColor=false; kb.Parent=kp; corner(kb,8)
    local st=Instance.new("TextLabel"); st.BackgroundTransparency=1; st.AnchorPoint=Vector2.new(0.5,0.5); st.Position=UDim2.new(0.5,0,0.56,82); st.Size=UDim2.new(0,500,0,22); st.Font=Enum.Font.GothamMedium; st.TextSize=14; st.TextColor3=Color3.fromRGB(255,80,80); st.Text=""; st.TextTransparency=1; st.Parent=bg
    task.spawn(function()
        task.wait(0.15); tl.TextSize=130
        tween(tl,0.4,{TextTransparency=0}); tween(gl,0.4,{TextTransparency=0.4})
        tween(tl,1.0,{TextSize=90,Position=UDim2.new(0.5,0,0.35,0)}); tween(gl,1.0,{TextSize=90,Position=UDim2.new(0.5,0,0.35,0),TextTransparency=0.75})
        task.wait(1.0); sl.Text="введите ключ для продолжения"; tween(sl,0.5,{TextTransparency=0})
        kp.Visible=true; kp.Size=UDim2.new(0,0,0,52); tween(kp,0.55,{Size=UDim2.new(0,400,0,52)},Enum.EasingStyle.Back)
        pcall(function() ki:CaptureFocus() end)
    end)
    local done=false
    local function tryKey()
        if done then return end
        if ki.Text==VALID_KEY then
            done=true; st.Text="✓ Ключ принят"; st.TextColor3=Color3.fromRGB(70,230,110); tween(st,0.3,{TextTransparency=0}); kb.BackgroundColor3=Color3.fromRGB(70,230,110); ki.TextEditable=false
            task.wait(0.9); tween(st,0.4,{TextTransparency=1}); tween(kp,0.4,{Size=UDim2.new(0,0,0,52)},Enum.EasingStyle.Quint,Enum.EasingDirection.In); tween(sl,0.4,{TextTransparency=1})
            task.wait(0.55); tween(tl,0.6,{TextTransparency=1,Position=UDim2.new(0.5,0,0.5,0),TextSize=120}); tween(gl,0.6,{TextTransparency=1,TextSize=120,Position=UDim2.new(0.5,0,0.5,0)})
            task.wait(0.4); tween(bg,0.7,{BackgroundTransparency=1}); task.wait(0.75); sg:Destroy()
        else
            st.Text="✗ Неверный ключ"; st.TextColor3=Color3.fromRGB(255,80,80); tween(st,0.25,{TextTransparency=0})
            local op=kp.Position
            tween(kp,0.05,{Position=UDim2.new(op.X.Scale,op.X.Offset-12,op.Y.Scale,op.Y.Offset)}); task.wait(0.06)
            tween(kp,0.05,{Position=UDim2.new(op.X.Scale,op.X.Offset+12,op.Y.Scale,op.Y.Offset)}); task.wait(0.06)
            tween(kp,0.05,{Position=op}); ki.Text=""
        end
    end
    kb.MouseButton1Click:Connect(tryKey)
    ki.FocusLost:Connect(function(enter) if enter then tryKey() end end)
    repeat task.wait(0.1) until done
end

local function notify(text)
    local f=Instance.new("Frame"); f.AnchorPoint=Vector2.new(1,1); f.Size=UDim2.new(0,260,0,40); f.Position=UDim2.new(1,290,1,-24); f.BackgroundColor3=BG2; f.ZIndex=20; f.Parent=gui; corner(f,10); stroke(f,PURPLE,1.5,0.3)
    local l=Instance.new("TextLabel"); l.BackgroundTransparency=1; l.Size=UDim2.new(1,-20,1,0); l.Position=UDim2.new(0,12,0,0); l.RichText=true; l.Font=Enum.Font.GothamMedium; l.TextSize=13; l.TextColor3=WHITE; l.TextXAlignment=Enum.TextXAlignment.Left; l.Text='<b>lu<font color="rgb(150,80,255)">xxs</font></b>   '..text; l.ZIndex=21; l.Parent=f
    tween(f,0.45,{Position=UDim2.new(1,-24,1,-24)},Enum.EasingStyle.Back)
    task.delay(2.6,function() tween(f,0.35,{Position=UDim2.new(1,290,1,-24)},Enum.EasingStyle.Quint,Enum.EasingDirection.In); task.delay(0.4,function() f:Destroy() end) end)
end

local function makeDraggable(handle,target,onClick)
    local dragging,startPos,startInput,moved=false,nil,nil,false
    handle.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=true; moved=false; startInput=input.Position; startPos=target.Position
            input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false; if not moved and onClick then onClick() end end end)
        end
    end)
    track(UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
            local delta=input.Position-startInput
            if delta.Magnitude>5 then moved=true end
            if moved then tween(target,0.08,{Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)},Enum.EasingStyle.Linear) end
        end
    end))
end

-- КОСМЕТИКА (Anchored, без хитбоксов)
local Cos={}
local function destroyCos(n) if Cos[n] then for _,o in ipairs(Cos[n].objs) do pcall(function() o:Destroy() end) end Cos[n]=nil end end
local function newPart(sz,p)
    local pt=Instance.new("Part")
    pt.Size=sz
    pt.CanCollide=false
    pt.CanQuery=false
    pt.CanTouch=false
    pt.CastShadow=false
    pt.CanClimb=false
    pt.Massless=true
    pt.Anchored=true
    pt.TopSurface=Enum.SurfaceType.Smooth
    pt.BottomSurface=Enum.SurfaceType.Smooth
    pt.Parent=p
    return pt
end

local function buildWings()
    destroyCos("wings")
    local char=LP.Character; if not char then return end
    local torso=char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    if not torso then
        torso=char:WaitForChild("UpperTorso",1) or char:WaitForChild("Torso",1)
        if not torso then return end
    end
    local model=Instance.new("Model"); model.Name="luxxsWings"
    local feathers={}
    for _,side in ipairs({-1,1}) do
        for i=1,8 do
            local len=6.0-i*0.45
            local p=newPart(Vector3.new(len,0.55,0.18),model)
            p.Material=Enum.Material.Neon
            p.Color=Color3.fromRGB(255,255,255)
            p.Transparency=0
            p.CFrame=torso.CFrame
            feathers[#feathers+1]={part=p,side=side,i=i,len=len}
        end
    end
    model.Parent=char
    Cos.wings={objs={model},model=model,feathers=feathers}
end

local function buildHat()
    destroyCos("hat")
    local char=LP.Character; if not char then return end
    local head=char:FindFirstChild("Head"); if not head then return end
    local model=Instance.new("Model"); model.Name="luxxsHat"; local slices={}
    for i=1,10 do
        local r=2.0*(1-(i-1)/10)+0.1
        local p=newPart(Vector3.new(0.2,r*2,r*2),model)
        p.Shape=Enum.PartType.Cylinder; p.Material=Enum.Material.SmoothPlastic
        p.CFrame=head.CFrame*CFrame.new(0,0.55+(i-1)*0.19,0)*CFrame.Angles(0,0,math.pi/2)
        slices[i]=p
    end
    model.Parent=char; Cos.hat={objs={model},model=model,slices=slices}
end

local function buildTrail()
    destroyCos("trail")
    local char=LP.Character; if not char then return end
    local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local a0=Instance.new("Attachment"); a0.Name="luxxsA0"; a0.Parent=hrp
    local a1=Instance.new("Attachment"); a1.Name="luxxsA1"; a1.Parent=hrp
    local tr=Instance.new("Trail"); tr.Attachment0=a0; tr.Attachment1=a1; tr.LightEmission=1; tr.FaceCamera=true
    tr.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.1),NumberSequenceKeypoint.new(1,1)}); tr.Parent=hrp
    Cos.trail={objs={a0,a1,tr},a0=a0,a1=a1,trail=tr}
end

local function colorSeq(name,t)
    if name=="Радужный" then local kp={} for k=0,6 do kp[#kp+1]=ColorSequenceKeypoint.new(k/6,getColor(name,t,-k/6*0.8)) end return ColorSequence.new(kp) end
    return ColorSequence.new(getColor(name))
end

track(RunService.Heartbeat:Connect(function()
    local t=os.clock()
    local char=LP.Character

    local w=Cos.wings
    if w and w.model.Parent and char then
        local torso=char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
        if torso then
            local flap=math.sin(t*(Flags["Visuals/Скорость крыльев"] or 3))*0.25
            for _,f in ipairs(w.feathers) do
                local a=math.rad(15+f.i*11)+flap*(0.6+f.i*0.12)
                local theta=(f.side==1) and a or (math.pi-a)
                local offset=CFrame.new(f.side*0.85,0.9,f.i*0.15)
                    *CFrame.Angles(0,f.side*-0.45,0)
                    *CFrame.Angles(0,0,theta)
                    *CFrame.new(f.len/2+0.5,0,0)
                f.part.CFrame=torso.CFrame*offset
                f.part.Color=getColor(Flags["Visuals/Цвет крыльев"],t,f.i*0.05)
                f.part.Transparency=0
            end
        end
    end

    local h=Cos.hat
    if h and h.model.Parent and char then
        local head=char:FindFirstChild("Head")
        if head then
            for i,s in ipairs(h.slices) do
                s.CFrame=head.CFrame*CFrame.new(0,0.55+(i-1)*0.19,0)*CFrame.Angles(0,0,math.pi/2)
                s.Color=getColor(Flags["Visuals/Цвет шляпы"],t,i*0.07)
            end
        end
    end

    local tr=Cos.trail
    if tr and tr.trail.Parent then
        local width=(Flags["Visuals/Ширина трейла"] or 4)*0.4
        tr.a0.Position=Vector3.new(0,width/2,0); tr.a1.Position=Vector3.new(0,-width/2,0)
        tr.trail.Lifetime=math.max(0.1,(Flags["Visuals/Длина трейла"] or 10)/10); tr.trail.Color=colorSeq(Flags["Visuals/Цвет трейла"],t)
    end
end))

local function applyCosmetics()
    if Flags["Visuals/Крылья"] then buildWings() else destroyCos("wings") end
    if Flags["Visuals/Китайская шляпа"] then buildHat() else destroyCos("hat") end
    if Flags["Visuals/Трейл"] then buildTrail() else destroyCos("trail") end
end

track(LP.CharacterAdded:Connect(function(c)
    c:WaitForChild("HumanoidRootPart",10); c:WaitForChild("Head",10); task.wait(0.5)
    applyCosmetics()
end))

-- SHADERS
local Shader={}
local PRESETS={
    ["Cinematic"]={b=0.02,c=0.25,s=-0.1,tint=Color3.fromRGB(255,238,220),bloom=0.5,bsize=28,bth=1,rays=0.08,dens=0.3,haze=1.2,acol=Color3.fromRGB(190,190,205)},
    ["Neon Night"]={b=-0.03,c=0.3,s=0.5,tint=Color3.fromRGB(215,190,255),bloom=1.3,bsize=42,bth=0.75,rays=0,dens=0.35,haze=1.5,acol=Color3.fromRGB(110,70,200)},
    ["Sunset"]={b=0.03,c=0.15,s=0.3,tint=Color3.fromRGB(255,205,160),bloom=0.6,bsize=30,bth=0.9,rays=0.25,dens=0.3,haze=1.8,acol=Color3.fromRGB(255,170,120)},
    ["Vivid"]={b=0.02,c=0.2,s=0.7,tint=Color3.fromRGB(255,255,255),bloom=0.4,bsize=24,bth=1,rays=0.1,dens=0.2,haze=0.5,acol=Color3.fromRGB(200,215,235)},
    ["Noir"]={b=-0.02,c=0.4,s=-1,tint=Color3.fromRGB(235,235,245),bloom=0.3,bsize=20,bth=1,rays=0,dens=0.35,haze=2.2,acol=Color3.fromRGB(160,160,170)},
    ["Dream"]={b=0.05,c=-0.05,s=0.3,tint=Color3.fromRGB(255,210,255),bloom=1,bsize=50,bth=0.7,rays=0.15,dens=0.4,haze=1,acol=Color3.fromRGB(255,190,240)},
}
local PRESET_NAMES={"Выкл","Cinematic","Neon Night","Sunset","Vivid","Noir","Dream"}
local NEUTRAL={b=0,c=0,s=0,tint=Color3.fromRGB(255,255,255),bloom=0,bsize=24,bth=1,rays=0}

local function ensureShader()
    if Shader.cc then return end
    local function mk(c) local i=Instance.new(c); i.Name="luxxs_"..c; i.Parent=Lighting; return i end
    Shader.cc=mk("ColorCorrectionEffect"); Shader.bloom=mk("BloomEffect"); Shader.rays=mk("SunRaysEffect")
    local atm=Lighting:FindFirstChildOfClass("Atmosphere")
    if atm then Shader.atm=atm; Shader.atmOrig={Density=atm.Density,Haze=atm.Haze,Color=atm.Color}
    else Shader.atm=mk("Atmosphere"); Shader.atm.Density=0; Shader.atmCreated=true end
end

local function disableShader(full)
    if not Shader.cc then return end
    Shader.cc.Enabled=false; Shader.bloom.Enabled=false; Shader.rays.Enabled=false
    if Shader.atmOrig then pcall(function() tween(Shader.atm,0.5,Shader.atmOrig) end) elseif Shader.atm then pcall(function() Shader.atm.Density=0 end) end
    if full then for _,k in ipairs({"cc","bloom","rays"}) do pcall(function() Shader[k]:Destroy() end) end; if Shader.atmCreated then pcall(function() Shader.atm:Destroy() end) end; Shader={} end
end

local function refreshShader(time)
    time=time or 0.9
    local preset=PRESETS[Flags["Shaders/Пресет"] or "Выкл"]
    local ob=(Flags["Shaders/Яркость"] or 0)/100; local oc=(Flags["Shaders/Контраст"] or 0)/100
    local os_=(Flags["Shaders/Насыщенность"] or 0)/100; local obl=(Flags["Shaders/Bloom"] or 0)/50
    if not preset and ob==0 and oc==0 and os_==0 and obl==0 then disableShader(false); return end
    ensureShader(); local p=preset or NEUTRAL
    Shader.cc.Enabled=true; Shader.bloom.Enabled=true; Shader.rays.Enabled=true
    tween(Shader.cc,time,{Brightness=p.b+ob,Contrast=p.c+oc,Saturation=p.s+os_,TintColor=p.tint})
    tween(Shader.bloom,time,{Intensity=p.bloom+obl,Size=p.bsize,Threshold=p.bth})
    tween(Shader.rays,time,{Intensity=p.rays})
    if preset then tween(Shader.atm,time,{Density=preset.dens,Haze=preset.haze,Color=preset.acol})
    elseif Shader.atmOrig then tween(Shader.atm,time,Shader.atmOrig) else tween(Shader.atm,time,{Density=0}) end
end

-- ОКНО
local main=Instance.new("CanvasGroup")
main.AnchorPoint=Vector2.new(0.5,0.5); main.Position=UDim2.new(0.5,0,0.5,0)
main.Size=UDim2.new(0,880,0,440); main.BackgroundColor3=BG; main.BorderSizePixel=0; main.GroupTransparency=1; main.Visible=false; main.Parent=gui
corner(main,14); stroke(main,PURPLE,1.5,0.4)
local scale=Instance.new("UIScale"); scale.Scale=0.7; scale.Parent=main

local top=Instance.new("Frame"); top.Size=UDim2.new(1,0,0,46); top.BackgroundColor3=BG2; top.BorderSizePixel=0; top.Parent=main; corner(top,14)
local title=Instance.new("TextLabel"); title.BackgroundTransparency=1; title.Position=UDim2.new(0,16,0,0); title.Size=UDim2.new(0,200,1,0); title.RichText=true; title.Font=Enum.Font.GothamBold; title.TextSize=24; title.TextXAlignment=Enum.TextXAlignment.Left; title.Text='<b>lu<font color="rgb(150,80,255)">xxs</font></b>'; title.TextColor3=WHITE; title.Parent=top
local ver=Instance.new("TextLabel"); ver.BackgroundTransparency=1; ver.Position=UDim2.new(1,-160,0,0); ver.Size=UDim2.new(0,120,1,0); ver.Font=Enum.Font.Gotham; ver.TextSize=12; ver.TextColor3=GRAY; ver.TextXAlignment=Enum.TextXAlignment.Right; ver.Text="v3.4 • MM2"; ver.Parent=top

local side=Instance.new("Frame"); side.Position=UDim2.new(0,0,0,46); side.Size=UDim2.new(0,130,1,-46); side.BackgroundColor3=BG2; side.BorderSizePixel=0; side.Parent=main
local sideList=Instance.new("Frame"); sideList.BackgroundTransparency=1; sideList.Position=UDim2.new(0,8,0,10); sideList.Size=UDim2.new(1,-16,1,-20); sideList.Parent=side
local indicator=Instance.new("Frame"); indicator.Size=UDim2.new(0,4,0,24); indicator.Position=UDim2.new(0,0,0,15); indicator.BackgroundColor3=PURPLE; indicator.BorderSizePixel=0; indicator.ZIndex=3; indicator.Parent=side; corner(indicator,2)
local pages=Instance.new("Frame"); pages.BackgroundTransparency=1; pages.Position=UDim2.new(0,140,0,56); pages.Size=UDim2.new(0,470,1,-66); pages.ClipsDescendants=true; pages.Parent=main
local previewPanel=Instance.new("Frame"); previewPanel.Position=UDim2.new(0,620,0,56); previewPanel.Size=UDim2.new(0,250,1,-66); previewPanel.BorderSizePixel=0; previewPanel.Parent=main

local tabs,currentTab,switching={},nil,false

local function selectTab(tab)
    if currentTab==tab or switching then return end
    switching=true; local old=currentTab; currentTab=tab
    tween(indicator,0.35,{Position=UDim2.new(0,0,0,15+tab.index*40)},Enum.EasingStyle.Back)
    for _,t in ipairs(tabs) do tween(t.button,0.25,{TextColor3=(t==tab) and WHITE or GRAY,BackgroundTransparency=(t==tab) and 0.7 or 1}) end
    if old then tween(old.page,0.2,{GroupTransparency=1,Position=UDim2.new(0,-20,0,0)}); task.delay(0.2,function() old.page.Visible=false end) end
    task.delay(old and 0.15 or 0,function()
        tab.page.Position=UDim2.new(0,20,0,0); tab.page.GroupTransparency=1; tab.page.Visible=true
        tween(tab.page,0.35,{GroupTransparency=0,Position=UDim2.new(0,0,0,0)})
        task.delay(0.35,function() switching=false end)
    end)
end

local function createTab(name)
    local index=#tabs
    local button=Instance.new("TextButton"); button.Size=UDim2.new(1,0,0,34); button.Position=UDim2.new(0,0,0,index*40); button.BackgroundColor3=PURPLE; button.BackgroundTransparency=1; button.Font=Enum.Font.GothamMedium; button.TextSize=14; button.TextColor3=GRAY; button.Text=name; button.AutoButtonColor=false; button.Parent=sideList; corner(button,8)
    local page=Instance.new("CanvasGroup"); page.Size=UDim2.new(1,0,1,0); page.BackgroundTransparency=1; page.Visible=false; page.GroupTransparency=1; page.Parent=pages
    local scroll=Instance.new("ScrollingFrame"); scroll.Size=UDim2.new(1,0,1,0); scroll.BackgroundTransparency=1; scroll.BorderSizePixel=0; scroll.ScrollBarThickness=3; scroll.ScrollBarImageColor3=PURPLE; scroll.CanvasSize=UDim2.new(0,0,0,0); scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y; scroll.Parent=page
    local layout=Instance.new("UIListLayout"); layout.Padding=UDim.new(0,8); layout.SortOrder=Enum.SortOrder.LayoutOrder; layout.Parent=scroll
    local pad=Instance.new("UIPadding"); pad.PaddingRight=UDim.new(0,6); pad.PaddingTop=UDim.new(0,2); pad.Parent=scroll
    local tab={button=button,page=page,scroll=scroll,index=index,name=name}; table.insert(tabs,tab)
    button.MouseButton1Click:Connect(function() selectTab(tab) end)
    button.MouseEnter:Connect(function() if currentTab~=tab then tween(button,0.2,{TextColor3=WHITE}) end end)
    button.MouseLeave:Connect(function() if currentTab~=tab then tween(button,0.2,{TextColor3=GRAY}) end end)

    function tab:Label(text)
        local l=Instance.new("TextLabel"); l.Size=UDim2.new(1,0,0,20); l.BackgroundTransparency=1; l.Font=Enum.Font.GothamBold; l.TextSize=13; l.TextColor3=PURPLE; l.TextXAlignment=Enum.TextXAlignment.Left; l.Text=text; l.Parent=scroll
    end

    function tab:Toggle(text,default,callback)
        local key=name.."/"..text; local state=default or false
        local row=Instance.new("TextButton"); row.Size=UDim2.new(1,0,0,38); row.BackgroundColor3=BG3; row.AutoButtonColor=false; row.Text=""; row.Parent=scroll; corner(row,8)
        local lbl=Instance.new("TextLabel"); lbl.BackgroundTransparency=1; lbl.Position=UDim2.new(0,12,0,0); lbl.Size=UDim2.new(1,-70,1,0); lbl.Font=Enum.Font.Gotham; lbl.TextSize=14; lbl.TextColor3=WHITE; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Text=text; lbl.Parent=row
        local sw=Instance.new("Frame"); sw.AnchorPoint=Vector2.new(1,0.5); sw.Position=UDim2.new(1,-12,0.5,0); sw.Size=UDim2.new(0,40,0,20); sw.BackgroundColor3=state and PURPLE or Color3.fromRGB(60,56,80); sw.Parent=row; corner(sw,10)
        local knob=Instance.new("Frame"); knob.Size=UDim2.new(0,16,0,16); knob.Position=state and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8); knob.BackgroundColor3=WHITE; knob.Parent=sw; corner(knob,8)
        register(key,state,function(v)
            state=v and true or false; Flags[key]=state
            tween(sw,0.25,{BackgroundColor3=state and PURPLE or Color3.fromRGB(60,56,80)})
            tween(knob,0.3,{Position=state and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)},Enum.EasingStyle.Back)
            if callback then task.spawn(callback,state) end
        end)
        row.MouseButton1Click:Connect(function() Setters[key](not state) end)
        row.MouseEnter:Connect(function() tween(row,0.2,{BackgroundColor3=Color3.fromRGB(44,39,64)}) end)
        row.MouseLeave:Connect(function() tween(row,0.2,{BackgroundColor3=BG3}) end)
    end

    function tab:Button(text,callback)
        local b=Instance.new("TextButton"); b.Size=UDim2.new(1,0,0,38); b.BackgroundColor3=PURPLE; b.BackgroundTransparency=0.25; b.AutoButtonColor=false; b.Font=Enum.Font.GothamMedium; b.TextSize=14; b.TextColor3=WHITE; b.Text=text; b.Parent=scroll; corner(b,8)
        b.MouseEnter:Connect(function() tween(b,0.2,{BackgroundTransparency=0}) end)
        b.MouseLeave:Connect(function() tween(b,0.2,{BackgroundTransparency=0.25}) end)
        b.MouseButton1Click:Connect(function()
            tween(b,0.08,{Size=UDim2.new(1,-8,0,34)})
            task.delay(0.08,function() tween(b,0.25,{Size=UDim2.new(1,0,0,38)},Enum.EasingStyle.Back) end)
            if callback then task.spawn(callback) end
        end)
    end

    function tab:Slider(text,min,max,default,callback)
        local key=name.."/"..text; local value=default or min
        local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,50); row.BackgroundColor3=BG3; row.Parent=scroll; corner(row,8)
        local lbl=Instance.new("TextLabel"); lbl.BackgroundTransparency=1; lbl.Position=UDim2.new(0,12,0,4); lbl.Size=UDim2.new(1,-24,0,20); lbl.Font=Enum.Font.Gotham; lbl.TextSize=14; lbl.TextColor3=WHITE; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Text=text..": "..tostring(value); lbl.Parent=row
        local bar=Instance.new("Frame"); bar.Position=UDim2.new(0,12,0,34); bar.Size=UDim2.new(1,-24,0,6); bar.BackgroundColor3=Color3.fromRGB(60,56,80); bar.Parent=row; corner(bar,3)
        local fill=Instance.new("Frame"); fill.Size=UDim2.new((value-min)/(max-min),0,1,0); fill.BackgroundColor3=PURPLE; fill.BorderSizePixel=0; fill.Parent=bar; corner(fill,3)
        register(key,value,function(v)
            v=math.clamp(math.floor((tonumber(v) or min)+0.5),min,max); value=v; Flags[key]=v
            lbl.Text=text..": "..tostring(v)
            tween(fill,0.1,{Size=UDim2.new((v-min)/(max-min),0,1,0)},Enum.EasingStyle.Linear)
            if callback then task.spawn(callback,v) end
        end)
        local sliding=false
        local function update(x) local rel=math.clamp((x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1); Setters[key](min+(max-min)*rel) end
        bar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sliding=true; update(i.Position.X) end end)
        track(UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sliding=false end end))
        track(UIS.InputChanged:Connect(function(i) if sliding and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then update(i.Position.X) end end))
    end

    function tab:Choice(text,options,default,callback)
        local key=name.."/"..text; local idx=table.find(options,default) or 1
        local row=Instance.new("TextButton"); row.Size=UDim2.new(1,0,0,38); row.BackgroundColor3=BG3; row.AutoButtonColor=false; row.Text=""; row.Parent=scroll; corner(row,8)
        local lbl=Instance.new("TextLabel"); lbl.BackgroundTransparency=1; lbl.Position=UDim2.new(0,12,0,0); lbl.Size=UDim2.new(0.5,-12,1,0); lbl.Font=Enum.Font.Gotham; lbl.TextSize=14; lbl.TextColor3=WHITE; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Text=text; lbl.Parent=row
        local val=Instance.new("TextLabel"); val.BackgroundTransparency=1; val.Position=UDim2.new(0.5,0,0,0); val.Size=UDim2.new(0.5,-12,1,0); val.Font=Enum.Font.GothamBold; val.TextSize=14; val.TextColor3=PURPLE; val.TextXAlignment=Enum.TextXAlignment.Right; val.Text=options[idx].."  ›"; val.Parent=row
        register(key,options[idx],function(v)
            local i=table.find(options,v); if not i then return end
            idx=i; Flags[key]=options[i]; val.Text=options[i].."  ›"; val.TextTransparency=1; tween(val,0.25,{TextTransparency=0})
            if callback then task.spawn(callback,options[i]) end
        end)
        row.MouseButton1Click:Connect(function() Setters[key](options[idx%#options+1]) end)
        row.MouseButton2Click:Connect(function() Setters[key](options[(idx-2)%#options+1]) end)
        row.MouseEnter:Connect(function() tween(row,0.2,{BackgroundColor3=Color3.fromRGB(44,39,64)}) end)
        row.MouseLeave:Connect(function() tween(row,0.2,{BackgroundColor3=BG3}) end)
    end
    return tab
end

local function fitScale() local cam=workspace.CurrentCamera; local vp=cam and cam.ViewportSize or Vector2.new(1280,720); return math.min(1,(vp.X-20)/880,(vp.Y-20)/440) end
local isOpen,busy=false,false

local function openMenu()
    if busy or isOpen then return end
    busy=true; isOpen=true
    main.Visible=true
    local fit=fitScale(); scale.Scale=fit*0.5; main.GroupTransparency=1; main.Rotation=-8; main.Position=UDim2.new(0.5,0,0.46,0)
    tween(scale,0.6,{Scale=fit},Enum.EasingStyle.Back)
    tween(main,0.55,{GroupTransparency=0,Rotation=0,Position=UDim2.new(0.5,0,0.5,0)},Enum.EasingStyle.Back)
    task.delay(0.6,function() busy=false end)
end

local function closeMenu()
    if busy or not isOpen then return end
    busy=true; isOpen=false
    tween(scale,0.4,{Scale=fitScale()*0.5},Enum.EasingStyle.Back,Enum.EasingDirection.In)
    tween(main,0.4,{GroupTransparency=1,Rotation=8,Position=UDim2.new(0.5,0,0.54,0)},Enum.EasingStyle.Back,Enum.EasingDirection.In)
    task.delay(0.4,function() main.Visible=false; main.Rotation=0; main.Position=UDim2.new(0.5,0,0.5,0); busy=false end)
end

local function toggleMenu() if isOpen then closeMenu() else openMenu() end end

local closeBtn=Instance.new("TextButton"); closeBtn.AnchorPoint=Vector2.new(1,0.5); closeBtn.Position=UDim2.new(1,-8,0.5,0); closeBtn.Size=UDim2.new(0,30,0,30); closeBtn.BackgroundColor3=Color3.fromRGB(60,20,40); closeBtn.Text="×"; closeBtn.Font=Enum.Font.GothamBold; closeBtn.TextSize=20; closeBtn.TextColor3=WHITE; closeBtn.AutoButtonColor=false; closeBtn.Parent=top; corner(closeBtn,8)
closeBtn.MouseButton1Click:Connect(function() closeMenu() end)
closeBtn.MouseEnter:Connect(function() tween(closeBtn,0.15,{BackgroundColor3=Color3.fromRGB(200,40,60)}) end)
closeBtn.MouseLeave:Connect(function() tween(closeBtn,0.15,{BackgroundColor3=Color3.fromRGB(60,20,40)}) end)

local icon=Instance.new("TextButton"); icon.Size=UDim2.new(0,56,0,56); icon.Position=UDim2.new(0,30,0.5,-28); icon.BackgroundColor3=BG; icon.AutoButtonColor=false; icon.Text=""; icon.ZIndex=5; icon.Parent=gui; corner(icon,28)
local iconStroke=stroke(icon,PURPLE,2.5,0)
local grad=Instance.new("UIGradient"); grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,PURPLE),ColorSequenceKeypoint.new(0.5,WHITE),ColorSequenceKeypoint.new(1,PURPLE)}); grad.Parent=iconStroke
local iconText=Instance.new("TextLabel"); iconText.BackgroundTransparency=1; iconText.Size=UDim2.new(1,0,1,0); iconText.Font=Enum.Font.GothamBlack; iconText.TextSize=22; iconText.RichText=true; iconText.Text='<b>L<font color="rgb(150,80,255)">X</font></b>'; iconText.TextColor3=WHITE; iconText.ZIndex=6; iconText.Parent=icon
local iconScale=Instance.new("UIScale"); iconScale.Parent=icon
task.spawn(function() local t=0; while gui.Parent do t+=task.wait(); grad.Rotation=(t*90)%360 end end)
task.spawn(function() while gui.Parent do tween(iconScale,1.2,{Scale=1.08},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut); task.wait(1.2); tween(iconScale,1.2,{Scale=1},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut); task.wait(1.2) end end)
icon.MouseEnter:Connect(function() tween(iconText,0.2,{TextSize=26}) end)
icon.MouseLeave:Connect(function() tween(iconText,0.2,{TextSize=22}) end)
makeDraggable(icon,icon,toggleMenu)
makeDraggable(top,main)
track(UIS.InputBegan:Connect(function(input,processed) if not processed and input.KeyCode==Enum.KeyCode.RightShift then toggleMenu() end end))

-- ROLE
local function scanName(name)
    local n=string.lower(name)
    if n=="knife" or n:find("knife") or n:find("murderknife") then return "Murderer" end
    if n=="gun" or n=="revolver" or n=="sheriff gun" or n:find("revolver") or (n:find("gun") and not n:find("shotgun") and not n:find("stun")) then return "Sheriff" end
    return nil
end
local function scanContainer(container,deep)
    if not container then return nil end
    local list=deep and container:GetDescendants() or container:GetChildren()
    for _,obj in ipairs(list) do
        if obj:IsA("Tool") or obj:IsA("Model") or obj:IsA("Part") or obj:IsA("MeshPart") then
            local r=scanName(obj.Name); if r then return r end
        end
    end
    return nil
end
local function getRole(plr)
    local char=plr.Character; if not char then return "Innocent" end
    if plr.Team then
        local tl=string.lower(plr.Team.Name)
        if tl=="murderer" then return "Murderer" end
        if tl=="sheriff" then return "Sheriff" end
        if tl=="innocent" then return "Innocent" end
    end
    for _,src in ipairs({plr,char}) do
        for _,attr in ipairs({"Role","MM2Role","MurderRole","PlayerRole","Team","role","mm2role"}) do
            local v=src:GetAttribute(attr)
            if v~=nil then
                local rl=string.lower(tostring(v))
                if rl=="murderer" or rl=="murder" then return "Murderer" end
                if rl=="sheriff" then return "Sheriff" end
                if rl=="innocent" then return "Innocent" end
            end
        end
    end
    for _,obj in ipairs(char:GetChildren()) do if obj:IsA("Tool") then local r=scanName(obj.Name); if r then return r end end end
    local r=scanContainer(char,true); if r then return r end
    local bp=plr:FindFirstChildOfClass("Backpack") or plr:FindFirstChild("Backpack")
    if bp then
        for _,obj in ipairs(bp:GetChildren()) do if obj:IsA("Tool") then local rr=scanName(obj.Name); if rr then return rr end end end
        r=scanContainer(bp,true); if r then return r end
    end
    local pg=plr:FindFirstChildOfClass("PlayerGui") or plr:FindFirstChild("PlayerGui")
    if pg then
        for _,obj in ipairs(pg:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("StringValue") then
                local v=obj:IsA("TextLabel") and obj.Text or obj.Value
                if typeof(v)=="string" then
                    local vl=string.lower(v)
                    if vl=="murderer" then return "Murderer" end
                    if vl=="sheriff" then return "Sheriff" end
                end
            end
        end
    end
    return "Innocent"
end

-- ESP
local ESPFolder=Instance.new("Folder"); ESPFolder.Name="luxxsESP"; ESPFolder.Parent=gui
local espData={}
local function setLine(f,p1,p2,thick)
    local dx,dy=p2.X-p1.X,p2.Y-p1.Y
    f.Position=UDim2.new(0,(p1.X+p2.X)*0.5,0,(p1.Y+p2.Y)*0.5)
    f.Size=UDim2.new(0,math.sqrt(dx*dx+dy*dy),0,thick)
    f.Rotation=math.deg(math.atan2(dy,dx))
end
local BONES={{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"Torso","Left Leg"},{"Torso","Right Leg"}}

local function createESP(plr)
    if espData[plr] or plr==LP then return end
    local d={}
    d.box=Instance.new("Frame"); d.box.BackgroundTransparency=1; d.box.ZIndex=2; d.box.Parent=ESPFolder; d.boxStroke=stroke(d.box,PURPLE,1.5,0); corner(d.box,2)
    local function mkLabel(size,font)
        local l=Instance.new("TextLabel"); l.BackgroundTransparency=1; l.Font=font or Enum.Font.GothamBold; l.TextSize=size; l.TextColor3=WHITE; l.TextStrokeTransparency=0.5; l.TextStrokeColor3=Color3.new(0,0,0); l.Size=UDim2.new(0,260,0,size+2); l.TextXAlignment=Enum.TextXAlignment.Center; l.ZIndex=4; l.Parent=ESPFolder; return l
    end
    d.role=mkLabel(15,Enum.Font.GothamBlack); d.name=mkLabel(13); d.dist=mkLabel(12,Enum.Font.Gotham)
    d.tracer=Instance.new("Frame"); d.tracer.AnchorPoint=Vector2.new(0.5,0.5); d.tracer.BorderSizePixel=0; d.tracer.ZIndex=2; d.tracer.Parent=ESPFolder
    d.hpBg=Instance.new("Frame"); d.hpBg.BackgroundColor3=Color3.fromRGB(20,20,20); d.hpBg.BorderSizePixel=0; d.hpBg.ZIndex=3; d.hpBg.Parent=ESPFolder; corner(d.hpBg,2)
    d.hpFill=Instance.new("Frame"); d.hpFill.AnchorPoint=Vector2.new(0,1); d.hpFill.BackgroundColor3=Color3.fromRGB(70,230,110); d.hpFill.BorderSizePixel=0; d.hpFill.Size=UDim2.new(1,0,1,0); d.hpFill.Position=UDim2.new(0,0,1,0); d.hpFill.ZIndex=4; d.hpFill.Parent=d.hpBg; corner(d.hpFill,2)
    d.skeleton={}
    for i=1,#BONES do local f=Instance.new("Frame"); f.AnchorPoint=Vector2.new(0.5,0.5); f.BorderSizePixel=0; f.BackgroundColor3=WHITE; f.Visible=false; f.ZIndex=3; f.Parent=ESPFolder; d.skeleton[i]=f end
    d.highlight=Instance.new("Highlight"); d.highlight.FillTransparency=1; d.highlight.OutlineTransparency=1; d.highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; d.highlight.Parent=ESPFolder
    espData[plr]=d
end

local function removeESP(plr)
    local d=espData[plr]; if not d then return end
    for k,v in pairs(d) do
        if typeof(v)=="Instance" then pcall(function() v:Destroy() end)
        elseif type(v)=="table" then for _,o in pairs(v) do pcall(function() o:Destroy() end) end end
    end
    espData[plr]=nil
end

for _,plr in ipairs(Players:GetPlayers()) do if plr~=LP then createESP(plr) end end
Players.PlayerAdded:Connect(function(plr) task.wait(0.2); createESP(plr) end)
Players.PlayerRemoving:Connect(function(plr) removeESP(plr) end)

local function espAnyOn() return Flags["Visuals/ESP Box"] or Flags["Visuals/Роль"] or Flags["Visuals/Имя"] or Flags["Visuals/Здоровье"] or Flags["Visuals/Дистанция"] or Flags["Visuals/Трейсеры"] or Flags["Visuals/Скелет"] or Flags["Visuals/Chams"] or Flags["Visuals/Glow"] end

track(RunService.RenderStepped:Connect(function()
    local cam=workspace.CurrentCamera; if not cam then return end
    local vp=cam.ViewportSize; local t=os.clock()
    for plr,d in pairs(espData) do
        local char=plr.Character; local hum=char and char:FindFirstChildOfClass("Humanoid"); local hrp=char and char:FindFirstChild("HumanoidRootPart")
        local visible=false; local minX,minY,maxX,maxY=math.huge,math.huge,-math.huge,-math.huge
        if char and hum and hrp and hum.Health>0 and espAnyOn() then
            for _,p in ipairs(char:GetChildren()) do
                if p:IsA("BasePart") then
                    local sp,onS=cam:WorldToViewportPoint(p.Position)
                    if onS and sp.Z>0 then visible=true; minX=math.min(minX,sp.X-10); maxX=math.max(maxX,sp.X+10); minY=math.min(minY,sp.Y-10); maxY=math.max(maxY,sp.Y+10) end
                end
            end
        end
        if visible then
            local role=getRole(plr); local rcol=ROLE_COLORS[role] or WHITE
            local ecol=Flags["Visuals/Цвет по роли"] and rcol or getColor(Flags["Visuals/Цвет ESP"],t,0)
            local w,h=maxX-minX,maxY-minY; local cx=(minX+maxX)*0.5
            d.box.Visible=Flags["Visuals/ESP Box"]; d.box.Position=UDim2.new(0,minX,0,minY); d.box.Size=UDim2.new(0,w,0,h); d.boxStroke.Color=ecol
            d.role.Visible=Flags["Visuals/Роль"]; d.role.Text=string.upper(role); d.role.TextColor3=rcol; d.role.Position=UDim2.new(0,cx-130,0,minY-52)
            d.name.Visible=Flags["Visuals/Имя"]; d.name.Text=plr.Name; d.name.TextColor3=ecol; d.name.Position=UDim2.new(0,cx-130,0,minY-34)
            local dist=(hrp.Position-cam.CFrame.Position).Magnitude
            d.dist.Visible=Flags["Visuals/Дистанция"]; d.dist.Text="["..math.floor(dist).."m]"; d.dist.Position=UDim2.new(0,cx-130,0,minY+h+2)
            d.hpBg.Visible=Flags["Visuals/Здоровье"]; d.hpBg.Position=UDim2.new(0,minX-7,0,minY); d.hpBg.Size=UDim2.new(0,3,0,h); d.hpFill.Size=UDim2.new(1,0,math.clamp(hum.Health/hum.MaxHealth,0,1),0)
            d.tracer.Visible=Flags["Visuals/Трейсеры"]
            if d.tracer.Visible then d.tracer.BackgroundColor3=ecol; setLine(d.tracer,Vector2.new(vp.X*0.5,vp.Y),Vector2.new(cx,minY+h),1) end
            local skelOn=Flags["Visuals/Скелет"]
            for i,bone in ipairs(BONES) do
                local ln=d.skeleton[i]
                if skelOn then
                    local p1=char:FindFirstChild(bone[1]); local p2=char:FindFirstChild(bone[2])
                    if p1 and p2 then
                        local s1,o1=cam:WorldToViewportPoint(p1.Position); local s2,o2=cam:WorldToViewportPoint(p2.Position)
                        if o1 and o2 and s1.Z>0 and s2.Z>0 then ln.Visible=true; ln.BackgroundColor3=ecol; setLine(ln,Vector2.new(s1.X,s1.Y),Vector2.new(s2.X,s2.Y),1.5)
                        else ln.Visible=false end
                    else ln.Visible=false end
                else ln.Visible=false end
            end
            local chams,glow=Flags["Visuals/Chams"],Flags["Visuals/Glow"]
            if chams or glow then
                d.highlight.Adornee=char; d.highlight.FillColor=ecol; d.highlight.OutlineColor=ecol
                d.highlight.FillTransparency=chams and 0.5 or 1; d.highlight.OutlineTransparency=glow and 0.3 or 1
            else d.highlight.FillTransparency=1; d.highlight.OutlineTransparency=1; d.highlight.Adornee=nil end
        else
            d.box.Visible=false; d.role.Visible=false; d.name.Visible=false; d.dist.Visible=false; d.hpBg.Visible=false; d.tracer.Visible=false
            for _,ln in ipairs(d.skeleton) do ln.Visible=false end
            d.highlight.Adornee=nil
        end
    end
end))

-- AIMBOT
local AIM_PARTS_DATA={{name="Голова",x=32,y=14,w=26,h=26,r=13,dx=45,dy=27},{name="Грудь",x=25,y=44,w=40,h=28,r=8,dx=45,dy=57},{name="Живот",x=25,y=72,w=40,h=28,r=8,dx=45,dy=86},{name="Левая рука",x=10,y=46,w=12,h=52,r=6,dx=16,dy=72},{name="Правая рука",x=68,y=46,w=12,h=52,r=6,dx=74,dy=72},{name="Левая нога",x=27,y=102,w=16,h=62,r=6,dx=35,dy=133},{name="Правая нога",x=47,y=102,w=16,h=62,r=6,dx=55,dy=133}}
local AIM_NAMES={} for i,a in ipairs(AIM_PARTS_DATA) do AIM_NAMES[i]=a.name end

local function resolveBodyPart(char,name)
    if not char then return nil end
    if name=="Голова" then return char:FindFirstChild("Head") end
    if name=="Грудь" then return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") end
    if name=="Живот" then return char:FindFirstChild("LowerTorso") or char:FindFirstChild("Torso") end
    if name=="Левая рука" then return char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm") end
    if name=="Правая рука" then return char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm") end
    if name=="Левая нога" then return char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg") end
    if name=="Правая нога" then return char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg") end
    return char:FindFirstChild("Head")
end

local fovCircle=Instance.new("Frame"); fovCircle.AnchorPoint=Vector2.new(0.5,0.5); fovCircle.Position=UDim2.new(0.5,0,0.5,0); fovCircle.BackgroundTransparency=1; fovCircle.Visible=false; fovCircle.ZIndex=2; fovCircle.Parent=gui; corner(fovCircle,9999); stroke(fovCircle,PURPLE,1.5,0.4)

local function getFovRadiusPx() local cam=workspace.CurrentCamera; if not cam then return 200 end; return ((Flags["Aimbot/FOV"] or 120)/180)*math.min(cam.ViewportSize.X,cam.ViewportSize.Y) end

local function findAimbotTarget()
    local cam=workspace.CurrentCamera; if not cam then return nil end
    local center=Vector2.new(cam.ViewportSize.X*0.5,cam.ViewportSize.Y*0.5); local radius=getFovRadiusPx()
    local partName=Flags["Aimbot/Часть тела"] or "Голова"; local best,bestDist=nil,math.huge
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr~=LP then
            local char=plr.Character; local hum=char and char:FindFirstChildOfClass("Humanoid")
            if char and hum and hum.Health>0 then
                local part=resolveBodyPart(char,partName)
                if part then
                    local sp=cam:WorldToViewportPoint(part.Position)
                    if sp.Z>0 then
                        local dist=(Vector2.new(sp.X,sp.Y)-center).Magnitude
                        if dist<=radius and dist<bestDist then best,bestDist={player=plr,part=part},dist end
                    end
                end
            end
        end
    end
    return best
end

track(RunService.RenderStepped:Connect(function(dt)
    local cam=workspace.CurrentCamera; if not cam then return end
    local showFov=Flags["Aimbot/Включить"] and Flags["Aimbot/Показывать FOV"]
    fovCircle.Visible=showFov and true or false
    if showFov then local r=getFovRadiusPx()*2; fovCircle.Size=UDim2.new(0,r,0,r) end
    if not Flags["Aimbot/Включить"] then return end
    local target=findAimbotTarget()
    if target then
        local smooth=math.clamp(Flags["Aimbot/Плавность"] or 30,1,100)/100
        local alpha=math.clamp(1-smooth,0.03,1)*math.min(1,dt*60)
        cam.CFrame=cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position,target.part.Position),alpha)
    end
end))

-- FARM
local Farm={Enabled=false,Mode="Fly",Speed=280,TeleportDelay=0.03,AntiAFK=false,ReturnOnFinish=false,ReturnPos=nil,LoopThread=nil,Collected=0,Status="idle"}
local antiAfkConn=nil
local function setAntiAFK(on)
    if antiAfkConn then antiAfkConn:Disconnect(); antiAfkConn=nil end
    if not on then return end
    antiAfkConn=LP.Idled:Connect(function() VU:CaptureController(); VU:ClickButton2(Vector2.new()) end)
end

local function getNearestCoin(pos)
    local best,bestDist=nil,math.huge
    for _,p in ipairs(workspace:GetPartBoundsInRadius(pos,800)) do
        local n=p.Name
        if n=="Coin" or n:find("Coin") or n:find("coin") then
            local d=(p.Position-pos).Magnitude
            if d<bestDist then best,bestDist=p,d end
        end
    end
    if not best then
        for _,obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name=="Coin" or obj.Name:find("Coin") or obj.Name:find("coin")) then
                local d=(obj.Position-pos).Magnitude
                if d<bestDist then best,bestDist=obj,d end
            end
        end
    end
    return best
end

local flyConn,flyBodyVel,flyBodyGyro=nil,nil,nil
local function disableFly()
    if flyConn then flyConn:Disconnect(); flyConn=nil end
    local char=LP.Character
    if char then
        local hrp=char:FindFirstChild("HumanoidRootPart")
        if hrp then
            if flyBodyVel then flyBodyVel:Destroy(); flyBodyVel=nil end
            if flyBodyGyro then flyBodyGyro:Destroy(); flyBodyGyro=nil end
        end
    end
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand=false end
end

local function enableFly()
    disableFly()
    local char=LP.Character
    local hrp=char and char:FindFirstChild("HumanoidRootPart")
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    flyBodyVel=Instance.new("BodyVelocity"); flyBodyVel.MaxForce=Vector3.new(9e9,9e9,9e9); flyBodyVel.Velocity=Vector3.zero; flyBodyVel.Parent=hrp
    flyBodyGyro=Instance.new("BodyGyro"); flyBodyGyro.MaxTorque=Vector3.new(9e9,9e9,9e9); flyBodyGyro.P=2000; flyBodyGyro.CFrame=hrp.CFrame; flyBodyGyro.Parent=hrp
    hum.PlatformStand=true
    local cam=workspace.CurrentCamera
    flyConn=RunService.RenderStepped:Connect(function()
        if not Farm.Enabled or not hrp or not hrp.Parent then return end
        local moveDir=Vector3.zero
        local look=cam.CFrame.LookVector; local right=cam.CFrame.RightVector
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir+=look end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir-=look end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir-=right end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir+=right end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir+=Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir-=Vector3.new(0,1,0) end
        if moveDir.Magnitude>0 then moveDir=moveDir.Unit end
        flyBodyVel.Velocity=moveDir*Farm.Speed
        flyBodyGyro.CFrame=cam.CFrame
    end)
end

local noclipConn=nil
local function setNoclip(on)
    if noclipConn then noclipConn:Disconnect(); noclipConn=nil end
    if not on then
        local char=LP.Character
        if char then for _,p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then pcall(function() p.CanCollide=true end) end end end
        return
    end
    noclipConn=RunService.Stepped:Connect(function()
        if not Farm.Enabled then return end
        local char=LP.Character; if not char then return end
        for _,p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then pcall(function() p.CanCollide=false end) end
        end
    end)
end

local function teleportTo(pos)
    local char=LP.Character; local hrp=char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    hrp.CFrame=CFrame.new(pos+Vector3.new(0,3,0)); return true
end

local function startFarm()
    if Farm.LoopThread then return end
    local char0=LP.Character; local hrp0=char0 and char0:FindFirstChild("HumanoidRootPart")
    if Farm.ReturnOnFinish and hrp0 then Farm.ReturnPos=hrp0.CFrame end
    Farm.LoopThread=task.spawn(function()
        while Farm.Enabled do
            local char=LP.Character
            local hrp=char and char:FindFirstChild("HumanoidRootPart")
            local hum=char and char:FindFirstChildOfClass("Humanoid")
            if not char or not hrp or not hum then task.wait(0.5)
            else
                local coin=getNearestCoin(hrp.Position)
                if coin then
                    Farm.Status="к монете: "..coin.Name
                    if Farm.Mode=="Teleport" then teleportTo(coin.Position); task.wait(Farm.TeleportDelay)
                    elseif Farm.Mode=="Fly" then
                        local target=coin.Position; local dir=target-hrp.Position
                        if dir.Magnitude>0.5 then hrp.CFrame=CFrame.new(hrp.Position+dir.Unit*math.min(dir.Magnitude,Farm.Speed*0.2))
                        else hrp.CFrame=CFrame.new(target+Vector3.new(0,3,0)) end
                        task.wait()
                    elseif Farm.Mode=="Noclip" then
                        local d=coin.Position-hrp.Position
                        hrp.CFrame=CFrame.new(hrp.Position+d.Unit*math.min(d.Magnitude,Farm.Speed*0.2))
                        task.wait()
                    end
                    Farm.Collected+=1
                else Farm.Status="монеты не найдены"; task.wait(0.3) end
            end
        end
        if Farm.ReturnOnFinish and Farm.ReturnPos then teleportTo(Farm.ReturnPos.Position) end
        Farm.Status="idle"
    end)
end

local function stopFarm()
    Farm.Enabled=false
    if Farm.LoopThread then pcall(function() task.cancel(Farm.LoopThread) end); Farm.LoopThread=nil end
    disableFly(); setNoclip(false)
end

-- FPS
local FPS={Enabled=false,Target=10000,Current=0,ShowCounter=true,ShowGraph=true}
local originalFpsCap=nil
local function applyFpsCap(cap) if type(setfpscap)=="function" then pcall(setfpscap,cap) end FPS.Current=cap end
local function enableFps()
    if type(getfpscap)=="function" then local ok,cur=pcall(getfpscap); if ok then originalFpsCap=cur end end
    applyFpsCap(FPS.Target); notify("FPS разблокирован до "..FPS.Target)
end
local function disableFps()
    if originalFpsCap then applyFpsCap(originalFpsCap) else applyFpsCap(60) end
    notify("FPS восстановлен")
end

-- КОМПАКТНЫЙ FPS-СЧЁТЧИК
local fpsGui=Instance.new("ScreenGui"); fpsGui.Name="luxxsFPS"; fpsGui.ResetOnSpawn=false; fpsGui.IgnoreGuiInset=true; fpsGui.DisplayOrder=100; fpsGui.Parent=parent
local fpsFrame=Instance.new("Frame"); fpsFrame.AnchorPoint=Vector2.new(1,0); fpsFrame.Position=UDim2.new(1,-12,0,12); fpsFrame.Size=UDim2.new(0,110,0,44); fpsFrame.BackgroundColor3=Color3.fromRGB(14,12,22); fpsFrame.BackgroundTransparency=0.2; fpsFrame.BorderSizePixel=0; fpsFrame.ZIndex=5; fpsFrame.Parent=fpsGui
corner(fpsFrame,8); stroke(fpsFrame,PURPLE,1.2,0.3)
local fpsNum=Instance.new("TextLabel"); fpsNum.BackgroundTransparency=1; fpsNum.Position=UDim2.new(0,8,0,2); fpsNum.Size=UDim2.new(1,-16,0,22); fpsNum.Font=Enum.Font.GothamBlack; fpsNum.TextSize=18; fpsNum.TextColor3=Color3.fromRGB(70,230,110); fpsNum.TextXAlignment=Enum.TextXAlignment.Left; fpsNum.Text="0 FPS"; fpsNum.ZIndex=6; fpsNum.Parent=fpsFrame
local fpsAvgL=Instance.new("TextLabel"); fpsAvgL.BackgroundTransparency=1; fpsAvgL.Position=UDim2.new(0,8,0,24); fpsAvgL.Size=UDim2.new(0.5,-8,0,12); fpsAvgL.Font=Enum.Font.GothamMedium; fpsAvgL.TextSize=9; fpsAvgL.TextColor3=GRAY; fpsAvgL.TextXAlignment=Enum.TextXAlignment.Left; fpsAvgL.Text="AVG: 0"; fpsAvgL.ZIndex=6; fpsAvgL.Parent=fpsFrame
local fpsMaxL=Instance.new("TextLabel"); fpsMaxL.BackgroundTransparency=1; fpsMaxL.Position=UDim2.new(0.5,4,0,24); fpsMaxL.Size=UDim2.new(0.5,-12,0,12); fpsMaxL.Font=Enum.Font.GothamMedium; fpsMaxL.TextSize=9; fpsMaxL.TextColor3=GRAY; fpsMaxL.TextXAlignment=Enum.TextXAlignment.Left; fpsMaxL.Text="MAX: 0"; fpsMaxL.ZIndex=6; fpsMaxL.Parent=fpsFrame
local fpsGraph=Instance.new("Frame"); fpsGraph.AnchorPoint=Vector2.new(0,1); fpsGraph.Position=UDim2.new(0,8,1,-4); fpsGraph.Size=UDim2.new(1,-16,0,10); fpsGraph.BackgroundColor3=Color3.fromRGB(30,24,44); fpsGraph.BackgroundTransparency=0.4; fpsGraph.BorderSizePixel=0; fpsGraph.ClipsDescendants=true; fpsGraph.ZIndex=6; fpsGraph.Parent=fpsFrame
corner(fpsGraph,3)
local bars={}
for i=1,20 do
    local b=Instance.new("Frame"); b.AnchorPoint=Vector2.new(0,1); b.Position=UDim2.new((i-1)/20,0,1,0); b.Size=UDim2.new(1/20-0.005,0,0,0); b.BackgroundColor3=PURPLE; b.BorderSizePixel=0; b.ZIndex=7; b.Parent=fpsGraph
    bars[i]=b
end

local FpsCounter={Avg=0,Max=0,Frames=0,Last=tick(),History={}}
task.spawn(function()
    while fpsGui.Parent do
        RunService.RenderStepped:Wait()
        FpsCounter.Frames+=1
        local elapsed=tick()-FpsCounter.Last
        if elapsed>=0.25 then
            local fps=math.floor(FpsCounter.Frames/elapsed+0.5)
            FpsCounter.Frames=0; FpsCounter.Last=tick()
            FpsCounter.Avg=FpsCounter.Avg==0 and fps or (FpsCounter.Avg*0.9+fps*0.1)
            if fps>FpsCounter.Max then FpsCounter.Max=fps end
            table.insert(FpsCounter.History,fps)
            if #FpsCounter.History>20 then table.remove(FpsCounter.History,1) end
            fpsNum.Text=tostring(fps).." FPS"
            if fps>=120 then fpsNum.TextColor3=Color3.fromRGB(70,230,110)
            elseif fps>=60 then fpsNum.TextColor3=Color3.fromRGB(255,225,60)
            elseif fps>=30 then fpsNum.TextColor3=Color3.fromRGB(255,150,40)
            else fpsNum.TextColor3=Color3.fromRGB(255,60,60) end
            fpsAvgL.Text="AVG: "..math.floor(FpsCounter.Avg)
            fpsMaxL.Text="MAX: "..FpsCounter.Max
            local maxH=1
            for _,v in ipairs(FpsCounter.History) do if v>maxH then maxH=v end end
            for i=1,20 do
                local v=FpsCounter.History[#FpsCounter.History-(20-i)] or 0
                bars[i].Size=UDim2.new(1/20-0.005,0,0,math.clamp(v/maxH,0,1)*10)
                local rel=v/240
                if rel>=0.5 then bars[i].BackgroundColor3=Color3.fromRGB(70,230,110)
                elseif rel>=0.25 then bars[i].BackgroundColor3=Color3.fromRGB(255,225,60)
                else bars[i].BackgroundColor3=Color3.fromRGB(255,100,60) end
            end
        end
    end
end)
makeDraggable(fpsFrame,fpsFrame)

-- РАЗДЕЛЫ
local visTab=createTab("Visuals")
visTab:Label("ESP")
visTab:Toggle("ESP Box",false)
visTab:Toggle("Роль",false)
visTab:Choice("Роль (превью)",ROLE_NAMES,"Murderer")
visTab:Toggle("Цвет по роли",false)
visTab:Toggle("Имя",false)
visTab:Toggle("Здоровье",false)
visTab:Toggle("Дистанция",false)
visTab:Toggle("Трейсеры",false)
visTab:Toggle("Скелет",false)
visTab:Toggle("Chams",false)
visTab:Toggle("Glow",false)
visTab:Choice("Цвет ESP",COLOR_NAMES,"Фиолетовый")
visTab:Label("Ангельские крылья")
visTab:Toggle("Крылья",false,function(s) if s then buildWings() else destroyCos("wings") end end)
visTab:Choice("Цвет крыльев",WING_COLORS,"Белый")
visTab:Slider("Скорость крыльев",1,10,3)
visTab:Label("Китайская шляпа")
visTab:Toggle("Китайская шляпа",false,function(s) if s then buildHat() else destroyCos("hat") end end)
visTab:Choice("Цвет шляпы",COLOR_NAMES,"Радужный")
visTab:Label("Трейл")
visTab:Toggle("Трейл",false,function(s) if s then buildTrail() else destroyCos("trail") end end)
visTab:Choice("Цвет трейла",COLOR_NAMES,"Радужный")
visTab:Slider("Длина трейла",1,30,10)
visTab:Slider("Ширина трейла",1,10,4)

local aimTab=createTab("Aimbot")
aimTab:Label("Цель: кликните точку на манекене")
aimTab:Toggle("Включить",false)
aimTab:Choice("Часть тела",AIM_NAMES,"Голова")
aimTab:Slider("FOV",10,360,120)
aimTab:Slider("Плавность",1,100,30)
aimTab:Toggle("Показывать FOV",false)

local farmTab=createTab("Farm")
farmTab:Label("Автофарм монет")
farmTab:Toggle("Включить фарм",false,function(state)
    Farm.Enabled=state
    if state then
        startFarm()
        if Farm.Mode=="Fly" then enableFly() end
        if Farm.Mode=="Noclip" then setNoclip(true) end
        notify("Фарм включён ("..Farm.Mode..")")
    else stopFarm(); notify("Фарм выключен") end
end)
farmTab:Choice("Режим",{"Fly","Noclip","Teleport"},"Fly",function(v)
    Farm.Mode=v
    if Farm.Enabled then disableFly(); setNoclip(false); if v=="Fly" then enableFly() end; if v=="Noclip" then setNoclip(true) end end
end)
farmTab:Slider("Скорость",50,800,280,function(v) Farm.Speed=v end)
farmTab:Slider("Задержка ТП (мс x10)",1,20,3,function(v) Farm.TeleportDelay=v/100 end)
farmTab:Toggle("Анти-АФК",false,function(state) Farm.AntiAFK=state; setAntiAFK(state) end)
farmTab:Toggle("Возврат на старт",false,function(state) Farm.ReturnOnFinish=state end)
farmTab:Button("Сбросить счётчик",function() Farm.Collected=0; notify("Счётчик сброшен") end)
farmTab:Button("Показать статус",function() notify("Собрано: "..Farm.Collected.." | "..Farm.Status) end)

local fpsTab=createTab("FPS")
fpsTab:Label("Разблокировка FPS")
fpsTab:Toggle("Включить анлок",false,function(state)
    FPS.Enabled=state
    if state then enableFps() else disableFps() end
end)
fpsTab:Slider("Целевой FPS",60,10000,10000,function(v) FPS.Target=v; if FPS.Enabled then applyFpsCap(v) end end)
fpsTab:Button("60 FPS",function() Setters["FPS/Целевой FPS"](60) end)
fpsTab:Button("120 FPS",function() Setters["FPS/Целевой FPS"](120) end)
fpsTab:Button("240 FPS",function() Setters["FPS/Целевой FPS"](240) end)
fpsTab:Button("500 FPS",function() Setters["FPS/Целевой FPS"](500) end)
fpsTab:Button("1000 FPS",function() Setters["FPS/Целевой FPS"](1000) end)
fpsTab:Button("10000 FPS (макс)",function() Setters["FPS/Целевой FPS"](10000) end)
fpsTab:Label("Счётчик FPS на экране")
fpsTab:Toggle("Показывать счётчик",true,function(state)
    fpsFrame.Visible=state
end)
fpsTab:Toggle("Показывать график",true,function(state)
    fpsGraph.Visible=state
end)
fpsTab:Button("Сбросить MAX",function()
    FpsCounter.Max=0; FpsCounter.Avg=0
    notify("Статистика FPS сброшена")
end)
fpsTab:Label("Оптимизация")
fpsTab:Toggle("Убрать тени",false,function(state) Lighting.GlobalShadows=not state end)
fpsTab:Toggle("Убрать туман",false,function(state) Lighting.FogEnd=state and 1e6 or 100000 end)
fpsTab:Toggle("Убрать эффекты",false,function(state)
    for _,e in ipairs(Lighting:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then e.Enabled=not state end
    end
end)

local shTab=createTab("Shaders")
shTab:Label("Шейдеры")
shTab:Choice("Пресет",PRESET_NAMES,"Выкл",function() refreshShader(0.9) end)
shTab:Slider("Яркость",-50,50,0,function() refreshShader(0.15) end)
shTab:Slider("Контраст",-50,50,0,function() refreshShader(0.15) end)
shTab:Slider("Насыщенность",-100,100,0,function() refreshShader(0.15) end)
shTab:Slider("Bloom",0,100,0,function() refreshShader(0.15) end)
shTab:Button("Сбросить шейдеры",function()
    Setters["Shaders/Пресет"]("Выкл"); Setters["Shaders/Яркость"](0); Setters["Shaders/Контраст"](0); Setters["Shaders/Насыщенность"](0); Setters["Shaders/Bloom"](0)
end)

local setTab=createTab("Settings")
local FOLDER="luxxs"
local hasFS=type(writefile)=="function" and type(readfile)=="function" and type(isfile)=="function"
local SLOTS={"1","2","3","4","5"}
local function cfgPath(s) return FOLDER.."/config_"..s..".json" end
local function isSettingsKey(k) return k:sub(1,9)=="Settings/" end
local function ensureFolder() if type(makefolder)=="function" and type(isfolder)=="function" and not isfolder(FOLDER) then pcall(makefolder,FOLDER) end end
local function saveConfig(slot)
    if not hasFS then notify("Файловая система недоступна") return end
    ensureFolder(); local data={}
    for k,v in pairs(Flags) do if not isSettingsKey(k) then data[k]=v end end
    local ok=pcall(function() writefile(cfgPath(slot),HttpService:JSONEncode(data)) end)
    notify(ok and ("Конфиг сохранён: слот "..slot) or "Ошибка сохранения")
end
local function loadConfig(slot,silent)
    if not hasFS then if not silent then notify("Файловая система недоступна") end return end
    local path=cfgPath(slot)
    if not isfile(path) then if not silent then notify("Слот "..slot.." пуст") end return end
    local ok,data=pcall(function() return HttpService:JSONDecode(readfile(path)) end)
    if not ok or type(data)~="table" then notify("Ошибка чтения конфига") return end
    for k,v in pairs(data) do if Setters[k] and not isSettingsKey(k) then Setters[k](v) end end
    notify("Конфиг загружен: слот "..slot)
end
local function resetAll()
    for k,d in pairs(Defaults) do if not isSettingsKey(k) and Setters[k] then Setters[k](d) end end
    notify("Настройки сброшены")
end
local function unload()
    for _,c in ipairs(connections) do pcall(function() c:Disconnect() end) end
    destroyCos("wings"); destroyCos("hat"); destroyCos("trail")
    for plr in pairs(espData) do removeESP(plr) end
    stopFarm(); disableShader(true); disableFps(); gui:Destroy(); fpsGui:Destroy()
end

setTab:Label("Конфиги")
setTab:Choice("Слот конфига",SLOTS,"1")
setTab:Button("Сохранить конфиг",function() saveConfig(Flags["Settings/Слот конфига"]) end)
setTab:Button("Загрузить конфиг",function() loadConfig(Flags["Settings/Слот конфига"]) end)
setTab:Toggle("Автозагрузка",false,function(s)
    if not hasFS then return end
    ensureFolder(); pcall(function() writefile(FOLDER.."/autoload.txt",s and Flags["Settings/Слот конфига"] or "") end)
    notify(s and "Автозагрузка включена" or "Автозагрузка выключена")
end)
setTab:Button("Сбросить всё",resetAll)
setTab:Label("Меню")
setTab:Button("Закрыть меню",closeMenu)
setTab:Button("Удалить luxxs",unload)

-- ПРЕВЬЮ
local function solid(p,x,y,w,h,color,z,r)
    local f=Instance.new("Frame"); f.Position=UDim2.new(0,x,0,y); f.Size=UDim2.new(0,w,0,h); f.BackgroundColor3=color; f.BorderSizePixel=0; f.ZIndex=z or 1; f.Parent=p
    if r then corner(f,r) end
    return f
end
local function line(p,x1,y1,x2,y2,thick,color,z)
    local dx,dy=x2-x1,y2-y1
    local f=Instance.new("Frame"); f.AnchorPoint=Vector2.new(0.5,0.5); f.Position=UDim2.new(0,(x1+x2)/2,0,(y1+y2)/2); f.Size=UDim2.new(0,math.sqrt(dx*dx+dy*dy),0,thick); f.Rotation=math.deg(math.atan2(dy,dx)); f.BackgroundColor3=color; f.BorderSizePixel=0; f.ZIndex=z or 1; f.Parent=p
    return f
end

local function buildPreview(panel)
    panel.BackgroundColor3=WHITE; panel.ClipsDescendants=true; corner(panel,10); stroke(panel,PURPLE,1,0.6)
    local bgGrad=Instance.new("UIGradient"); bgGrad.Color=ColorSequence.new(Color3.fromRGB(28,20,46),Color3.fromRGB(10,9,15)); bgGrad.Rotation=90; bgGrad.Parent=panel
    local cap=Instance.new("TextLabel"); cap.BackgroundTransparency=1; cap.Position=UDim2.new(0,12,0,6); cap.Size=UDim2.new(0,90,0,16); cap.Font=Enum.Font.GothamBold; cap.TextSize=11; cap.TextColor3=GRAY; cap.TextXAlignment=Enum.TextXAlignment.Left; cap.Text="PREVIEW"; cap.ZIndex=20; cap.Parent=panel
    local aimCap=Instance.new("TextLabel"); aimCap.BackgroundTransparency=1; aimCap.AnchorPoint=Vector2.new(1,0); aimCap.Position=UDim2.new(1,-12,0,6); aimCap.Size=UDim2.new(0,140,0,16); aimCap.Font=Enum.Font.GothamBold; aimCap.TextSize=11; aimCap.RichText=true; aimCap.TextColor3=WHITE; aimCap.TextXAlignment=Enum.TextXAlignment.Right; aimCap.ZIndex=20; aimCap.Parent=panel
    local tracer=solid(panel,0,348,1,26,PURPLE,2); tracer.AnchorPoint=Vector2.new(0.5,0); tracer.Position=UDim2.new(0.5,0,0,348); tracer.Visible=false
    local fig=Instance.new("Frame"); fig.AnchorPoint=Vector2.new(0.5,0.5); fig.Position=UDim2.new(0.5,0,0,212); fig.Size=UDim2.new(0,90,0,170); fig.BackgroundTransparency=1; fig.Parent=panel
    local figScale=Instance.new("UIScale"); figScale.Scale=1.35; figScale.Parent=fig
    local body=Instance.new("Frame"); body.Size=UDim2.new(1,0,1,0); body.BackgroundTransparency=1; body.Parent=fig
    local trailF={}
    for k=1,12 do local f=solid(body,0,0,12,10,WHITE,1,5); f.AnchorPoint=Vector2.new(0.5,0.5); f.Visible=false; trailF[k]=f end
    local wingF={}
    local lens={56,52,46,40,34}
    for _,side in ipairs({-1,1}) do for i=1,5 do
        local f=solid(body,0,0,lens[i],9,WHITE,1,5); f.AnchorPoint=Vector2.new(0.5,0.5); f.Visible=false; wingF[#wingF+1]={f=f,side=side,i=i,len=lens[i]}
    end end
    local overlays={}
    for _,a in ipairs(AIM_PARTS_DATA) do local ov=solid(body,a.x,a.y,a.w,a.h,AIM_RED,4,a.r); ov.BackgroundTransparency=1; overlays[a.name]=ov end
    local bodyParts={}
    local function part(x,y,w,h,r) local f=solid(body,x,y,w,h,BODY_GRAY,3,r); local s=Instance.new("UIStroke"); s.Thickness=2; s.Color=PURPLE; s.Enabled=false; s.Parent=f; bodyParts[#bodyParts+1]={f=f,s=s} end
    part(32,14,26,26,13); part(25,44,40,56,8); part(10,46,12,52,6); part(68,46,12,52,6); part(27,102,16,62,6); part(47,102,16,62,6)
    local skel=Instance.new("Frame"); skel.Size=UDim2.new(1,0,1,0); skel.BackgroundTransparency=1; skel.ZIndex=6; skel.Visible=false; skel.Parent=body
    local J={head={45,27},neck={45,44},shL={26,50},shR={64,50},elL={16,74},elR={74,74},haL={16,98},haR={74,98},pel={45,100},hipL={35,102},hipR={55,102},knL={35,133},knR={55,133},ftL={35,164},ftR={55,164}}
    local BPREV={{"head","neck"},{"neck","pel"},{"neck","shL"},{"neck","shR"},{"shL","elL"},{"elL","haL"},{"shR","elR"},{"elR","haR"},{"pel","hipL"},{"pel","hipR"},{"hipL","knL"},{"knL","ftL"},{"hipR","knR"},{"knR","ftR"}}
    local skelParts={}
    for _,b in ipairs(BPREV) do local a,c=J[b[1]],J[b[2]]; skelParts[#skelParts+1]=line(skel,a[1],a[2],c[1],c[2],2,WHITE,6) end
    for _,p in pairs(J) do skelParts[#skelParts+1]=solid(skel,p[1]-3,p[2]-3,6,6,WHITE,7,3) end
    local hatS={}
    for i=1,12 do local w=66*(1-(i-1)/12)+4; local hf=solid(body,45-w/2,18-i*3,w,3,WHITE,5); hf.Visible=false; hatS[i]=hf end
    local aimUI={}
    for _,a in ipairs(AIM_PARTS_DATA) do
        local dot=Instance.new("TextButton"); dot.AnchorPoint=Vector2.new(0.5,0.5); dot.Position=UDim2.new(0,a.dx,0,a.dy); dot.Size=UDim2.new(0,13,0,13); dot.BackgroundColor3=Color3.fromRGB(230,230,240); dot.BackgroundTransparency=0.35; dot.Text=""; dot.AutoButtonColor=false; dot.ZIndex=12; dot.Parent=body; corner(dot,8)
        local dotStroke=stroke(dot,WHITE,1,0.4)
        local ui={a=a,dot=dot,ds=dotStroke,hover=false}
        dot.MouseEnter:Connect(function() ui.hover=true end)
        dot.MouseLeave:Connect(function() ui.hover=false end)
        dot.MouseButton1Click:Connect(function() Setters["Aimbot/Часть тела"](a.name) end)
        aimUI[#aimUI+1]=ui
    end
    local aimDot=solid(body,45,27,12,12,AIM_RED,13,6); aimDot.AnchorPoint=Vector2.new(0.5,0.5); stroke(aimDot,WHITE,1,0.3)
    local aimPulseRing=Instance.new("Frame"); aimPulseRing.AnchorPoint=Vector2.new(0.5,0.5); aimPulseRing.Position=UDim2.new(0,45,0,27); aimPulseRing.BackgroundTransparency=1; aimPulseRing.Size=UDim2.new(0,22,0,22); aimPulseRing.ZIndex=14; aimPulseRing.Parent=body; corner(aimPulseRing,20)
    local aimPulseStroke=stroke(aimPulseRing,AIM_RED,2,0.3)
    local boxF=solid(fig,4,8,82,158,WHITE,7); boxF.BackgroundTransparency=1; boxF.Visible=false
    local boxStroke=stroke(boxF,PURPLE,1.5,0)
    local function espLabel(font,size,z) local l=Instance.new("TextLabel"); l.BackgroundTransparency=1; l.Size=UDim2.new(0,130,0,14); l.Font=font; l.TextSize=size; l.ZIndex=z or 8; l.Visible=false; l.Parent=fig; return l end
    local roleL=espLabel(Enum.Font.GothamBlack,14)
    local nameL=espLabel(Enum.Font.GothamBold,13); nameL.Text="Player"
    local distL=espLabel(Enum.Font.Gotham,12); distL.Position=UDim2.new(0,-20,0,168); distL.TextColor3=WHITE; distL.Text="[42m]"
    local hpBar=solid(fig,-1,8,3,158,Color3.fromRGB(20,20,20),8); hpBar.Visible=false
    local hpFill=solid(hpBar,0,0,3,100,Color3.fromRGB(70,230,110),9); hpFill.AnchorPoint=Vector2.new(0,1); hpFill.Position=UDim2.new(0,0,1,0); hpFill.Size=UDim2.new(1,0,0.72,0)
    local boxTop=8
    local aimPosX,aimPosY=45,27
    track(RunService.RenderStepped:Connect(function(dt)
        if not isOpen then return end
        local t=os.clock()
        body.Position=UDim2.new(0,0,0,math.sin(t*2)*2)
        local role=Flags["Visuals/Роль (превью)"] or "Murderer"
        local rcol=ROLE_COLORS[role] or WHITE
        local ecol=Flags["Visuals/Цвет по роли"] and rcol or getColor(Flags["Visuals/Цвет ESP"],t,0)
        local hatOn=Flags["Visuals/Китайская шляпа"]
        boxTop=boxTop+((hatOn and -22 or 8)-boxTop)*0.2
        boxF.Visible=Flags["Visuals/ESP Box"]; boxStroke.Color=ecol; boxF.Position=UDim2.new(0,4,0,boxTop); boxF.Size=UDim2.new(0,82,0,166-boxTop)
        roleL.Visible=Flags["Visuals/Роль"]; roleL.Text=string.upper(role); roleL.TextColor3=rcol; roleL.Position=UDim2.new(0,-20,0,boxTop-32)
        nameL.Visible=Flags["Visuals/Имя"]; nameL.TextColor3=ecol; nameL.Position=UDim2.new(0,-20,0,boxTop-16)
        distL.Visible=Flags["Visuals/Дистанция"]
        hpBar.Visible=Flags["Visuals/Здоровье"]; hpBar.Position=UDim2.new(0,-1,0,boxTop); hpBar.Size=UDim2.new(0,3,0,166-boxTop); hpFill.Size=UDim2.new(1,0,0.7+math.sin(t)*0.2,0)
        tracer.Visible=Flags["Visuals/Трейсеры"]; tracer.BackgroundColor3=ecol
        local skelOn=Flags["Visuals/Скелет"]; skel.Visible=skelOn
        if skelOn then for _,s in ipairs(skelParts) do s.BackgroundColor3=ecol end end
        local chams,glow=Flags["Visuals/Chams"],Flags["Visuals/Glow"]
        for _,p in ipairs(bodyParts) do p.f.BackgroundColor3=chams and ecol or BODY_GRAY; p.f.BackgroundTransparency=chams and 0.35 or 0; p.s.Enabled=glow; p.s.Color=ecol end
        for i,s in ipairs(hatS) do s.Visible=hatOn; if hatOn then s.BackgroundColor3=getColor(Flags["Visuals/Цвет шляпы"],t,i*0.07) end end
        local wingsOn=Flags["Visuals/Крылья"]
        local flap=math.sin(t*(Flags["Visuals/Скорость крыльев"] or 3))*0.2
        for _,w in ipairs(wingF) do
            w.f.Visible=wingsOn
            if wingsOn then
                local a=math.rad(12+w.i*13)+flap*(0.5+w.i*0.15); local dx,dy=w.side*math.cos(a),-math.sin(a); local sx=(w.side==-1) and 26 or 64
                w.f.Position=UDim2.new(0,sx+dx*w.len/2,0,52+dy*w.len/2); w.f.Rotation=math.deg(math.atan2(dy,dx)); w.f.BackgroundColor3=getColor(Flags["Visuals/Цвет крыльев"],t,w.i*0.05); w.f.BackgroundTransparency=0.08
            end
        end
        local trailOn=Flags["Visuals/Трейл"]
        local tlen=math.clamp(Flags["Visuals/Длина трейла"] or 10,1,30)
        local count=math.clamp(math.floor(tlen/30*12)+2,3,12)
        local twidth=Flags["Visuals/Ширина трейла"] or 4
        for k,f in ipairs(trailF) do
            local show=trailOn and k<=count; f.Visible=show
            if show then local fall=k/count; f.Position=UDim2.new(0,22-k*8,0,108+math.sin(t*4+k*0.6)*4*fall); f.Size=UDim2.new(0,12,0,math.max(2,twidth*2.2*(1-fall*0.8))); f.BackgroundTransparency=0.1+fall*0.85; f.BackgroundColor3=getColor(Flags["Visuals/Цвет трейла"],t,-k*0.04) end
        end
        local sel=Flags["Aimbot/Часть тела"]; local pulse=(math.sin(t*5)+1)/2
        for pn,ov in pairs(overlays) do ov.BackgroundTransparency=(pn==sel) and (0.55-pulse*0.2) or 1 end
        local selPart=nil
        for _,a in ipairs(AIM_PARTS_DATA) do if a.name==sel then selPart=a; break end end
        if selPart then
            local k=math.clamp(dt*12,0,1)
            aimPosX=aimPosX+(selPart.dx-aimPosX)*k; aimPosY=aimPosY+(selPart.dy-aimPosY)*k
            aimDot.Position=UDim2.new(0,aimPosX,0,aimPosY); aimPulseRing.Position=UDim2.new(0,aimPosX,0,aimPosY)
        end
        local rs=20+pulse*12
        aimPulseRing.Size=UDim2.new(0,rs,0,rs); aimPulseStroke.Transparency=0.2+pulse*0.6
        for _,u in ipairs(aimUI) do
            if u.a.name==sel then u.dot.BackgroundColor3=Color3.fromRGB(255,90,90); u.dot.BackgroundTransparency=0.15; u.dot.Size=UDim2.new(0,14,0,14); u.ds.Transparency=0.1; u.ds.Color=WHITE
            elseif u.hover then u.dot.BackgroundColor3=Color3.fromRGB(255,150,150); u.dot.BackgroundTransparency=0.2; u.dot.Size=UDim2.new(0,15,0,15); u.ds.Transparency=0.2; u.ds.Color=WHITE
            else u.dot.BackgroundColor3=Color3.fromRGB(230,230,240); u.dot.BackgroundTransparency=0.35; u.dot.Size=UDim2.new(0,13,0,13); u.ds.Transparency=0.4; u.ds.Color=WHITE end
        end
        aimCap.Text='<font color="rgb(255,60,60)">●</font> '..tostring(sel)
    end))
end

buildPreview(previewPanel)
selectTab(visTab)

if hasFS then
    pcall(function()
        local p=FOLDER.."/autoload.txt"
        if isfile(p) then
            local slot=readfile(p)
            if slot~="" and table.find(SLOTS,slot) then
                Setters["Settings/Слот конфига"](slot); loadConfig(slot,true); Setters["Settings/Автозагрузка"](true)
            end
        end
    end)
end

notify("ключ принят • RightShift или иконка LX")
