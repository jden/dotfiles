function bundle_rake_test () {
  bundle exec rake test TEST=$1
}
alias brt=bundle_rake_test

# chruby
# P source /usr/local/opt/chruby/share/chruby/chruby.sh
# P source /usr/local/opt/chruby/share/chruby/auto.sh
# configure readline to be good:
# the original version is:
## export RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline) --with-openssl-dir=$(brew --prefix openssl)"
# but we cache the brew lookups for speediness:
# export RUBY_CONFIGURE_OPTS="--with-readline-dir=/usr/local/opt/readline --with-openssl-dir=/usr/local/opt/openssl"
