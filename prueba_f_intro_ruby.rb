require "uri"
require "net/http"
require 'json'

#Request a web site de NASA
def request (url_requested, api_key)
    url_builded = url_requested + "?earth_date=2020-11-1&api_key=" + api_key
    
    url = URI(url_builded)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    resultado = JSON.parse(response.read_body)
end

# Metodo para construccion de pagina web para visualizacion
def buid_web_pag (rober_images)


end

def photos_count ()

end



url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"
key = "wj0mdRdT2AjiAi3yOPBz2kjBgvNtxEP7hW0Nf8rz"

#request(url, key)

