540385. rails new simple_cms -d mysql

540386. File Structure of a project 
	mysql -u root -p
	CREATE DATABASE simple_cms_development;
	CREATE DATABASE simple_cms_test;
	GRANT ALL PRIVILEGES ON simple_cms_development.* TO 'rails_user'@'localhost' IDENTIFIED BY 'secretpassword';
	GRANT ALL PRIVILEGES ON simple_cms_test.* TO 'rails_user'@'localhost' IDENTIFIED BY 'secretpassword';
	exit;

540387. Configure a project
	database.yml -> specified the username and password
	Test Connection: rails db:schema:dump #get all the definition of database db/schema.rb

540389. Generate a controller and view
	rails generate controller demo index

540391. Routes
	Simple Route -> get "demo/index"
	Simple Match Route -> match "demo/index", :to => "demo#index", :via => :get
	Default Route -> get ':controller(/:action(/:id))'
	Default Match Route -> match ':controller(/:action(/:id))', :via =? :get
	Root Route: root "demo#index"
	Root Match Route: match "/", :to => "demo#index", :via => :get

540394. Render a template
	render(:template => 'demo/hello')
	render('demo/hello') #if calling different controller, will need to specify demo
	render('hello') #if calling in the same controller

	rendering will render to template, not action in the controller
":"
540395. Redirect actions
	HTTP Redirect -> involve reloading, data will be gone, url change
	redirect_to(:controller => 'demo', :action => 'index')
	redirect_to(:action => 'index') #if calling in the same controller
	redirect_to('http://lynda.com')

540396. View templates
	<% code %> #process ruby code, no output
	<%= code %> #output the end result
	<% target = "world" %>  <%= "Hello #{target}" %>
	<%= 3.times do |n|
			puts n
		end %> #output 3 in browser, output 0, 1, 2 in console
	<% 3.times do |n| %>
		<%= n %><br />
	<% end %> #output 0, 1, 2 in browser

540397. Instance variables
	variable -> local variable
	@instance_variable -> only way to pass from controller to view

	@array = [1,2,3,4,5] #controller
	<% @array.each do |n| %> #view
		<%= n %><br />
	<% end %>

540398. Links
	<%= link_to(text, target) %> #link_to is a helper method
	<%= link_to("demo/index") %>
	<%= link_to('hello', {:controller => 'demo', :action => 'index'}) %>
	<%= link_to('hello', {:action => 'index'}) %>

540399. URL parameters
	Accessing Parameter Values -> params are always string
	params[:id]
	params['id']

	<%= link_to('hello with parameters', {:action => 'hello', :page => 5, :id =>20}) %> -> http://localhost:3000			/demo/hello?id=20&page=5

	get ':controller(/:action(/:id))' -> http://localhost:3000/demo/hello/20?page=5

	@id = params['id']
	@page = params[:page]

	@page.to_i + 1 #convert string to integer

540402. Create a database
	GRANT ALL PRIVILEGES ON db_name.* TO 'username'@'localhost' IDENTIFIED BY 'password';
	SHOW GRANTS FOR 'username'@'localhost';

	rails db:schema:dump

540404. Generate migrations
	rails generate migration MigrationName (camel case)

	migration file -> def up/down

540405. Generate models
	rails genearte model ModuleName (camel case)
	Table column Types: binary, boolean, date, datetime, decimal, float, integer, string, text, time
	Table column options:
		:limit => size
		:default => value
		:null => true/false
		:precision => number
		:scale => number

	class CreateUsers < ActiveRecord: :Migration[5.0]
	def up
		create_table :users do |t|  #create_table :users, :id => false do |t|

			t.column "first_name", :string, :limit => 25
			t.string "last_name", :limit => 50
			t.string "email", :default => '', :null =>false
			t.string "password", :limit => 40


			t.timestamps
			#t.datetime "created_at"
			#t.datetime "updated_at"
		end
	end

	def down
		drop_table :users
	end

540406. Run migrations
	rails db:migrate
	mysql -u rails_user -p simple_cms_development
	SHOW TABLES;
	SHOW FIELDS FROM users;
	SHOW FIELDS FROM schema_migrations;
	SELECT * FROM schema_migrations;
	rails db:migrate VERSION=0
	rails db:migrate:status			#output migrate version number
	rails db:migrate VERSION=XXXXXXXXXXX
	rails db:migrate:up VERSION=XXXXXXXXXX
	rails db:migratea:down VERSION=XXXXXXXXXX

