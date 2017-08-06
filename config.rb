require 'rom-repository'
require 'byebug'

ROM_CONFIG = ROM::Configuration.new(:sql, 'postgres://localhost/rom_example')
# ROM_CONFIG.auto_registration('.', namespace: 'Persistence')
