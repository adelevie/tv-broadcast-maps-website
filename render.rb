require "bundler/setup"

require "pry"

require "json"
require "erb"
require "ostruct"
require "fileutils"
require "csv"

def create_file(path)
  dir = File.dirname(path)

  unless File.directory?(dir)
    FileUtils.mkdir_p(dir)
  end

  File.new(path, 'w')
end

def render_erb_string(template, locals)
  ERB.new(template).result(OpenStruct.new(locals).instance_eval { binding })
end

def render_erb_from_file(path, locals)
  erb_string = File.open(path).read
  
  render_erb_string(erb_string, locals)
end

def latlong_for_state_abbreviation(state_abbreviation)
  states = {}
  CSV.foreach("state-coordinates.csv") do |row|
    coord = {row[0] => [row[1], row[2]]}
    states.merge!(coord)
  end

  return states[state_abbreviation]
end

states = JSON.parse(File.open("states.json").read)

# temporary for development
# states = [states.first]

index_html = render_erb_from_file("index.erb", "states" => states)
create_file("www/index.html")
File.open("www/index.html", 'w') {|f| f.write(index_html) }

states.each do |state|

  latlong = latlong_for_state_abbreviation(state["abbreviation"])

  json_filenames = []
  Dir.glob("www/maps/json/#{state["abbreviation"]}/*.json") do |filename|
    json_filenames << filename.to_s
  end

  params = {
    "state" => state,
    "json_filenames" => json_filenames,
    "latlong" => latlong.to_json
  }
  map_html = render_erb_from_file("map.erb", params)
  filename = "www/" + state["name"].gsub(" ", "_") + ".html"
  create_file(filename)
  File.open(filename, 'w') {|f| f.write(map_html) }
end