540407. Migration methods
	rename_table(table, new_name)
	add_column(table, column, type, options)
	remove_column(table, column)
	rename_column(table, column, new_name)
	change_column(table, column, type, options)
	add_index(table, column, options)
	remove_index(table, column)

	Index Migration Method Options:
	:unique => true/false
	:name => "your_custom_name"

	rails generate migration AlterUsers

	def up
		rename_table("users", "admin_users")
		add_column("admin_users", "username", :string, :limit => 25, :after => "email")
		change_column("admin_users", "email", :string, :limit => 100)
		rename_column("admin_users", "password", "hashed_password")
		put "*** Adding and index ***"
		add_index("admin_users", "username")
	end

	def down
		#everything above in reverse older
	end


540412. ActionRecord and ActiveRelation
	users = User.where(:first_name => "kevin")
	users = Users.order("last_name ASC").limit(5)

540413. Model naming
	rails genearte model SingularName (camel case)
	rails generate model Subject

	class User < ApplicationRecord
		self.table_name = "admin_users" #tell rails which table to use

		attr_accessor :first_name

		def last_name
			@last_name
		end

		def last_name=(value)
			@last_name = value
		end
	end

540415. The Rails console
	rails console development
	rails console
	rails c
	irb  #interactive ruby console

540416. Create records
	rails console
	subject = Subject.new #create a new instance of Subject class
	subject.new_record? #true, has not been save to database yet
	subject.name = "First Subject"
	subject.name #display "First Subject"
	subject = Suject.new(:name => "First Subject", :position => 1, :visible => true)
	subject.save
	subject.id #automatically assigned when save
	subject.created_at
	subject.updated_at

	subject = Subject.create(:name => 'Second Subject', :position => 2)

540417.	Update records
	subject = Subject.find(1)
	subject.new_record? #false
	subject.name = "Initial Subject"
	subject.save #will fire an UPDATE statement
	subject.update_at

	subject = Subject.find(2)
	subject.update_attributes(:name => 'Next Subject', :visible => true)

540418. Delete records
	subject = Subject.find(1)
	subject.destroy #will fire DELETE statement, still return current subject

540419. Find records
	Primary key finder -> Subject.find(2)   #Returns an object of an error
	Dynamic finders -> Subject.find_by_id(2)	#Returns an object or nil
			Subject.find_by_name("First Subject")
	Find all -> Subject.all #Returns an array of objects
	Find first/last -> Subject.first
			Subject.last  #Returns an object of nil

	subjects = Subject.all
	subjects.each do |subject|
		puts subject.name
	end

540420. Query methods - Conditions
	Subject.where(:vivible => true)
	Subject.where("name='Test' AND visible=true")  #SQL injection
	Subject.where(["name=? AND VISIBLE=true", "Test"]) #escaped SQL and safe
	Subject.where({:name => "Test", :visible => true})   #Hash, join with AND
	User.where(:last_name=>'Smith').where(:first_name => 'John')

	subjects.class
	subjects.to_sql

540421. Query methods - Order, limit, and offset
	Subject.order(:position).limit(20).offset(40)
	order(:position)
	order("position")
	order(:position => :asc)
	order("position ASC")
	order(:position => :desc)
	order("position DESC")

	subjects = Subject.order(:position DESC)
	subjects = Subject.limit(1).offset(2)
	subjects = Subject.where(:visible => true). order("position ASC").limit(1).offset(1)

540422. Named scopes
	scope :active, lambda {where(:active => true)} #recommand lambda way
	scope :active, -> {where(:active => true)}

	def self.active    #class method way
		where(:active => true)
	end

	scope :with_content_type, lambda {|ctype|
		where(:content_type => ctype)
	}

	def self.with_content_type(ctype)
		where(:content_type => ctype)
	end

	Section.with_content_type('html')

	#Evaluated when called, not when defined
	scope :recent, lambda {
		where(:create_at => 1.week.ago..Time.now)
	}

	#Chaining scopes
	Articles.recent.visible.newest_first

	class Subject < ApplicitonRecord
		scope :visible, lambda { where(:visible => true) }
		scope :visible, lambda { where(:visible => false) }
		scope :sorted, lambda { order("position ASC") }
		scope :newest_first, lambda { order("created_at DESC") }
		scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])} #%% wild card
	end

