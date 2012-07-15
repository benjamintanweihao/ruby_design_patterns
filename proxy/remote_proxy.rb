# Now let's see what is a RemoteProxy

# Idea: Let the RemoteProxy handle all the packaging up of the request, sending over the 
#       network, waiting for a response, unpacking the response, and returning the 
#       answer to the client.

# To the client, it thinks that its a method called on the _real_ BankAccount object.
# This is how RPCs work.

require 'soap/wsdlDriver'

wsdl_url = 'http://www.webservicex.net/WeatherForecast.asmx?WSDL'

proxy = SOAP::WSDLDriverFactory.new(wsdl_url).create_rpc_driver

# When the proxy is set up, the client doesn't need to bother about where the 
# webservice lives. 

weather_info = proxy.GetWeatherByZipCode('ZipCode' => '94086')
