#requires -version 5.1
$ErrorActionPreference = "Stop"
try {
    & {
#requires -version 5.1

$ErrorActionPreference = "Stop"

try {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    [Windows.Forms.Application]::EnableVisualStyles()
} catch {
    Add-Type -AssemblyName PresentationFramework -ErrorAction SilentlyContinue
    [System.Windows.MessageBox]::Show(
        "โหลด Windows Forms ไม่สำเร็จ`r`n$($_.Exception.Message)",
        "CHUGWOW-SETTING V2"
    )
    exit
}

# CHUGWOW-SETTING V2 | ภาษาไทย | Premium

# ตรวจสอบสิทธิ์ Administrator
try {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)

    if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        if ([string]::IsNullOrWhiteSpace($PSCommandPath)) {
            [Windows.Forms.MessageBox]::Show(
                "กรุณาเปิดไฟล์ .ps1 ด้วย PowerShell แล้วเลือก Run as Administrator",
                "CHUGWOW-SETTING V2"
            )
            exit
        }

        Start-Process powershell.exe -Verb RunAs -ArgumentList @(
            "-NoProfile",
            "-ExecutionPolicy", "Bypass",
            "-File", $PSCommandPath
        )
        exit
    }
} catch {
    [Windows.Forms.MessageBox]::Show(
        "ไม่สามารถตรวจสอบสิทธิ์ Administrator ได้`r`n$($_.Exception.Message)",
        "CHUGWOW-SETTING V2"
    )
    exit
}

$BG=[Drawing.Color]::FromArgb(7,7,12);$P=[Drawing.Color]::FromArgb(14,14,24)
$C=[Drawing.Color]::FromArgb(20,19,34);$C2=[Drawing.Color]::FromArgb(28,24,48)
$W=[Drawing.Color]::FromArgb(245,245,250);$M=[Drawing.Color]::FromArgb(145,145,165)
$PUR=[Drawing.Color]::FromArgb(155,70,255);$CY=[Drawing.Color]::FromArgb(55,210,255)
$G=[Drawing.Color]::FromArgb(50,225,130);$Y=[Drawing.Color]::FromArgb(255,200,60);$R=[Drawing.Color]::FromArgb(255,70,95)
$f9=New-Object Drawing.Font("Segoe UI",9);$fb=New-Object Drawing.Font("Segoe UI Semibold",10)
$f13=New-Object Drawing.Font("Segoe UI Semibold",13);$f20=New-Object Drawing.Font("Segoe UI Semibold",20);$f28=New-Object Drawing.Font("Segoe UI Semibold",28)

function L($t,$f,$col,$x,$y){$z=New-Object Windows.Forms.Label;$z.Text=$t;$z.Font=$f;$z.ForeColor=$col;$z.Location=New-Object Drawing.Point($x,$y);$z.AutoSize=$true;return $z}
function CMD($e,[string[]]$a){try{Start-Process $e -ArgumentList $a -Wait -PassThru -WindowStyle Hidden|Out-Null}catch{}}

# Splash
$s=New-Object Windows.Forms.Form;$s.Size=New-Object Drawing.Size(680,390);$s.StartPosition="CenterScreen";$s.FormBorderStyle="None";$s.BackColor=$BG;$s.TopMost=$true
$s.Controls.Add((L "CHUGWOW" $f28 $W 225 78));$s.Controls.Add((L "SETTING V2" $f13 $PUR 285 125))
$s.Controls.Add((L "WINDOWS • NETWORK • PERFORMANCE" $f9 $M 225 160))
$ss=L "กำลังเริ่มระบบ..." $f9 $CY 275 245;$s.Controls.Add($ss)
$b=New-Object Windows.Forms.ProgressBar;$b.Location=New-Object Drawing.Point(100,285);$b.Size=New-Object Drawing.Size(480,7);$b.Maximum=100;$s.Controls.Add($b)
$n=0;$tm=New-Object Windows.Forms.Timer;$tm.Interval=25
$tm.Add_Tick({$n+=4;$b.Value=[Math]::Min($n,100);if($n-lt30){$ss.Text="กำลังตรวจสอบสิทธิ์ผู้ดูแล..."}elseif($n-lt60){$ss.Text="กำลังโหลดโมดูลระบบ..."}elseif($n-lt90){$ss.Text="กำลังเตรียม UI..."}else{$ss.Text="พร้อมใช้งาน"};if($n-ge100){$tm.Stop();$s.Close()}})
$s.Add_Shown({$tm.Start()});[void]$s.ShowDialog();$s.Dispose()

# Main
$form=New-Object Windows.Forms.Form;$form.Text="CHUGWOW-SETTING V2";$form.Size=New-Object Drawing.Size(1220,780);$form.StartPosition="CenterScreen";$form.BackColor=$BG;$form.ForeColor=$W

