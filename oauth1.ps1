Add-Type -Path "X:\Dropbox\Technology Hatchery Inc\technical\Git\Powershell\DevDefined.OAuth.dll"
$cons = New-Object devdefined.oauth.consumer.oauthconsumercontext

$cons.ConsumerKey = 'M0QtsPiAT92DoFKCZZ7QlRitZ'
$cons.ConsumerSecret = '99UqDRqGK0Vit1VJspIbKqKCrVhlNYdQvIG99dkFhyNSH0si8f'
$cons.SignatureMethod = [devdefined.oauth.framework.signaturemethod]::HmacSha1

$session = new-object DevDefined.OAuth.Consumer.OAuthSession $cons, "http://twitter.com/oauth/request_token", "http://twitter.com/oauth/authorize","http://twitter.com/oauth/access_token"
$rtoken = $session.GetRequestToken()  #unique token just for authorization
$authLink = $session.GetUserAuthorizationUrlForToken($rtoken, 'anything') #$authLink http://twitter.com/oauth/authorize?oauth_token=RMmhALQzA1glYlR....&oauth_callback=anything
[diagnostics.process]::start($authLink)  #redirection to Twitter

$pin = read-host -prompt 'Enter PIN that you have seen at Twitter page'
$accessToken = $session.ExchangeRequestTokenForAccessToken($rtoken, $pin)
$accessToken | Export-CliXml C:\Users\Alfred\Desktop\myTwitterAccessToken.clixml