##\ -p 8080
$:.unshift "#{File.dirname(__FILE__)}"

require 'rubygems'
require 'yaml'
require 'nutes'

# supported compounds
COMPOUNDS = YAML.load_file 'constants/compounds.yml'
COMMERCIAL = YAML.load_file 'constants/commercial_products.yml'

YANC.run! :environment => :production, :bind => 'localhost', :logging => 'true'
