




$name = read-host "What is the name of the domain or computer or ip"

$i

for($i = 0; $i -lt 100; $i++) 

{

Invoke-Command -computername $comptuerList -ScriptBlock {Invoke-WMIMethod win32_process create 'cmd.exe /k "ping -t 10.0.0.1"'}

}



out-file 