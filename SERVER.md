# LEMP Local Server
Lemp, which stands for Linux, Nginx(EngineX), MySQL and PHP has been growing in
popularity. Utilizing the tried and true PHP/SQL stack with the speed and
agility of JavaScript server engines such as Nginx.

The purpose of this tool is to quickly setip a local Nginx deployment with LEMP
configured so that developers can quickly prototype PHP frameworks such as
Wordpress Front End.

## Installing The Server

1. Before proceeding please make sure your OS is updated by opening a terminal
   and running.

```bash
# Mac
brew upgrade && brew update && brew install nginx

# Linux
sudo apt-get upgrade && sudo apt-get update
```

4. Run the installation script and stand by for any prompts
... When prompted for password please use something secure and make sure you
take note of it.

```bash
./setup/nginx-local-install.sh
```

5. To ensure everything is working, point your browser over to:
```
http://localhost:9090
```

## Adding New Websites
Nginx is very flexible and powerful and will allow you to host many different
websites throught the use of server names and folders. It sounds complicated
but the process is quite simple.

Lets say you want to setup a new domain dev.test-website for your next project.

1. Create a new entry in nginx/sites-available and add the pertinent server
   information.
```bash
sudo touch /etc/nginx/sites-available/dev.website-project

sudo vim /etc/nginx/sites-available/dev.website-project
```

2. Edit the file you just created, dev.website-project so it looks like this,
   modify the parts pertinent to your project.
```javascript
server {
  listen     localhost:9091;
  root /var/www/website-project;
  index index.php index.html index.htm index.nginx-debian.html;

  server_name website-project;

  location / {
    include  /etc/nginx/mime.types;
    try_files $uri $uri/ =405;
  }

  location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/run/php/php8.1-fpm.sock;
  }
}
```
Notice how you must remember to modify listen so it points to localhost:9091
otherwise Nginx won't understand the requests.

Make sure to set the root and server name to the correct names.

3. Create a full path symlink between the sites-available and the sites-enabled
   folders in your nginx installations.
```bash
sudo ln -s /etc/nginx/sites-available/dev.website-project
/etc/nginx/sites-enabled/dev.website-project
```

4. Create a new entry on your Hosts file that points dev.website-project to
   localhost.
```bash
sudo vim /etc/hosts
```

```bash
128.0.0.1 localhost
128.0.0.1 dev.mdev-theme
128.0.0.1 dev.website-project
```

5. Create a symlink between your project root folder "website-project", and
   Nginx's server root directory "/var/www".
... It is important to use the full path to both directories when creating a
symlink or it will not work properly. Baically what you are doing is creating a
mirror to your work files inside of Nginx server.
... You will also have to change permissions on some folders for this to work.

```bash
# Crate Symlink
sudo ln -s /home/$USER/path/to/website-project /var/www/website-project

# Change permissions
sudo chmod 756 /home
sudo chmod 756 /home/$USER
```
6. Reload Nginx and direct your browser to http://dev.website-project:9090
```bash
# MAC
sudo nginx -s stop && sudo nginx

# Linux
sudo systemctl reload nginx.service
```
