require 'rubygems'
require 'yaml'
require 'nutes'

# supported compounds
COMPOUNDS = YAML.load_file 'constants/compounds.yml'

# dosing standards
METHODS = YAML.load_file 'constants/dosingmethods.yml'

run YANC.run! :environment => :production, :bind => 'localhost'
