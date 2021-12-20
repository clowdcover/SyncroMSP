$WebURL = "https://tenantname.sharepoint.com/sites/"
$SiteName = "MySiteName"
$SiteID = "{my Site GUID}"
$WebID = "{my Web GUID}"
$ListID = "{my List GUID}"

# Give Windows some time to load before getting the email address
Start-Sleep -s 20

$UserName = $env:USERNAME
$Domain = "@yourdomain.com"

# Use a "Do" loop to check to see if OneDrive process has started and continue to check until it does
Do{
    # Check to see if OneDrive is running
    $ODStatus = Get-Process onedrive -ErrorAction SilentlyContinue
    
    # If it is start the sync. If not, loopback and check again
    If ($ODStatus) 
    {
        # Give OneDrive some time to start and authenticate before syncing library
        Start-Sleep -s 30

        # set the path for odopen
        $odopen = "odopen://sync/?siteId=" + $SiteID + "&webId=" + $WebID + "&webUrl=" + $webURL + $SiteName + "&listId=" + $ListID + "&userEmail=" + $UserName + $Domain + "&webTitle=" + $SiteName + ""
        
        #Start the sync
        Start-Process $odopen
    }
}
Until ($ODStatus)