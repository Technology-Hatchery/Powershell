<#
.SYNOPSIS
	Get an Access Token using oAuth2 from Google.
	Modify to add your ClientID and Secret and
	change scope to the applicable scope you require.

.DESCRIPTION
	Script will copy a URL to your clipboard to get the Access Code 
	which you then need to paste into the script window in order 
	to get your Access Token.  Then use the Token for your request.
	
	Scope is currently set to Google Groups Provisioning API
	
.LINK
	www.userdel.com
	https://developers.google.com/oauthplayground
	
.NOTES
	Josh C (@irlrobot)
	www.userdel.com
	5/29/13
#>

#$clientId = "YOUR_CLIENT_ID.apps.googleusercontent.com"
$clientId = "M0QtsPiAT92DoFKCZZ7QlRitZ"
$clientSecret = "99UqDRqGK0Vit1VJspIbKqKCrVhlNYdQvIG99dkFhyNSH0si8f"
#return to us locally not via a web server
$redirectUri = "urn:ietf:wg:oauth:2.0:oob"
$grantType = "authorization_code"
#change scope here, you can use oauth playground to find scopes
#https://developers.google.com/oauthplayground
$scope= "https://apps-apis.google.com/a/feeds/groups/"
$responseType = "code"

$getCodeUrl = "https://accounts.google.com/o/oauth2/auth?scope=$scope&redirect_uri=$redirectUri&response_type=$responseType&client_id=$clientId"

#copy url to fetch code to clipboard
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[System.Windows.Forms.MessageBox]::Show("I copied some text to your clipboard, paste it into a browser to get your access code.") 
"$getCodeUrl" | Clip

$accessCode = Read-Host "Enter the access code:  "

$requestUri = "https://accounts.google.com/o/oauth2/token"
$requestBody= "client_secret=$clientSecret&grant_type=$grantType&code=$accessCode&client_id=$clientID&redirect_uri=$redirectUri"

#exchange the code for a token
Try {
	Invoke-RestMethod -URI $requestUri -Method Post -Body $requestBody
}
Catch {
	Write-Host $_.Exception.ToString()
	$error[0] | Format-List -Force
}