require "uri"
require "net/http"
require 'json'

#Request a API NASA
def request (url_requested, api_key)
    url_builded = url_requested + "&api_key=" + api_key

    url = URI(url_builded)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    JSON.parse(response.read_body)
end

# Metodo para construccion de pagina web para visualizacion
def buid_web_pag (rober_data)
    web_site_html = '
<!DOCTYPE html>
<html lang="es" dir="ltr">  
    <head> 
        <meta charset="utf-8">

        <!-- Metas -->
        <meta name="author" content="Jorge Sifontes">
        <meta name="description" content="Images direct from NASA Mars Robers">
        <meta name="keywords" content="NASA, Mars, Robers">

        <title>Rober Page</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- CSS de Bootstrap 4.5.2 -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

        <!--Font Awesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous"> 
        
    </head>
    
    <body>
        <nav class="navbar navbar-expand-md navbar-light bg-primary text-white fixed-top px-5">
            <div class="container">
                <i class="fas fa-user-astronaut fa-3x"></i>
                <i class="fas fa-rocket fa-3x"></i>
                <h1>ROBER PAGE</h1>
                <i class="fas fa-robot fa-3x"></i>
                <i class="fas fa-meteor fa-3x"></i>
            </div>
        </nav> 

        <div class="container text-center mt-5 pt-5">
                <ul class="list-group list-group-horizontal-md min-width rounded-0">'

    #Seccion donde se genera la lista            
    line = 0
    rober_data["photos"].count.times do |i|
        img_url = rober_data["photos"][i]["img_src"] 
        web_site_html = web_site_html + '
                    <li class="list-group-item"><img class="img-fluid h-100" src="'+ img_url +'" alt="img=' + (i.to_s) + '"></li>'
        line += 1
        if i < 24
            if line == 2
                web_site_html += '
                </ul> 
                <ul class="list-group list-group-horizontal-md min-width rounded-0">'
            elsif line == 5
                web_site_html += '  
                </ul> 
                <ul class="list-group list-group-horizontal-md min-width rounded-0">'
                line = 0
            end
        end
    end

    #Cierre de la pagina web
    web_site_html += '     
                </ul>            
        </div>
    </body>
</html>'

    #Creacion del archivo HTML
    File.write("./rober_page.html", web_site_html)
end


#Metodo para el conteo de 
def photos_count (rober_data)
    camera_count = {}
        
    rober_data["photos"].each do |photo|
        photo["camera"].each do |k, v|
            if k == "name"
                if camera_count.include? v
                    camera_count[v] += 1
                else
                    camera_count[v] = 1
                end
            end
        end
    end
    camera_count
end

url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=34"
key = "DEMO_KEY"

#key = "wj0mdRdT2AjiAi3yOPBz2kjBgvNtxEP7hW0Nf8rz"

hash_rober = request(url, key)

buid_web_pag(hash_rober)

puts photos_count(hash_rober)