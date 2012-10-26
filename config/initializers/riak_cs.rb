require 'yaml'

file   = File.join(Rails.root, "config", "riak_cs.yml")
config = YAML.load_file(file)
env    = Rails.env

RIAK_CS_HOST         = config[env]["host"]
RIAK_CS_PORT         = config[env]["port"]
RIAK_CS_SCHEME       = config[env]["scheme"]
RIAK_CS_ADMIN_KEY    = config[env]["admin_key"]
RIAK_CS_ADMIN_SECRET = config[env]["admin_secret"]
