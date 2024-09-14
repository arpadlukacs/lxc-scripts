# Info

I use LXC a lot under Linux and started to create some scripts a while ago to help me using it more easily.

The initial goal was to make the process of creating a new container as automatic as possible. I wanted to have smaller scripts with specific goals that could be combined together as needed.

Some parts are still work in progress or not used by me at all, but I added as reference for future (eg I use only IPv4). I have made these public, maybe someone will find them helpful as they are already.

I'm planning to do further improvements when I need more functionality, but bug reports, ideas and PRs are welcomed.

# Disclaimer

Use these scripts at your own risk. The author will not be liable for any losses and/or damages in connection with the use of the scripts available here.

# Dependencies

To manage /etc/hosts, I use [hosts-gen].

[hosts-gen]: https://r-36.net/scm/hosts-gen/

The scripts use [gum] for the text based interaction.

[gum]: https://github.com/charmbracelet/gum

It is installed automatically via install_gum by the scripts that uses it.

Some functionality requires using sudo, so for the best experience I suggest to configure passwordless sudo for your user.

# Example

The scripts contain some usage info, but here is an example on how to install Wordpress:

```sh
create_lxc_container -s wp6
```

After the above, you will have a fresh ubuntu:22.04 based LXC container, accessible via the hostname "wp6.arch" and your SSH key copied, so you can SSH into it with "ssh wp6.arch" without using any password.

(I have been using Arch Linux for years, that is why I use the ".arch" TLD. You can easily change that in add_host.)

Note: sshing into the system without specifying the user only works if you did what the script suggests at the end and added the host and user to your .ssh/config.

The configured system does not have anything yet, just the bare system. To install PHP 7.4, NGINX and MariaDB, we can use the following:

```sh
setup_services php7.4 | ssh wp6.arch sudo bash
```

If you open the host at that point, you should see NGINX's welcome page.

If you have wordpress's source in the wordpress folder, you can map into the container like that:

```sh
lxc_map_folder wp6 wordpress $(realpath wordpress) "/var/www/html"
```

For WP we need to make sure WP will be able to write the folder, use the following:

```sh
chmod a+w ./wordpress
```

After that you can open the host in a browser and you should see Wordpress's config page.
However, the scripts that we used so far did not create the database for us, because I usually import a DB dump which does that.

You can easily create a new DB with the following command:

```sh
echo "CREATE DATABASE wp6_test;" | ssh wp6.arch -C mysql -uroot -proot
```

Since everything that WP requires already installed / configured, you should be able to complete the setup for WP by specifying the details of DB. name: "wp6_test", username is "root", password is "root"

After that WP is up and running.

Note: Wordpress actually has a command line tool to install / setup a site that I do not use here. The point with the example was to show the steps required to have a running PHP based server for testing using the script. The default NGINX config is not customized for WP partically. It is just a minimal config for PHP.
