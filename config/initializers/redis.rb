#make sure redis has been added to your Gemfile
$redis = Redis.new(:host => 'localhost', :port=> 6379)