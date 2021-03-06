require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

enable :sessions

use Rack::MethodOverride
use Rack::Flash

run ApplicationController
use ArtistsController
use SongsController
use GenresController
