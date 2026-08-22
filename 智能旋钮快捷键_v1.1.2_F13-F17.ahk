#Requires AutoHotkey v2.0
#SingleInstance Force

; v1.1.2
; 外设触发键：F13-F17（无 Ctrl/Alt/Shift，不受 Num Lock 影响）
; 常规及 Edge PDF 模式按下：Ctrl+Alt+Down。

if A_Args.Length && A_Args[1] = "--validate"
    ExitApp

$F13::HandleKnobAction("Press")
$F14::HandleKnobAction("TurnLeft")
$F15::HandleKnobAction("TurnRight")
$F16::HandleKnobAction("PressTurnLeft")
$F17::HandleKnobAction("PressTurnRight")

HandleKnobAction(action)
{
    if IsDouyinActive()
    {
        HandleDouyin(action)
        return
    }

    if IsEdgePdfActive()
    {
        HandlePdf(action)
        return
    }

    if IsEdgeBilibiliActive()
    {
        HandleBilibili(action)
        return
    }

    HandleDefault(action)
}

IsDouyinActive()
{
    return WinActive("ahk_exe douyin.exe") != 0
}

IsEdgePdfActive()
{
    if !WinActive("ahk_exe msedge.exe")
        return false

    title := StrLower(WinGetTitle("A"))
    return InStr(title, ".pdf") != 0
}

IsEdgeBilibiliActive()
{
    if !WinActive("ahk_exe msedge.exe")
        return false

    title := WinGetTitle("A")
    titleLower := StrLower(title)
    return InStr(title, "哔哩哔哩") != 0 || InStr(titleLower, "bilibili") != 0
}

HandleDefault(action)
{
    switch action
    {
        case "Press":
            Send("^!{Down}")
        case "TurnLeft":
            Send("{Volume_Down}")
        case "TurnRight":
            Send("{Volume_Up}")
        case "PressTurnLeft":
            Send("#v")
        case "PressTurnRight":
            Send("#d")
    }
}

HandleBilibili(action)
{
    switch action
    {
        case "Press":
            Send("{Space}")
        case "TurnLeft":
            Send("{Left}")
        case "TurnRight":
            Send("{Right}")
        case "PressTurnLeft":
            Send("+1")
        case "PressTurnRight":
            Send("+2")
    }
}

HandlePdf(action)
{
    switch action
    {
        case "Press":
            Send("^!{Down}")
        case "TurnLeft":
            Send("{WheelUp}")
        case "TurnRight":
            Send("{WheelDown}")
        case "PressTurnLeft":
            Send("{Ctrl down}{WheelDown}{Ctrl up}")
        case "PressTurnRight":
            Send("{Ctrl down}{WheelUp}{Ctrl up}")
    }
}

HandleDouyin(action)
{
    switch action
    {
        case "Press":
            Send("{Space}")
        case "TurnLeft":
            Send("{Left}")
        case "TurnRight":
            Send("{Right}")
        case "PressTurnLeft":
            Send("{Up}")
        case "PressTurnRight":
            Send("{Down}")
    }
}

