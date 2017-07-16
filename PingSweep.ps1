
foreach ($Computer in $ComputerName) {
    
    foreach ($Port in $Ports) {
        
        # Create a Net.Sockets.TcpClient object to use for
        # checking for open TCP ports.
        $Socket = New-Object Net.Sockets.TcpClient
        
        # Suppress error messages
        $ErrorActionPreference = 'SilentlyContinue'
        
        # Try to connect
        $Socket.Connect($Computer, $Port)
        
        # Make error messages visible again
        $ErrorActionPreference = 'Continue'
        
        # Determine if we are connected.
        if ($Socket.Connected) {
            "${Computer}: Port $Port is open"
            $Socket.Close()
        }
        else {
            "${Computer}: Port $Port is closed or filtered"
        }
        
        # Apparently resetting the variable between iterations is necessary.
        $Socket.Dispose()
        $Socket = $null
        
    }
    
}

#$computer, $port = $args[0,1] # assign values to these
$mysock = new-object net.sockets.tcpclient
$IAsyncResult = [IAsyncResult] $mysock.BeginConnect($computer, $port, $null, $null)
measure-command { $succ = $iasyncresult.AsyncWaitHandle.WaitOne(3000, $true) } | % totalseconds
$succ
$mysock.Connected
$mysock.Close()
$mysock.Dispose()
