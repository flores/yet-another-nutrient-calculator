require 'rubygems'
require 'yaml'
require 'nutes'

# supported compounds
COMPOUNDS = YAML.load_file 'constants/compounds.yml'

# dosing standards
METHODS = YAML.load_file 'constants/dosingmethods.yml'

set :environment, :production
set :bind, 'localhost'
set :logging, true

run YANC.run
