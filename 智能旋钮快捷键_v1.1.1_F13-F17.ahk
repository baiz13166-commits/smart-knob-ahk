#Requires AutoHotkey v2.0
#SingleInstance Force

; v1.1.1
; 外设触发键：F13-F17（无 Ctrl/Alt/Shift，不受 Num Lock 影响）
; 常规模式：按下 Ctrl+Alt+Down，按住左转 Win+V，按住右转 Win+D。

; 仅供自动检查脚本语法；平时双击运行时不会触发。
if A_Args.Length && A_Args[1] = "--validate"
    ExitApp

; ============================================================
; 外设发出的五组基础快捷键
;   按下             F13
;   向左旋转         F14
;   向右旋转         F15
;   按下并向左旋转   F16
;   按下并向右旋转   F17
; ============================================================

$F13::HandleKnobAction("Press")
$F14::HandleKnobAction("TurnLeft")
$F15::HandleKnobAction("TurnRight")
$F16::HandleKnobAction("PressTurnLeft")
$F17::HandleKnobAction("PressTurnRight")

HandleKnobAction(action)
{
    ; 优先级：抖音客户端 -> Edge PDF -> Edge 哔哩哔哩 -> 常规模式。
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
            Send("^{Down}")
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

