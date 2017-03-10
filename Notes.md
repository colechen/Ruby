540385. rails new simple_cms -d mysql

540386. mysql -u root -p
	CREATE DATABASE simple_cms_development;
	CREATE DATABASE simple_cms_test;
	GRANT ALL PRIVILEGES ON simple_cms_development.* TO 'rails_user'@'localhost' IDENTIFIED BY 'secretpassword';
	GRANT ALL PRIVILEGES ON simple_cms_test.* TO 'rails_user'@'localhost' IDENTIFIED BY 'secretpassword';
	exit;

540387. database.yml -> specified the username and password
	Test Connection: rails db:schema:dump #get all the definition of database db/schema.rb

540389. rails generate controller demo index

540391. Simple Route -> get "demo/index"
	Simple Match Route -> match "demo/index", :to => "demo#index", :via => :get
	Default Route -> get ':controller(/:action(/:id))'
	Default Match Route -> match ':controller(/:action(/:id))', :via =? :get
	Root Route: root "demo#index"
	Root Match Route: match "/", :to => "demo#index", :via => :get 

540394. render(:template => 'demo/hello')
		render('demo/hello') #if calling different controller, will need to specify demo
		render('hello') #if calling in the same controller

		rendering will render to template, not action in the controller

540395. HTTP Redirect -> involve reloading, data will be gone, url change
		redirect_to(:controller => 'demo', :action => 'index')
		redirect_to(:action => 'index') #if calling in the same controller
		redirect_to('http://lynda.com')

540396. <% code %> #process ruby code, no output
		<%= code %> #output the end result
		<% target = "world" %>  <%= "Hello #{target}" %>
		<%= 3.times do |n|
				puts n
			end %> #output 3 in browser, output 0, 1, 2 in console
		<% 3.times do |n| %>
			<%= n %><br />
		<% end %> #output 0, 1, 2 in browser

540397. variable -> local variable
		@instance_variable -> only way to pass from controller to view

		@array = [1,2,3,4,5] #controller
		<% @array.each do |n| %> #view
			<%= n %><br />
		<% end %>

540398. <%= link_to(text, target) %> #link_to is a helper method
		<%= link_to("demo/index") %>
		<%= link_to('hello', {:controller => 'demo', :action => 'index'}) %> 
		<%= link_to('hello', {:action => 'index'}) %> 

540399. Accessing Parameter Values -> params are always string
		params[:id]
		params['id']

		<%= link_to('hello with parameters', {:action => 'hello', :page => 5, :id =>20}) %> -> http://localhost:3000/demo/hello?id=20&page=5

		get ':controller(/:action(/:id))' -> http://localhost:3000/demo/hello/20?page=5

		@id = params['id']
		@page = params[:page]

		@page.to_i + 1 #convert string to integer

540402. GRANT ALL PRIVILEGES ON db_name.* TO 'username'@'localhost' IDENTIFIED BY 'password';
		SHOW GRANTS FOR 'username'@'localhost';

		rails db:schema:dump

540404. rails generate migration MigrationName (camel case)

		migration file -> def up/down

540405. rails genearte model ModuleName (camel case)
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

540406. rails db:migrate
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

540407. rename_table(table, new_name)
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


540412. users = User.where(:first_name => "kevin")
		users = Users.order("last_name ASC").limit(5)

540413. rails genearte model SingularName (camel case)
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

540415. rails console development
		rails console
		rails c
		irb  #interactive ruby console

540416. rails console
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

540417.	subject = Subject.find(1)
		subject.new_record? #false
		subject.name = "Initial Subject"
		subject.save #will fire an UPDATE statement
		subject.update_at

		subject = Subject.find(2)
		subject.update_attributes(:name => 'Next Subject', :visible => true)

540418. subject = Subject.find(1)
		subject.destroy #will fire DELETE statement, still return current subject

540419. Primary key finder -> Subject.find(2)   #Returns an object of an error
		Dynamic finders -> Subject.find_by_id(2)	#Returns an object or nil
							Subject.find_by_name("First Subject")
		Find all -> Subject.all #Returns an array of objects
		Find first/last -> Subject.first
							Subject.last  #Returns an object of nil

		subjects = Subject.all
		subjects.each do |subject|
			puts subject.name
		end

540420. Subject.where(:vivible => true)
		Subject.where("name='Test' AND visible=true")  #SQL injection
		Subject.where(["name=? AND VISIBLE=true", "Test"]) #escaped SQL and safe
		Subject.where({:name => "Test", :visible => true})   #Hash, join with AND
		User.where(:last_name=>'Smith').where(:first_name => 'John')

		subjects.class
		subjects.to_sql

540421. Subject.order(:position).limit(20).offset(40)
		order(:position)
		order("position")
		order(:position => :asc)
		order("position ASC")
		order(:position => :desc)
		order("position DESC")

		subjects = Subject.order(:position DESC)
		subjects = Subject.limit(1).offset(2)
		subjects = Subject.where(:visible => true). order("position ASC").limit(1).offset(1)

540422. scope :active, lambda {where(:active => true)} #recommand lambda way
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

540425. For 1:1 relation (has_one, belongs_to), when making the association on objects, it 			does try to save the object to database

		Remove association -> subject.page = nil  #removes the association but does not remove the record

		Destroy record -> subject.page.destroy

540426. For 1:M relation (has_many, belongs_to),

		subject.pages << page
		subject.pages = [page, page, page]
		subject.pages.delete(page) #remove association
		subject.pages.destroy(page) #destroy the record
		subject.pages.clear #remove all pages
		subject.pages.empty? #check if array is empty
		subject.pages.size

540427. page.errors.full_messages  #error saving page when page needs to belongs_to a subject

		belongs_to :subject, { :optional => true }  #save without parent (subject_id)

540428. For M:N, require a join table with two foreign keys (simple join)
	
		Project has_and_belongs_to_many :collaborators

		#specify the join table name, otherwise, rails will use default naming convention
		has_and_belongs_to_many :admin_users, :join_table => 'pages_admin_users'

		create_table :admin_users_pages, :id => false do |t|
			t.integer "admin_user_id"
			t.integer "page_id"
		end
		add_index("admin_users_pages", ["admin_user_id", "page_id"])

540429. For M:N rich join (-ments, -ships)

		create_table :section_edits do|t|
			t.integer "admin_user_id"
			t.integer "section_id"
			t.string "summary"
			t.timestamps
		end
		add_index("section_edits", ['admin_user_id', 'section_id'])

		rails db:migrate

		#section_edits will have two parents, can not use << to add, must add directly to #sections_edits table with specified parent keys
		me = AdminUser.find(1)
		section = Section.create(:name => 'Section One', :position => 1)
		edit = SectionEdit.new(:summary => 'Test edit', :admin_user => me, :section => section)
		edit.save
		me.section_edits(true)   #reload from database

540530. section.section_edits.map {|se| se.admin_user}

		has_many :through
		AdminUser has_many :section_edits
		AdminUser has_many :sections, :through => :section_edits