540425. One-to-one associations
	For 1:1 relation (has_one, belongs_to), when making the association on objects, it does try to save the object to 		database

	Remove association -> subject.page = nil  #removes the association but does not remove the record

	Destroy record -> subject.page.destroy

	*To associate multiple column (ticket) to the same table (user)* <br />
	In Ticket:
	belongs_to :requestor, :class_name => 'User', :foreign_key => 'requestor_user_id'
	belongs_to :resource, :class_name => 'User', :foreign_key => 'resource_user_id'
	
	In User:
	has_many :as_ticket_requestor, :class_name => 'Ticket', :foreign_key => 'requestor_user_id'
	has_many :as_ticket_resource, :class_name => 'Ticket', :foreign_key => 'resource_id'

540426. One-to-many associations
	For 1:M relation (has_many, belongs_to),

	subject.pages << page
	subject.pages = [page, page, page]
	subject.pages.delete(page) #remove association
	subject.pages.destroy(page) #destroy the record
	subject.pages.clear #remove all pages
	subject.pages.empty? #check if array is empty
	subject.pages.size

540427. belongs_to presence validation
	page.errors.full_messages  #error saving page when page needs to belongs_to a subject

	belongs_to :subject, { :optional => true }  #save without parent (subject_id)

540428. Many-to-many associations - Simple
	For M:N, require a join table with two foreign keys (simple join)

	Project has_and_belongs_to_many :collaborators

	#specify the join table name, otherwise, rails will use default naming convention
	has_and_belongs_to_many :admin_users, :join_table => 'pages_admin_users'

	create_table :admin_users_pages, :id => false do |t|
		t.integer "admin_user_id"
		t.integer "page_id"
	end
	add_index("admin_users_pages", ["admin_user_id", "page_id"])

540429. Many-to-many associations - Rich
	For M:N rich join (-ments, -ships)

	create_table :section_edits do|t|
		t.integer "admin_user_id"
		t.integer "section_id"
		t.string "summary"
		t.timestamps
	end
	add_index("section_edits", ['admin_user_id', 'section_id'])

	rails db:migrate

	#section_edits will have two parents, can not use << to add, must add directly to #sections_edits table with specified
	#parent keys
	me = AdminUser.find(1)
	section = Section.create(:name => 'Section One', :position => 1)
	edit = SectionEdit.new(:summary => 'Test edit', :admin_user => me, :section => section)
	edit.save
	me.section_edits(true)   #reload from database

540430. Travese a rich association
	section.section_edits.map {|se| se.admin_user}

	has_many :through
	AdminUser has_many :section_edits
	AdminUser has_many :sections, :through => :section_edits

540435. Resourceful URL helpers
	GET		  /subjects						 	  index			subjects_path
	GET		  /subjects/:id				 	  show			subject_path(:id)
	GET		  /subjects/new				 	  new				new_subject_path
	POST	  /subjects						 	  create		subjects_path
	GET		  /subjects/:id/edit			edit			edit_subject_path(:id)
	PATCH	  /subjects/:id				 	  update		subject_path(:id)
	GET		  /subjects/:id/delete		delete		delete_subject_path(:id)
	DELETE	/subjects/:id						destroy		subject_path(:id)

540440. Create actions - new
	<%= form_for(@subject, :url => subject_path, :method => 'post') do |f| %>
	<%= form_for(@subject) do |f| %>

	#define form default value
	def new
		@subject = Subject.new({:name => 'default'})
	end

540445. Flash hash
	Flash hash -> will only be accessible for one additional request
	flash[:notice] = "The subject '#{@subject.name}' was created successfully"
	flash[:error] = "Not enough access privileges"

	<% if !flash[:notice].blank? %>
		<div class="notice">
			<%= flash[:notice] %>
		</div>
	<% end %>

	.blank? check for nil and empty string

540449. Layout
	<%= yield %> #placed inside layout erb
	layout 'admin' #placed inside controller

540450. Partial Templates
	<%= render(:partial => 'form', :locals => {:f => f}) %>
	<%= render('form') %>

540451. Text helpers
	<%= word_wrap(text, :line_width => 30) %>
	<%= simple_format(text) %>  #works on <p> and interpret /n as <br />
	<%= truncate(text, :length => 28) %>
	#pluralize
	<% [0, 1, 2].each do |n| %>
		<%= pluralize(n, 'product') %> found. <br />
	<% end %>

540452. Number helpers
	number_to_currency(34.5, :precision => 0, :unit => "kr", :format => "%n %u") #35 kr
	number_to_percentage(34.5, :precision => 1, :separator => ',') #34,5%
	number_with_precision(34.56789, :precision => 6) #34.567890
	/ number_to_rounded
	number_with delimiter(3456789, :delimiter => ' ') #3 456 789
	/ number_to_delimited
	number_to_human(123456789, :precision => 5) #123.46 Million
	number_to_human_size(123456789, :precision => 2) #1.2 MB
	number_to_phone(1234567890,
		:area_code => true,
		:delimiter => '',
		:country_code => 1,
		:extension => '321')   # +1 (123) 456 7890 x 321

