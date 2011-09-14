require 'rubygems'
require 'yaml'
require 'nutes'

# supported compounds
COMPOUNDS = YAML.load_file 'constants/compounds.yml'

YANC.run! :environment => :production, :bind => 'localhost', :logging => 'true'