$h=New-Object Windows.Forms.Panel;$h.Dock="Top";$h.Height=86;$h.BackColor=$P;$form.Controls.Add($h)
$h.Controls.Add((L "CHUGWOW" $f20 $W 28 18));$h.Controls.Add((L "SETTING" $f20 $PUR 178 18));$h.Controls.Add((L "V2" $f20 $CY 285 18))
$h.Controls.Add((L "ระบบปรับแต่ง Windows และเครือข่าย" $f9 $M 31 53));$st=L "● ONLINE" $fb $G 1050 30;$h.Controls.Add($st)

$side=New-Object Windows.Forms.Panel;$side.Location=New-Object Drawing.Point(18,103);$side.Size=New-Object Drawing.Size(245,625);$side.BackColor=$P;$form.Controls.Add($side)
$side.Controls.Add((L "CHUGWOW" $f13 $W 22 20));$side.Controls.Add((L "CONTROL PANEL" $f9 $PUR 22 48))
$nav=@("หน้าหลัก","เครือข่าย","TCP / IP","DNS","Power Plan","ทดสอบระบบ","สถิติ Headshot","ตั้งค่า");$yy=82
foreach($x in $nav){$q=New-Object Windows.Forms.Button;$q.Text="   $x";$q.Location=New-Object Drawing.Point(12,$yy);$q.Size=New-Object Drawing.Size(221,42);$q.FlatStyle="Flat";$q.FlatAppearance.BorderSize=0;$q.BackColor=$C;$q.ForeColor=$W;$q.Font=$fb;$q.TextAlign="MiddleLeft";$side.Controls.Add($q);$yy+=47}
$side.Controls.Add((L "CHUGWOW-SETTING V2" $f9 $M 22 555));$side.Controls.Add((L "Premium Gaming Utility" $f9 $PUR 22 578))

$main=New-Object Windows.Forms.Panel;$main.Location=New-Object Drawing.Point(280,103);$main.Size=New-Object Drawing.Size(920,625);$main.BackColor=$P;$form.Controls.Add($main)
$main.Controls.Add((L "ศูนย์ควบคุม" $f20 $W 28 20));$main.Controls.Add((L "จัดการระบบจากหน้าเดียว • ตรวจสอบสถานะแบบเรียลไทม์" $f9 $M 31 58))

function Metric($x,$name,$val,$col){$q=New-Object Windows.Forms.Panel;$q.Location=New-Object Drawing.Point($x,90);$q.Size=New-Object Drawing.Size(164,84);$q.BackColor=$C;$main.Controls.Add($q);$q.Controls.Add((L $name $f9 $M 12 10));$v=L $val $f13 $col 12 37;$q.Controls.Add($v);return $v}
$net=Metric 20 "NETWORK" "ONLINE" $G;$ping=Metric 195 "PING" "-- ms" $CY;$cpu=Metric 370 "CPU" "-- %" $PUR;$ram=Metric 545 "RAM" "-- %" $CY;$hs=Metric 720 "HEADSHOT" "0" $PUR

$mp=New-Object Windows.Forms.Panel;$mp.Location=New-Object Drawing.Point(20,192);$mp.Size=New-Object Drawing.Size(440,420);$mp.BackColor=$C;$main.Controls.Add($mp);$mp.Controls.Add((L "โมดูลระบบ" $f13 $W 20 16))
$mods=@(@("network","รีเซ็ต Network","Winsock + TCP/IP"),@("dns","ล้าง DNS Cache","Flush DNS Resolver"),@("ip","รีเฟรช IP","Release / Renew"),@("tcp","TCP Optimization","RSS + AutoTuning"),@("power","Power Plan","ตรวจสอบแผนพลังงาน"),@("ping","Connection Test","Ping + Packet Test"));$rows=@{};$my=52
foreach($m in $mods){$q=New-Object Windows.Forms.Panel;$q.Location=New-Object Drawing.Point(15,$my);$q.Size=New-Object Drawing.Size(410,52);$q.BackColor=$C2;$mp.Controls.Add($q);$q.Controls.Add((L $m[1] $fb $W 12 7));$q.Controls.Add((L $m[2] $f9 $M 12 29));$r=L "พร้อม" $f9 $G 342 17;$q.Controls.Add($r);$rows[$m[0]]=$r;$my+=58}