540453. Date and Time helpers
	Time.now + 30.days - 23.minutes
	30.days.ago
	30.days.from_now
	Time.now.now.last_year.end_of_month.beginning_of_day
	datetime.strftime( format_string )
	Time.now.strftime("%B %d, %Y %H:%M") # July 17, 2016 18:14
	datetime.to_s( format_symbol )
	Time.now.to_s(:long) # July 17, 2016 18:14

	#DateTime Default Formats
	:db 			"2016-01-09 13:36:29"
	:number 		"20160109133629"
	:time 			"13:36"
	:short 			"09 Jan 13:36"
	:long 			"January 09, 2016 13:36"
	:long_ordinal	"January 9th, 2016 13:36"

540454. Custom helpers
	- defined under app/helpers/application_helper.rb
		def status_tag(boolean, options={})
			options[:true_text] ||= ''
			options[:false_text] ||= ''

			if boolean
				content_tag(:span, options[:true_text], :class => 'status true')
			else
				content_tag(:span, options[:false_text], :class => 'status false')
			end
		end
	- Use helper method: <%= status_tag(subject.visible) %>
	- CSS are defined in app/views/layouts/admin.html.erb
		<style>
			span.status { display: block; width: 10px; height: 10px; margin: 0.25em auto;
					padding: 0; border: 1px solid #000000; }
			span.status.true { background: green; color: green; }
			span.status.false { background: red; color: red; }
		</style>

540455. Sanitization helpers
	- Cross-Site Scripting (XSS)
	- Escape Methods: html_escape(), h(), raw(), html_safe
	- Escape is by default, to turn off
		<%= raw evil_string %>
		<%= evil_string.html_safe %>
	- Escape Out: strip_links(html), strip_tags(html), sanitize( html, options )
		text = '<strong>Please</strong> visit <a href="http://example.com">us</a>.'
		strip_links(text)
		# <strong>Please</strong> visit us.
		sanitize(@subject.content, 
			:tags => ['p','br','strong','em'],
			:attributes => ['id','class','style'])

540457. Asset pipeline
	- Concatenates CSS and Javascript files
	- Compresses and minifies CSS and JavaScript
	- Precompile CSS and Javascript
	- Allows writing assets in other languages
	- Add asset fingerprinting
	- Precompilation
		export RAILS_ENV=production
		bundle exec rails assets:precompile

540458. Stylesheets
	Location
	- Asset pipeline: /app/assets/stylesheets
	- Asset pipeling: /public/stylesheets
	File name
	- Should end in ".css"; Sass(Syntactically Awesome Stylesheets) files end in ".css.scss"
	- app/assets/stylesheets/application.css
		* require_tree .
		*= require primary
		*= require_self
	- config/initializers/asset.rb
		Rails.application.config.assets.precompile += %w( admin.css main.css )
	- <%= stylesheet_link_tag('application', :media => 'all') %>

540459. Javascript
	Location
	- Asset pipeline: /app/assets/javascripts
	Manifest file
	- /app/assets/javascripts/application.js
	- config/initializers/asset.rb
		Rails.application.config.assets.precompile += %w( admin.css main.js )
	- <%= javascript_include_tag('application') %>
	- <%= link_to('Roar', '#', :onclick => "jsRoar('Javascript'); return true;") %>

540460. Javascript tag and sanitizing
	<%= javascript_tag("alert('Are you sure?');") %>
	<%= javascript_tag do %>
		alert('Are you sure?');
	<% end %>
	- Use escape_javascript(), j()
		<%= javascript_tag("alert('You said: #{j(text)}');") %>
		#alert('You said: \'); alert(\'Gotcha!');

540461. Images
	Location
	- asset pipeline: /app/assets/images
	- Without asset pipeline: /public/images
	- User-uploaded images: /public/images
	Image upload gems
	- Paperclip and CarrierWave
	<%= image_tag('logo.png') %>
	<%= image_tag('logo.png', :size => '90x55', :alt => 'logo') %>
	<%= image_tag('logo.png', :width => 90, :height => 55) %>
	From scss file
	- background: $light_brown image-url('footer_gradient.png') repeat-y 0 0;

540463. Form helpers
	<%= text_field_tag('name', params[:name]) %>
	<%= text_field(:subject, :name) %>
	<%= f.text_field(:name) %>
	f.label(:name)
	f.text_field(:name, :size => 40, :maxlength => 40)
	f.password_field(:password, :size => 40)
	f.hidden_field(;token, 'abcdf0123456789')
	f.text_area(:description, :size => "40x5") # :cols/:rows
	f.radio_button(:content_type, "text")
	f.radio_button(:content_type, "html")
	f.check_box(:visible)
	f.file_field(:logo) #require :multipart => true

540464. Form options helpers
	select(object, attribute, choices, options, html_options)
	options:
		:selected => object.attribute
		:include_blank => false
		:prompt => false
		:disabled => false
	form_for(@section) do |f|
		#Range
		f.select( :position, 1..5 )
		#Array
		f.select( :content_type, ['text', 'html'] )
		#Hash
		f.select( :visible, { "Visible" => 1, "Hidden" => 2 } )
		#Array of arrays
		f.select( :page_id, Page.all.map {|p| [p.name, p.id]} )
	end

540465. Date and time form helpers
	date_select(object, attribute, options, html_options)
	time_select(ojbect, attribute, options, html_options)
	datetime_select(object, attribute, options, html_options)

540466. Form errors
	object.errors.clear
	object.errors.size
	object.errors.each { |attr, msg| ... }  # :name, "can't be blank"
	object.errors.full_messages.each { |msg| ... }  # "Name can't be blank"

	create app/views/application/_error_messages_html.erb
	add a helper method in application_helper.rb to render partial page
	call helper method inside the view page that need to display error
	add validation to module, validates_presence_of :name
	customize error field with css using <div class="field_with_errors">

540467. Prevent cross-site request forgery (CSRF)
	- authenticity_token is stored inside session cookie and each form as a hidden field to prevent other site to use GET (<img src="http://bank.com/transfer?amt=10000&to=hacker" />) to exploits user's currently logged-in state to perform actions which require authentication
	- protect_from_foregery with: :exception   # ApplicationController
	- GET should be read-only
	- Actions that expects POST requests should only respond to POST requests
	- CSRF Token of Javascript and Ajax: <%= csrf_meta_tag %>  MUST DO

540469. Validation methods
	validates_presence_of :name

540470. Write validations
	validates_length_of :name, :maximum => 255
	validates_length_of :permalink, :within => 3..255
	#every subject must have a unique permalink
	validates_uniqueness_of :permalink :scope => :subject_id

	#Validate Content type
	CONTENT_TYPES = ['text', 'HTML']
	validates_inclusion_of :content_type, :in => CONTENT_TYPES, :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
	validates_presence_of :content

	#Validate Email
	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	validates_format_of :email, :with => EMAIL_REGEX
	validates_confirmation_of :email
	validates_presence_of :email
	validates_length_of :email, maximum => 100

	s = Subject.new
	s.valida? #update the error
	s.errors.full_messages

540471. Validates method
	validates :attribute, :presence => boolean,
						:numericality => boolean,
						:length => options_hash,  #{ :maximum => 50 }
						:format => {:with => regex},
						:inclusion => {:in => array_or_range},
						:exclusion => {:in => array_or_range},
						:acceptance => boolean,
						:uniqueness => boolean,
						:confirmation => boolean

540472. Custom validations
	#module class
	validate :custom_method

	private
	def custom_method
		if test_case
			errors. add(:attribute, "message")
		end
	end

	reload! #reload the validation u.valid?

540474. Cookies
	cookies[:username] = "jsmith"
	cookies[:username] = {
		:value => "jsmith",
		:expires => 1.wee.from_now
	}

	<%= cookies[:username] %>

	- Maximum data size: 4K (~4000 characters)
	- do not store sensitive data, may be altered by user

540475. Sessions
	- session stored on server side
	session[:username] = "jsmith"
	<%= session[:username] %>
	- Requires time to retrieve the session file
	- super cookies
	- Encrypted to prevent reading
	- Signed to prevent tampering
	- config/initializers/session_store.rb
	- config/secrets.yml

540476. Controller filters
	before_action
	before_action : find_subjects, :only => [:name, :create, :edit, :update]
	after_action
	around_action

	skip_before_action

	if params[:action] == 'new'
		@page_count += 1
	end

540477. Logging (Application log)
	log/development.rb
	log/production.rb
	log/test.rb

	config/environments/development.rb
	config.log_level = :debug

	rails log:clear
	logger.debug("The name is #{@subject.name}")
