#Heroku Deployment for Rails/PG

##Checklist (Before you even think of deploying!)

- Does your app work locally? (If you have errors, they won't magically be solved by deploying to Heroku!)
- Do you have seed data/is your app equipped to add objects to your DB? (Locally-stored data won't push up.)
- Does your schema look the way you want it to?
- Are you working from the command line **in the app directory**?

-----------------
##Things That Are Familiar	
	
###Precompile assets	        
- **Add the rails_12factor gem**
	- Add the following to your Gemfile: `gem 'rails_12factor'`
	- Run a `bundle install`
	
- **(only if you get an I18n error when you run rake tasks) Run the locales fix**
	- Add the line `config.i18n.enforce_available_locales = true` to config/application.rb  following `class Application < Rails::Application` (usually ~ line 15 or 16)
- **Prep your app for precompile**
	- Open **config/environments/production.rb** 
	- Set `config.assets.compile` to true (should be line 30 or nearby) 
	- Overwrite the Rails-default comment that reads `# config.assets.precompile += %w( search.js )` (should be around line 62) with `config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif] `
	
###Get this show on the road
- **Precompile locally**
	- In your terminal, run `RAILS_ENV=production bundle exec rake assets:precompile`
- **Add - Commit - Push**
	- One more time (following that precompile!)
	- `git add .`
	- `git commit -m "precompiled assets locally"`
	- `git push heroku master`



###Set up your repo

- `git init` in your app directory (if you haven't already)
- `git add .` and `git commit -m "some message"` so there's something to push

###Create your Heroku app

- `heroku domains` to check that you don't already have a Heroku app for this repo (if you see anything other than **!   No app specified**, you probably already have an app.)
- `heroku create` to create a new Heroku app (or `heroku create myfancyapp` to create an app with a pre-set name, in this case, *myfancyapp*)
- go ahead and double-check that business with a `heroku domains`
- add and commit your repo if you haven't already, then `git push heroku master`

-----------------
##Things That Are New	


###Set up your PG add-ons

- In your terminal, type `heroku addons:add heroku-postgresql` 
- Check that this step worked by running `heroku config` in your terminal. You should see a list of variables that includes one called **HEROKU_POSTGRESQL_`_SOME_COLOR_`_URL** (in place of `some color` you'll see CYAN or CHARCOAL or MAROON or another color name). Note this var.


###Reset your PG (drop and recreate tables), then migrate and (optionally) seed

- **Set up that DB**
	- In your terminal, run `heroku pg:reset HEROKU_POSTGRESQL_CYAN_URL` (replace CYAN with your DB's color -- this *will not work* if you copy-paste the above unless you happen to be on CYAN). This will drop and recreate your tables (alas, the Heroku PG add-on doesn't have a handy pg:create task)
- **Migrate your DB**
	- In your terminal, run `heroku run rake db:migrate`
-**(Optional) Seed the DB**
	- In your terminal, run `heroku run rake db:seed` 
	
	
 

	
