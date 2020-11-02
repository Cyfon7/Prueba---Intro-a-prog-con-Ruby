require "uri"
require "net/http"

url = URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2020-11-1&api_key=wj0mdRdT2AjiAi3yOPBz2kjBgvNtxEP7hW0Nf8rz")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)

response = https.request(request)
puts response.read_body
