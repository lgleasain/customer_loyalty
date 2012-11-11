desc 'Deploy safely to Heroku'
task :deploy do
  sh "git push origin master"
  sh "git push heroku master"
  sh "heroku run rake db:migrate"
  sh "heroku restart"
  sh "curl http://localloyalty.herokuapp.com > /dev/null 2> /dev/null"
end
