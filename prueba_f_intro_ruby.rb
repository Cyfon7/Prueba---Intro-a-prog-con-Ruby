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
def buid_web_pag (rober_data)
    web_site_html = " "
    web_site_html = "<html>\n \t<head>\n \t</head>\n \t<body>\n \t\t<ul>\n"
    
    #rober_data["photos"].count.times do |i|   #solo para data original
    rober_data[:photos].count.times do |i|     #usar para dummy data
    #    img_url = rober_data["photos"][i]["img_src"]     #solo para data original
        img_url = rober_data[:photos][i]["img_src"]       #usar para dummy data
        web_site_html = web_site_html + "\t\t\t<li><img src='#{img_url}'></li>\n"
    end

    web_site_html += "\t\t</ul>\n \t</body>\n </html>\n"
    
    File.write("./rober_page.html", web_site_html)

end

def photos_count ()

end

dummy_hash_rober = {"photos":[{"id": 771812,"sol": 2929,"camera":{"id": 20,"name": "FHAZ","rover_id": 5,"full_name": "Front Hazard Avoidance Camera"},"img_src": "https://mars.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/02929/opgs/edr/fcam/FLB_657515400EDR_F0830306FHAZ00206M_.JPG","earth_date": "2020-11-01","rover": {"id": 5,"name": "Curiosity","landing_date": "2012-08-06","launch_date": "2011-11-26","status": "active"}},
       {
            "id": 771813,
            "sol": 2929,
            "camera": {
                "id": 20,
                "name": "FHAZ",
                "rover_id": 5,
                "full_name": "Front Hazard Avoidance Camera"
            },
            "img_src": "https://mars.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/02929/opgs/edr/fcam/FRB_657515400EDR_F0830306FHAZ00206M_.JPG",
            "earth_date": "2020-11-01",
            "rover": {
                "id": 5,
                "name": "Curiosity",
                "landing_date": "2012-08-06",
                "launch_date": "2011-11-26",
                "status": "active"
            }
        },
        {
            "id": 771814,
            "sol": 2929,
            "camera": {
                "id": 26,
                "name": "NAVCAM",
                "rover_id": 5,
                "full_name": "Navigation Camera"
            },
            "img_src": "https://mars.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/02929/opgs/edr/ncam/NLB_657515435EDR_F0830306NCAM00320M_.JPG",
            "earth_date": "2020-11-01",
            "rover": {
                "id": 5,
                "name": "Curiosity",
                "landing_date": "2012-08-06",
                "launch_date": "2011-11-26",
                "status": "active"
            }
        },
        {
            "id": 771815,
            "sol": 2929,
            "camera": {
                "id": 26,
                "name": "NAVCAM",
                "rover_id": 5,
                "full_name": "Navigation Camera"
            },
            "img_src": "https://mars.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/02929/opgs/edr/ncam/NRB_657515435EDR_F0830306NCAM00320M_.JPG",
            "earth_date": "2020-11-01",
            "rover": {
                "id": 5,
                "name": "Curiosity",
                "landing_date": "2012-08-06",
                "launch_date": "2011-11-26",
                "status": "active"
            }
        },
        {
            "id": 771816,
            "sol": 2929,
            "camera": {
                "id": 26,
                "name": "NAVCAM",
                "rover_id": 5,
                "full_name": "Navigation Camera"
            },
            "img_src": "https://mars.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/02929/opgs/edr/ncam/NRB_657514364EDR_M0830306NCAM00580M_.JPG",
            "earth_date": "2020-11-01",
            "rover": {
                "id": 5,
                "name": "Curiosity",
                "landing_date": "2012-08-06",
                "launch_date": "2011-11-26",
                "status": "active"
            }
       }
    ]
}

url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"
key = "DEMO_KEY"

#"wj0mdRdT2AjiAi3yOPBz2kjBgvNtxEP7hW0Nf8rz"

#hash_rober = request(url, key)
buid_web_pag(dummy_hash_rober)

#print hash_rober['photos']

=begin
hash_rober.each do |data|
    data[-1].to_a.each do |data1|
        data1.each do |k, v|
            puts "#{k} = #{v}"
        end
    end
end
=end

dummy_hash_rober.each do |k, v|
    v.count.times do |i|
        v[i].each do |k1, v1|
            if k1 == :img_src
                print "#{k1} = #{v1} \n"
            end
        end
        print "\n"
    end
end

puts dummy_hash_rober[:photos][0][:img_src]