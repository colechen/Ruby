### Compare puma, unicorn, passenger
http://blog.scoutapp.com/articles/2017/02/10/which-ruby-app-server-is-right-for-you
1. Request buffering
In the Ruby app server ecosystem, both Puma and Passenger handle slow clients(client request taking too long due to slow network) in a similar fashion: request buffering. A separate process downloads incoming requests. Only when the request has completed is it passed on to an available worker. Unicorn can pair with Nginx which buffer the client request.

2. Clustering
To process more requests concurrently, your app server must support clustering: it must spawn multiple processes to execute application code on the same host across multiple requests. All three supports clustering.

3. Multithread
The most efficient way to tackle slow I/O is multithreading. A worker process spawns several worker threads inside of it. Each request is handled by one of those threads, but when it pauses for I/O - like waiting on a db query - another thread starts its work. This rapid back & forth makes best use of your RAM limitations, and keeps your CPU busy.

### Nginx + Puma + Postgres
https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04
1. Create Rails Application
```shell
rails new appname -d postgresql
cd appname
```
2. Create Production Database User
```shell
postgres createuser -s appname
postgres psql
\password appname      //Enter your desired password and confirm it.
```
3. Configure Database Connection
```shell
vi config/database.yml
```
    //Update the production section, ENV variable need to be export as global variable
    production:
    <<: *default
    host: localhost
    adapter: postgresql
    encoding: utf8
    database: appname_production
    pool: 5
    username: <%= ENV['APPNAME_DATABASE_USER'] %>
    password: <%= ENV['APPNAME_DATABASE_PASSWORD'] %>
    
4. Create Production Database
```shell
RAILS_ENV=production rake db:create
```
5. Generate a Controller
```shell
rails generate scaffold Task title:string note:text
RAILS_ENV=production rake db:migrate    // update the production database:
RAILS_ENV=production rake assets:precompile       // precompile the assets:
RAILS_ENV=production rails s --binding=server_public_IP    // bind it to the public IP address of your server
```
    http://server_public_IP:3000/tasks   // verify if it's available

6. Configure Puma

```shell
//look up the number of CPU cores your server has on Ubuntu
grep -c processor /proc/cpuinfo
vi config/puma.rb    //edit puma
```
```
# Change to match your CPU core count
workers 2   <--- Change the workers to number of processor

# Min and Max threads per worker
threads 1, 6

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

# Set up socket location
bind "unix://#{shared_dir}/sockets/puma.sock"

# Logging
stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end
```
```
//Create necessary directory
mkdir -p shared/pids shared/sockets shared/log
```
7. Install and Configure Nginx
```
brew install nginx
vi /usr/local/etc/nginx/nginx.conf
```
```
upstream app {
    # Path to Puma SOCK file, as defined previously
    server unix:/home/deploy/appname/shared/sockets/puma.sock fail_timeout=0;
}

server {
    # To start server on 80 will require root privilege, if rails is start on different 
    # user will cause premission issue
    listen 9080;        
    server_name localhost;

    root /home/deploy/appname/public;

    try_files $uri/index.html $uri @app;

    location @app {
        proxy_pass http://app;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
    }

    error_page 500 502 503 504 /500.html;
    client_max_body_size 4G;
    keepalive_timeout 10;
}
```
```
//stop and start nginx server
nginx -s stop
nginx
```
8. Verify in browser http://server_public_IP/tasks

### To config Nginx with ssl
https://letsencrypt.org/getting-started/
```
upstream app {
        unix:/home/deploy/appname/shared/sockets/puma.sock fail_timeout=0;
     }

server {
        listen       9080;
        server_name  123.123.123.123;
        rewrite ^(.*)$  https://$host$1 permanent;
}

# HTTPS server
    server {
        listen       443 ssl;
        server_name  123.123.123.123;

        ssl_certificate      /root/server.crt;
        ssl_certificate_key  /root/server.key;

        ssl_session_cache    shared:SSL:1m;
        ssl_session_timeout  5m;

        ssl_protocols  SSLv2 SSLv3 TLSv1;
        ssl_ciphers  HIGH:!aNULL:!MD5;
        ssl_prefer_server_ciphers  on;

        root /home/deploy/appname/public;

        location / {
            proxy_pass http://app; # match the name of upstream directive which is defined above
            proxy_set_header Host $host;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }

    }
```


### Trouble shooting
1. Start nginx before starting puma
2. shared/puma.stdout.log //check if there is any connection error (i.e. db connection, role does not exist)
3. rbenv-var did not work as expected, use global variable instead