$ap=New-Object Windows.Forms.Panel;$ap.Location=New-Object Drawing.Point(480,192);$ap.Size=New-Object Drawing.Size(420,420);$ap.BackColor=$C;$main.Controls.Add($ap);$ap.Controls.Add((L "กิจกรรมล่าสุด" $f13 $W 20 16))
$log=New-Object Windows.Forms.RichTextBox;$log.Location=New-Object Drawing.Point(15,53);$log.Size=New-Object Drawing.Size(390,290);$log.BackColor=[Drawing.Color]::FromArgb(5,5,10);$log.ForeColor=$W;$log.BorderStyle="None";$log.ReadOnly=$true;$log.Font=New-Object Drawing.Font("Consolas",8.5);$ap.Controls.Add($log)
function LOG($t,$c=$W){$log.SelectionStart=$log.TextLength;$log.SelectionColor=$c;$log.AppendText("[$(Get-Date -Format HH:mm:ss)] $t`r`n");$log.ScrollToCaret();[Windows.Forms.Application]::DoEvents()}
function ROW($k,$t,$c){$rows[$k].Text=$t;$rows[$k].ForeColor=$c}
function NET{ROW network "กำลังทำงาน" $CY;LOG "รีเซ็ต Winsock..." $CY;CMD netsh.exe @("winsock","reset");LOG "รีเซ็ต TCP/IP..." $CY;CMD netsh.exe @("int","ip","reset");ROW network "สำเร็จ" $G}
function DNS{ROW dns "กำลังทำงาน" $CY;CMD ipconfig.exe @("/flushdns");ROW dns "สำเร็จ" $G;LOG "ล้าง DNS สำเร็จ" $G}
function IP{ROW ip "กำลังทำงาน" $CY;CMD ipconfig.exe @("/release");CMD ipconfig.exe @("/renew");ROW ip "สำเร็จ" $G;LOG "รีเฟรช IP สำเร็จ" $G}
function TCP{ROW tcp "กำลังทำงาน" $CY;CMD netsh.exe @("interface","tcp","set","global","rss=enabled");CMD netsh.exe @("interface","tcp","set","global","autotuninglevel=normal");CMD netsh.exe @("interface","tcp","set","global","timestamps=disabled");ROW tcp "สำเร็จ" $G;LOG "ตั้งค่า TCP สำเร็จ" $G}
function POWER{ROW power "ตรวจแล้ว" $G;LOG ("Power Plan: "+((powercfg /getactivescheme|Out-String).Trim()))}
function PING{ROW ping "กำลังทดสอบ" $CY;$r=Test-Connection 1.1.1.1 -Count 3 -ErrorAction SilentlyContinue;if($r){$a=[Math]::Round(($r|Measure-Object ResponseTime -Average).Average,1);$ping.Text="$a ms";$net.Text="ONLINE";ROW ping "ออนไลน์" $G;LOG "Ping เฉลี่ย $a ms" $G}else{ROW ping "ล้มเหลว" $R;LOG "Ping ไม่สำเร็จ" $R}}

$apply=New-Object Windows.Forms.Button;$apply.Text="⚡  ใช้การตั้งค่าทั้งหมด";$apply.Location=New-Object Drawing.Point(20,625);$apply.Size=New-Object Drawing.Size(440,48);$apply.FlatStyle="Flat";$apply.FlatAppearance.BorderSize=0;$apply.BackColor=$PUR;$apply.ForeColor=$W;$apply.Font=$fb;$main.Controls.Add($apply)
$restore=New-Object Windows.Forms.Button;$restore.Text="↩  คืนค่า TCP พื้นฐาน";$restore.Location=New-Object Drawing.Point(480,625);$restore.Size=New-Object Drawing.Size(200,48);$restore.FlatStyle="Flat";$restore.FlatAppearance.BorderSize=0;$restore.BackColor=$C2;$restore.ForeColor=$Y;$restore.Font=$fb;$main.Controls.Add($restore)
$clear=New-Object Windows.Forms.Button;$clear.Text="ล้าง Log";$clear.Location=New-Object Drawing.Point(700,625);$clear.Size=New-Object Drawing.Size(200,48);$clear.FlatStyle="Flat";$clear.FlatAppearance.BorderSize=0;$clear.BackColor=$C2;$clear.ForeColor=$M;$clear.Font=$fb;$main.Controls.Add($clear)

$apply.Add_Click({$apply.Enabled=$false;$st.Text="● กำลังทำงาน";$st.ForeColor=$CY;LOG "เริ่ม CHUGWOW-SETTING V2" $PUR;NET;DNS;IP;TCP;POWER;PING;LOG "เสร็จสิ้นทุกโมดูล" $G;$st.Text="● ONLINE";$st.ForeColor=$G;$apply.Enabled=$true})
$restore.Add_Click({if([Windows.Forms.MessageBox]::Show("คืนค่า TCP พื้นฐานหรือไม่?","CHUGWOW-SETTING","YesNo","Warning")-eq"Yes"){CMD netsh.exe @("interface","tcp","set","global","rss=default");CMD netsh.exe @("interface","tcp","set","global","autotuninglevel=normal");CMD netsh.exe @("interface","tcp","set","global","timestamps=default");ROW tcp "คืนค่าแล้ว" $G;LOG "คืนค่า TCP พื้นฐานแล้ว" $G}})
$clear.Add_Click({$log.Clear();LOG "ล้าง Log แล้ว" $M})
$form.Add_Shown({LOG "CHUGWOW-SETTING V2 ภาษาไทย พร้อมใช้งาน" $G;POWER;PING})
[void]$form.ShowDialog()

    }
}
catch {
    $msg = "CHUGWOW-SETTING V2 พบข้อผิดพลาด:`r`n`r`n" + $_.Exception.Message
    try {
        Add-Type -AssemblyName System.Windows.Forms
        [Windows.Forms.MessageBox]::Show($msg, "CHUGWOW-SETTING V2 - Error", "OK", "Error") | Out-Null
    } catch {
        Write-Host $msg -ForegroundColor Red
        Read-Host "กด Enter เพื่อปิด"
    }
}
